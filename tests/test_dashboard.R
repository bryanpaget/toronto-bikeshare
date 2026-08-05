# Unit tests for interactive dashboard generation (R/dashboard.R).

args <- commandArgs()
script_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
root <- if (length(script_arg) && nzchar(script_arg)) {
  normalizePath(file.path(dirname(script_arg), ".."))
} else {
  getwd()
}
suppressPackageStartupMessages({library(dplyr); library(lubridate)})
source(file.path(root, "R", "config.R"))
source(file.path(root, "R", "utils.R"))
source(file.path(root, "R", "dashboard.R"))

metrics <- list(
  total_bikes = 6461, total_docks = 12519, utilization_rate = 34.0,
  active_stations = 1029, total_stations = 1029
)
delta_formatted <- list(
  total_bikes = "+120", total_docks = "-30", utilization_rate = "+1.2%", active_stations = "+1"
)
ts <- as.POSIXct("2026-05-25 13:49:18", tz = "America/Toronto")

stations <- data.frame(
  name = c("Station A", "Station B", "Station C"),
  num_bikes_available = c(0, 12, 5),
  num_docks_available = c(14, 0, 9),
  capacity = c(14, 12, 14),
  lat = c(43.64, 43.66, 43.68),
  lon = c(-79.38, -79.40, -79.35)
)

historical_metrics <- data.frame(
  timestamp = seq(as.POSIXct("2026-05-01 12:00:00", tz = "UTC"), by = "day", length.out = 30),
  total_bikes = runif(30, 6000, 7000),
  total_docks = 12500,
  utilization_rate = runif(30, 30, 40),
  active_stations = runif(30, 1000, 1029),
  avg_bikes_per_station = runif(30, 5, 8),
  empty_pct = runif(30, 10, 20),
  full_pct = runif(30, 2, 6)
) %>%
  dplyr::mutate(
    bikes_ma = zoo::rollmean(total_bikes, 7, fill = NA, align = "right"),
    utilization_ma = zoo::rollmean(utilization_rate, 7, fill = NA, align = "right")
  )

prediction_results <- list(
  events_data = data.frame(
    event_title = c("Concert at Place", "Food festival"),
    event_description = "music and food",
    event_link = c("https://example.com/a", ""),
    event_date = as.Date(c("2026-05-26", "2026-05-27")),
    source = c("blogTO", "Now Toronto"),
    category = c("Concert", "Food Festival")
  ),
  predictions = data.frame(
    station_name = c("Station A", "Station B"),
    predicted_demand_change_pct = c(35.0, -20.0),
    recommended_action = c("ADD_BIKES", "REMOVE_BIKES"),
    confidence_level = c(0.8, 0.6),
    event_impact = c("Concert", "Food Festival")
  ),
  recommendations = data.frame(
    station_name = "Station A",
    predicted_demand_change_pct = 35.0,
    recommended_action = "ADD_BIKES",
    event_impact = "Concert"
  )
)

status_summary <- data.frame(status = c("Available", "Empty", "Full"), n = c(600, 200, 120))
availability_dist <- data.frame(availability_pct = c(10, 50, 90, 100))

html <- generate_dashboard_html(metrics, delta_formatted, ts,
                                historical_metrics, stations, prediction_results,
                                status_summary, availability_dist)
stopifnot(grepl("<!DOCTYPE html>", html))
stopifnot(grepl("6,461", html))          # big.mark formatting
stopifnot(grepl("34%", html))            # utilization
stopifnot(grepl("1029/1029", html))      # active stations
stopifnot(!grepl("bike_map.html", html)) # old saveWidget widgets removed
stopifnot(!grepl("time_series/", html))
stopifnot(grepl("2026-05-25 13:49", html))
cat("full version OK, length:", nchar(html), "\n")

# embedded JSON must be valid and row-oriented for stations
m <- regmatches(html, regexpr("window\\.DASHBOARD_DATA = \\{.*\\};</script>", html))
stopifnot(length(m) == 1)
js <- sub("window\\.DASHBOARD_DATA = ", "", sub(";</script>$", "", m))
stopifnot(jsonlite::validate(js))
payload <- jsonlite::fromJSON(js)
stopifnot(is.data.frame(payload$stations) && nrow(payload$stations) == nrow(stations))
stopifnot(setequal(names(payload$stations), c("name", "lat", "lon", "bikes", "docks", "capacity", "status")))
stopifnot("ts-main" %in% names(payload$charts) && "corr" %in% names(payload$charts))
cat("embedded JSON valid; stations row-oriented OK\n")

# all chart divs present
for (cid in c("chart-ts-main", "chart-ts-util", "chart-hist-avail", "chart-status",
              "chart-corr", "chart-wd-hour", "chart-scatter")) {
  stopifnot(grepl(paste0("id=\"", cid, "\""), html))
}
# all table ids present
for (tid in c("tbl-top-bikes", "tbl-top-docks", "tbl-events", "tbl-predictions",
              "tbl-recommendations", "tbl-stations", "tbl-history")) {
  stopifnot(grepl(paste0("id=\"", tid, "\""), html))
}
# slicer + map ids present
for (mid in c("slicer-start", "slicer-end", "map", "map-search", "map-status", "map-count")) {
  stopifnot(grepl(paste0("id=\"", mid, "\""), html))
}
cat("all chart/table/map/slicer DOM ids OK\n")

# badges rendered (category + action + status)
stopifnot(grepl("badge concert", html))
stopifnot(grepl("badge add-bikes", html))
stopifnot(grepl("badge st-empty", html))
cat("badges OK\n")

# duplicate html tag check
stopifnot(length(gregexpr("</html>", html, fixed = TRUE)[[1]]) == 1)
cat("exactly one </html> tag OK\n")

# no-history version still renders
html2 <- generate_dashboard_html(metrics, delta_formatted, ts,
                                 historical_metrics[1, ], stations, prediction_results,
                                 status_summary, availability_dist)
stopifnot(grepl("<!DOCTYPE html>", html2))
m2 <- regmatches(html2, regexpr("window\\.DASHBOARD_DATA = \\{.*\\};</script>", html2))
js2 <- sub("window\\.DASHBOARD_DATA = ", "", sub(";</script>$", "", m2))
payload2 <- jsonlite::fromJSON(js2)
stopifnot(!"ts-main" %in% names(payload2$charts))
stopifnot(!"ts-util" %in% names(payload2$charts))
cat("no-history version OK, length:", nchar(html2), "\n")

cat("ALL DASHBOARD TESTS PASSED\n")
