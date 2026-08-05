# Data acquisition and persistence for the GBFS snapshot pipeline.
#
# Responsibilities:
#   * fetch_station_data  - pull live station information + status from the GBFS API
#   * compute_metrics     - aggregate the snapshot into a single metrics row
#   * persist_snapshot    - append the snapshot to the consolidated CSV files
#   * load_history        - read and pre-process the full metric history
#   * compute_deltas      - format changes vs the previous snapshot for display
#   * derive_summaries    - derived tables used by the README and dashboard

library(dplyr)

fetch_station_data <- function() {
  station_info <- jsonlite::fromJSON(GBFS_ENDPOINTS$station_information)$data$stations
  station_status <- jsonlite::fromJSON(GBFS_ENDPOINTS$station_status)$data$stations

  station_info %>%
    left_join(station_status, by = "station_id") %>%
    select(station_id, name, capacity, num_bikes_available, num_docks_available,
           last_reported, lat, lon, is_installed, is_renting, is_returning) %>%
    mutate(
      capacity = as.numeric(capacity),
      num_bikes_available = as.numeric(num_bikes_available),
      num_docks_available = as.numeric(num_docks_available)
    )
}

compute_metrics <- function(stations, timestamp) {
  total_bikes <- sum(stations$num_bikes_available, na.rm = TRUE)
  total_docks <- sum(stations$num_docks_available, na.rm = TRUE)
  total_stations <- nrow(stations)
  active_stations <- sum(stations$is_installed == 1 & stations$is_renting == 1 &
                           stations$is_returning == 1)

  data.frame(
    timestamp = timestamp,
    total_bikes = total_bikes,
    total_docks = total_docks,
    utilization_rate = total_bikes / (total_bikes + total_docks) * 100,
    active_stations = active_stations,
    total_stations = total_stations,
    active_pct = active_stations / total_stations * 100,
    avg_bikes_per_station = mean(stations$num_bikes_available, na.rm = TRUE),
    median_capacity = median(stations$capacity, na.rm = TRUE),
    empty_stations = sum(stations$num_bikes_available == 0),
    empty_pct = sum(stations$num_bikes_available == 0) / total_stations * 100,
    full_stations = sum(stations$num_docks_available == 0),
    full_pct = sum(stations$num_docks_available == 0) / total_stations * 100
  )
}

persist_snapshot <- function(current_metrics, stations, timestamp) {
  stations$capture_timestamp <- timestamp

  if (!file.exists(METRICS_FILE)) {
    write.csv(current_metrics, METRICS_FILE, row.names = FALSE)
    cat("Created new consolidated metrics file\n")
  } else {
    write.table(current_metrics, METRICS_FILE, sep = ",", append = TRUE,
                col.names = FALSE, row.names = FALSE)
    cat("Appended metrics to consolidated file\n")
  }

  if (!file.exists(STATIONS_FILE)) {
    write.csv(stations, STATIONS_FILE, row.names = FALSE)
    cat("Created new consolidated stations file\n")
  } else {
    write.table(stations, STATIONS_FILE, sep = ",", append = TRUE,
                col.names = FALSE, row.names = FALSE)
    cat("Appended stations to consolidated file\n")
  }
}

load_history <- function() {
  if (!file.exists(METRICS_FILE)) return(NULL)

  read.csv(METRICS_FILE, stringsAsFactors = FALSE) %>%
    mutate(timestamp = as.POSIXct(timestamp)) %>%
    arrange(timestamp) %>%
    distinct(timestamp, .keep_all = TRUE) %>%
    mutate(
      date = as.Date(timestamp),
      bikes_ma = zoo::rollmean(total_bikes, k = 7, fill = NA, align = "right"),
      utilization_ma = zoo::rollmean(utilization_rate, k = 7, fill = NA, align = "right")
    )
}

# Names shared by the delta list produced here and the fallback "N/A" list.
DELTA_KEYS <- c("total_bikes", "total_docks", "utilization_rate", "active_stations",
                "active_pct", "avg_bikes_per_station", "empty_stations", "empty_pct",
                "full_stations", "full_pct")

compute_deltas <- function(current_metrics, historical_metrics) {
  format_delta <- function(x, is_pct = FALSE) {
    if (is.na(x)) return("N/A")
    if (x > 0) {
      prefix <- "+"
    } else if (x < 0) {
      prefix <- "-"
    } else {
      return("")
    }
    abs_val <- abs(if (is_pct) x else round(x))
    if (is_pct) paste0(prefix, sprintf("%.1f%%", abs_val))
    else paste0(prefix, format(abs_val, big.mark = ","))
  }

  no_delta <- function() setNames(as.list(rep("N/A", length(DELTA_KEYS))), DELTA_KEYS)
  if (is.null(historical_metrics) || nrow(historical_metrics) < 2) return(no_delta())

  prev <- tail(historical_metrics, 2)[1, ]
  delta <- function(key) current_metrics[[key]] - prev[[key]]

  list(
    total_bikes = format_delta(delta("total_bikes")),
    total_docks = format_delta(delta("total_docks")),
    utilization_rate = format_delta(delta("utilization_rate"), TRUE),
    active_stations = format_delta(delta("active_stations")),
    active_pct = format_delta(delta("active_pct"), TRUE),
    avg_bikes_per_station = format_delta(delta("avg_bikes_per_station")),
    empty_stations = format_delta(delta("empty_stations")),
    empty_pct = format_delta(delta("empty_pct"), TRUE),
    full_stations = format_delta(delta("full_stations")),
    full_pct = format_delta(delta("full_pct"), TRUE)
  )
}

derive_summaries <- function(stations) {
  status_summary <- stations %>%
    mutate(status = case_when(
      num_bikes_available == 0 ~ "Empty",
      num_docks_available == 0 ~ "Full",
      TRUE ~ "Available"
    )) %>%
    count(status)

  availability_dist <- stations %>%
    mutate(availability_pct = num_bikes_available / capacity * 100) %>%
    filter(!is.na(availability_pct))

  top_bike_stations <- stations %>%
    arrange(desc(num_bikes_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_bikes_available, capacity)

  top_dock_stations <- stations %>%
    arrange(desc(num_docks_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_docks_available, capacity)

  list(
    status_summary = status_summary,
    availability_dist = availability_dist,
    top_bike_stations = top_bike_stations,
    top_dock_stations = top_dock_stations
  )
}
