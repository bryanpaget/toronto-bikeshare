library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(knitr)
library(viridis)
library(zoo)
library(plotly)
library(DT)
library(htmltools)
library(htmlwidgets)
library(leaflet)

# Create directories
dirs_to_create <- c("docs", "docs/plots", "docs/plots/time_series", "data")
for (dir in dirs_to_create) {
  if (!dir.exists(dir)) dir.create(dir)
}

# Clear existing plot and widget files
plot_files <- list.files("docs/plots", full.names = TRUE, pattern = "\\.png$")
if (length(plot_files) > 0) file.remove(plot_files)
html_files <- list.files("docs/plots", full.names = TRUE, pattern = "\\.html$")
if (length(html_files) > 0) file.remove(html_files)
widget_dirs <- list.files("docs/plots", full.names = TRUE, pattern = "_files$")
if (length(widget_dirs) > 0) unlink(widget_dirs, recursive = TRUE)

# GBFS endpoints
endpoints <- list(
  system_regions = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_regions",
  system_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_information",
  station_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information",
  station_status = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status"
)

# HTML helpers for the interactive dashboard
metric_card <- function(label, value) {
  paste0(
    '    <div class="col-lg-3 col-md-6">\n',
    '      <div class="card metric-card">\n',
    '        <div class="card-body">\n',
    '          <div class="metric-value">', value, '</div>\n',
    '          <div class="metric-label">', label, '</div>\n',
    '        </div>\n',
    '      </div>\n',
    '    </div>\n'
  )
}

generate_dashboard_html <- function(metrics, timestamp, has_history) {
  timestamp_str <- format(timestamp, "%Y-%m-%d %H:%M")

  history_html <- if (has_history) {
    paste0(
      '  <div class="row">\n',
      '    <div class="col-md-12">\n',
      '      <div class="plot-container">\n',
      '        <h3 class="section-title">Bike and Dock Availability Trend (Full History)</h3>\n',
      '        <iframe src="plots/time_series/bike_dock_trend.html" class="iframe-container w-100"></iframe>\n',
      '      </div>\n',
      '    </div>\n',
      '  </div>\n',
      '  <div class="row">\n',
      '    <div class="col-md-12">\n',
      '      <div class="plot-container">\n',
      '        <h3 class="section-title">System Utilization Rate Trend (Full History)</h3>\n',
      '        <iframe src="plots/time_series/utilization_trend.html" class="iframe-container w-100"></iframe>\n',
      '      </div>\n',
      '    </div>\n',
      '  </div>\n'
    )
  } else {
    ""
  }

  paste0(
    '<!DOCTYPE html>\n',
    '<html lang="en">\n',
    '<head>\n',
    '<meta charset="utf-8"/>\n',
    '<meta name="viewport" content="width=device-width, initial-scale=1"/>\n',
    '<title>Toronto Bike Share Dashboard</title>\n',
    '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"/>\n',
    '<style>\n',
    '  body { font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }\n',
    '  .card { border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; margin-bottom: 20px; }\n',
    '  .metric-card { background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%); color: white; text-align: center; }\n',
    '  .metric-value { font-size: 2.5rem; font-weight: bold; }\n',
    '  .metric-label { font-size: 1rem; opacity: 0.9; }\n',
    '  .section-title { border-bottom: 2px solid #2575fc; padding-bottom: 10px; margin-top: 30px; color: #2575fc; }\n',
    '  .plot-container { background-color: white; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }\n',
    '  .header { background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%); color: white; padding: 20px 0; margin-bottom: 30px; }\n',
    '  .footer { background-color: #343a40; color: white; padding: 20px 0; margin-top: 40px; }\n',
    '  .iframe-container { height: 500px; border: none; width: 100%; }\n',
    '  .small-iframe { height: 400px; }\n',
    '</style>\n',
    '</head>\n',
    '<body>\n',
    '<div class="header text-center">\n',
    '  <h1 class="display-4 fw-bold">🚲 Toronto Bike Share Dashboard</h1>\n',
    '  <h3 class="fw-light">Last updated: ', timestamp_str, '</h3>\n',
    '</div>\n',
    '<div class="container-fluid">\n',
    '  <div class="row">\n',
    metric_card("Bikes Available", format(metrics$total_bikes, big.mark = ",")),
    metric_card("Docks Available", format(metrics$total_docks, big.mark = ",")),
    metric_card("Utilization Rate", paste0(round(metrics$utilization_rate, 1), "%")),
    metric_card("Active Stations", paste0(metrics$active_stations, "/", metrics$total_stations)),
    '  </div>\n',
    '  <div class="row">\n',
    '    <div class="col-md-12">\n',
    '      <div class="plot-container">\n',
    '        <h3 class="section-title">📍 Live Bike Availability Map</h3>\n',
    '        <iframe src="plots/bike_map.html" class="iframe-container w-100"></iframe>\n',
    '      </div>\n',
    '    </div>\n',
    '  </div>\n',
    '  <div class="row">\n',
    '    <div class="col-md-6">\n',
    '      <div class="plot-container">\n',
    '        <h3 class="section-title">📊 Station Status Distribution</h3>\n',
    '        <iframe src="plots/status_distribution.html" class="iframe-container w-100 small-iframe"></iframe>\n',
    '      </div>\n',
    '    </div>\n',
    '    <div class="col-md-6">\n',
    '      <div class="plot-container">\n',
    '        <h3 class="section-title">📈 Bike Availability Distribution</h3>\n',
    '        <iframe src="plots/availability_dist.html" class="iframe-container w-100 small-iframe"></iframe>\n',
    '      </div>\n',
    '    </div>\n',
    '  </div>\n',
    history_html,
    '  <div class="row">\n',
    '    <div class="col-md-6">\n',
    '      <div class="plot-container">\n',
    '        <h3 class="section-title">🏆 Top Stations by Bike Availability</h3>\n',
    '        <iframe src="plots/bike_table.html" class="iframe-container w-100 small-iframe"></iframe>\n',
    '      </div>\n',
    '    </div>\n',
    '    <div class="col-md-6">\n',
    '      <div class="plot-container">\n',
    '        <h3 class="section-title">🏆 Top Stations by Dock Availability</h3>\n',
    '        <iframe src="plots/dock_table.html" class="iframe-container w-100 small-iframe"></iframe>\n',
    '      </div>\n',
    '    </div>\n',
    '  </div>\n',
    '</div>\n',
    '<div class="footer text-center">\n',
    '  <div class="container">\n',
    '    <p>Automatically generated with ❤️ using R and GitHub Actions</p>\n',
    '    <p>Last updated: ', timestamp_str, '</p>\n',
    '    <p>Data source: Toronto Bike Share GBFS API</p>\n',
    '  </div>\n',
    '</div>\n',
    '</body>\n',
    '</html>\n'
  )
}

tryCatch({
  # Fetch station data
  station_info <- fromJSON(endpoints$station_information)$data$stations
  station_status <- fromJSON(endpoints$station_status)$data$stations

  # Merge station data and convert numeric columns
  stations <- station_info %>%
    left_join(station_status, by = "station_id") %>%
    select(station_id, name, capacity, num_bikes_available, num_docks_available,
           last_reported, lat, lon, is_installed, is_renting, is_returning) %>%
    mutate(
      capacity = as.numeric(capacity),
      num_bikes_available = as.numeric(num_bikes_available),
      num_docks_available = as.numeric(num_docks_available)
    )

  # Calculate metrics with Toronto timezone
  timestamp <- as.POSIXct(stations$last_reported[1], origin = "1970-01-01", tz = "UTC") %>%
    with_tz(tzone = "America/Toronto")
  timestamp_str <- format(timestamp, "%Y%m%d_%H%M%S")

  total_bikes <- sum(stations$num_bikes_available, na.rm = TRUE)
  total_docks <- sum(stations$num_docks_available, na.rm = TRUE)
  utilization_rate <- total_bikes / (total_bikes + total_docks) * 100
  total_stations <- nrow(stations)
  active_stations <- sum(stations$is_installed == 1 & stations$is_renting == 1 & stations$is_returning == 1)

  # Calculate additional statistics
  avg_bikes_per_station <- mean(stations$num_bikes_available, na.rm = TRUE)
  median_capacity <- median(stations$capacity, na.rm = TRUE)
  empty_stations <- sum(stations$num_bikes_available == 0)
  full_stations <- sum(stations$num_docks_available == 0)

  # Create metrics dataframe
  current_metrics <- data.frame(
    timestamp = timestamp,
    total_bikes = total_bikes,
    total_docks = total_docks,
    utilization_rate = utilization_rate,
    active_stations = active_stations,
    total_stations = total_stations,
    active_pct = active_stations / total_stations * 100,
    avg_bikes_per_station = avg_bikes_per_station,
    median_capacity = median_capacity,
    empty_stations = empty_stations,
    empty_pct = empty_stations / total_stations * 100,
    full_stations = full_stations,
    full_pct = full_stations / total_stations * 100
  )

  # Define consolidated file paths
  consolidated_metrics_path <- "data/consolidated_metrics.csv"
  consolidated_stations_path <- "data/consolidated_stations.csv"

  # Check if consolidated files exist, if not create them
  if (!file.exists(consolidated_metrics_path)) {
    write.csv(current_metrics, consolidated_metrics_path, row.names = FALSE)
    cat("Created new consolidated metrics file\n")
  } else {
    # Append current metrics to consolidated file
    write.table(current_metrics, consolidated_metrics_path,
                sep = ",", append = TRUE, col.names = FALSE, row.names = FALSE)
    cat("Appended metrics to consolidated file\n")
  }

  # Add timestamp to stations data to identify when it was captured
  stations$capture_timestamp <- timestamp

  if (!file.exists(consolidated_stations_path)) {
    write.csv(stations, consolidated_stations_path, row.names = FALSE)
    cat("Created new consolidated stations file\n")
  } else {
    # Append current stations to consolidated file
    write.table(stations, consolidated_stations_path,
                sep = ",", append = TRUE, col.names = FALSE, row.names = FALSE)
    cat("Appended stations to consolidated file\n")
  }

  # Load historical metrics from consolidated file
  if (file.exists(consolidated_metrics_path)) {
    historical_metrics <- read.csv(consolidated_metrics_path) %>%
      mutate(timestamp = as.POSIXct(timestamp))
  } else {
    historical_metrics <- current_metrics
  }

  # Process historical data
  historical_metrics <- historical_metrics %>%
    arrange(timestamp) %>%
    distinct(timestamp, .keep_all = TRUE) %>%
    mutate(
      date = as.Date(timestamp),
      bikes_ma = rollmean(total_bikes, k = 7, fill = NA, align = "right"),
      utilization_ma = rollmean(utilization_rate, k = 7, fill = NA, align = "right")
    )

  # Calculate deltas if we have previous data
  if (nrow(historical_metrics) > 1) {
    prev_metrics <- tail(historical_metrics, 2)[1, ]

    deltas <- list(
      total_bikes = current_metrics$total_bikes - prev_metrics$total_bikes,
      total_docks = current_metrics$total_docks - prev_metrics$total_docks,
      utilization_rate = current_metrics$utilization_rate - prev_metrics$utilization_rate,
      active_stations = current_metrics$active_stations - prev_metrics$active_stations,
      active_pct = current_metrics$active_pct - prev_metrics$active_pct,
      avg_bikes_per_station = current_metrics$avg_bikes_per_station - prev_metrics$avg_bikes_per_station,
      empty_stations = current_metrics$empty_stations - prev_metrics$empty_stations,
      empty_pct = current_metrics$empty_pct - prev_metrics$empty_pct,
      full_stations = current_metrics$full_stations - prev_metrics$full_stations,
      full_pct = current_metrics$full_pct - prev_metrics$full_pct
    )

    # Format deltas for display
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

      if (is_pct) {
        paste0(prefix, sprintf("%.1f%%", abs_val))
      } else {
        paste0(prefix, format(abs_val, big.mark = ","))
      }
    }

    delta_formatted <- list(
      total_bikes = format_delta(deltas$total_bikes),
      total_docks = format_delta(deltas$total_docks),
      utilization_rate = format_delta(deltas$utilization_rate, TRUE),
      active_stations = format_delta(deltas$active_stations),
      active_pct = format_delta(deltas$active_pct, TRUE),
      avg_bikes_per_station = format_delta(deltas$avg_bikes_per_station),
      empty_stations = format_delta(deltas$empty_stations),
      empty_pct = format_delta(deltas$empty_pct, TRUE),
      full_stations = format_delta(deltas$full_stations),
      full_pct = format_delta(deltas$full_pct, TRUE)
    )
  } else {
    delta_formatted <- lapply(current_metrics[-1], function(x) "N/A")
  }

  # Top stations by bike availability
  top_bike_stations <- stations %>%
    arrange(desc(num_bikes_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_bikes_available, capacity)

  # Top stations by dock availability
  top_dock_stations <- stations %>%
    arrange(desc(num_docks_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_docks_available, capacity)

  # Station status summary
  status_summary <- stations %>%
    mutate(status = case_when(
      num_bikes_available == 0 ~ "Empty",
      num_docks_available == 0 ~ "Full",
      TRUE ~ "Available"
    )) %>%
    count(status)

  # Bike availability distribution
  availability_dist <- stations %>%
    mutate(availability_pct = num_bikes_available / capacity * 100) %>%
    filter(!is.na(availability_pct))

  # Save static map for README
  static_map <- ggplot(stations, aes(x = lon, y = lat, size = num_bikes_available, color = num_bikes_available)) +
    geom_point(alpha = 0.7) +
    scale_color_viridis_c(option = "plasma") +
    labs(title = "Bike Availability Across Toronto",
         subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
         x = "Longitude", y = "Latitude") +
    theme_minimal() +
    theme(legend.position = "bottom")

  ggsave("docs/plots/location_plot.png", static_map, width = 10, height = 8)

  # Station status distribution plot
  status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
    geom_col() +
    geom_text(aes(label = n), vjust = -0.3) +
    labs(title = "Station Status Distribution",
         x = "Status", y = "Number of Stations") +
    scale_fill_viridis_d(option = "D", end = 0.8) +
    theme_minimal()

  ggsave("docs/plots/status_distribution.png", status_plot, width = 10, height = 6)

  # Bike availability distribution plot
  dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
    geom_histogram(fill = "#1E88E5", bins = 20, color = "white") +
    labs(title = "Station Bike Availability Distribution",
         x = "Percentage of Bikes Available", y = "Number of Stations") +
    theme_minimal()

  ggsave("docs/plots/availability_dist.png", dist_plot, width = 10, height = 6)

  # Interactive map
  pal <- colorNumeric(viridis(10), domain = stations$num_bikes_available)
  bike_map <- leaflet(stations) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~lat, lng = ~lon,
      radius = ~sqrt(num_bikes_available + 1) * 2,
      color = ~pal(num_bikes_available),
      stroke = FALSE, fillOpacity = 0.8,
      popup = ~paste("<b>", name, "</b><br>",
                     "Bikes: ", num_bikes_available, "<br>",
                     "Docks: ", num_docks_available, "<br>",
                     "Capacity: ", capacity)
    ) %>%
    addLegend(position = "bottomright", pal = pal, values = ~num_bikes_available, title = "Bikes Available")
  saveWidget(bike_map, "docs/plots/bike_map.html", selfcontained = TRUE)

  # Interactive charts
  saveWidget(ggplotly(status_plot), "docs/plots/status_distribution.html", selfcontained = TRUE)
  saveWidget(ggplotly(dist_plot), "docs/plots/availability_dist.html", selfcontained = TRUE)

  # Interactive tables
  bike_table <- datatable(
    top_bike_stations,
    colnames = c("Station", "Bikes Available", "Capacity"),
    options = list(dom = "t", pageLength = 10, paging = FALSE, searching = FALSE)
  )
  saveWidget(bike_table, "docs/plots/bike_table.html", selfcontained = TRUE)

  dock_table <- datatable(
    top_dock_stations,
    colnames = c("Station", "Docks Available", "Capacity"),
    options = list(dom = "t", pageLength = 10, paging = FALSE, searching = FALSE)
  )
  saveWidget(dock_table, "docs/plots/dock_table.html", selfcontained = TRUE)

  # Time series plots with linewidth instead of size
  if (nrow(historical_metrics) > 1) {
    # Bike and dock trends (static)
    bike_trend <- ggplot(historical_metrics, aes(x = timestamp)) +
      geom_line(aes(y = total_bikes, color = "Bikes"), linewidth = 1) +
      geom_line(aes(y = total_docks, color = "Docks"), linewidth = 1) +
      geom_line(aes(y = bikes_ma, color = "Bikes (7d MA)"), linetype = "dashed") +
      scale_color_manual(values = c("Bikes" = "#E41A1C", "Docks" = "#377EB8", "Bikes (7d MA)" = "#4DAF4A")) +
      labs(title = "Bike and Dock Availability Trend",
           x = "Date", y = "Count", color = "Metric") +
      theme_minimal() +
      theme(legend.position = "bottom")

    ggsave("docs/plots/time_series/bike_dock_trend.png", bike_trend, width = 10, height = 6)

    # Utilization trend (static)
    util_trend <- ggplot(historical_metrics, aes(x = timestamp, y = utilization_rate)) +
      geom_line(color = "#984EA3", linewidth = 1) +
      geom_line(aes(y = utilization_ma), color = "#FF7F00", linetype = "dashed") +
      labs(title = "System Utilization Rate Trend",
           x = "Date", y = "Utilization Rate (%)") +
      theme_minimal()

    ggsave("docs/plots/time_series/utilization_trend.png", util_trend, width = 10, height = 6)

    # Interactive full-history time series for the dashboard
    bike_trend_html <- plot_ly(historical_metrics, x = ~timestamp) %>%
      add_lines(y = ~total_bikes, name = "Bikes", line = list(color = "#E41A1C")) %>%
      add_lines(y = ~total_docks, name = "Docks", line = list(color = "#377EB8")) %>%
      add_lines(y = ~bikes_ma, name = "Bikes (7d MA)", line = list(color = "#4DAF4A", dash = "dash")) %>%
      layout(title = "Bike and Dock Availability Trend (Full History)",
             xaxis = list(title = "Date"),
             yaxis = list(title = "Count"),
             legend = list(orientation = "h"))
    saveWidget(bike_trend_html, "docs/plots/time_series/bike_dock_trend.html", selfcontained = TRUE)

    util_trend_html <- plot_ly(historical_metrics, x = ~timestamp) %>%
      add_lines(y = ~utilization_rate, name = "Utilization Rate", line = list(color = "#984EA3")) %>%
      add_lines(y = ~utilization_ma, name = "7d MA", line = list(color = "#FF7F00", dash = "dash")) %>%
      layout(title = "System Utilization Rate Trend (Full History)",
             xaxis = list(title = "Date"),
             yaxis = list(title = "Utilization Rate (%)"),
             legend = list(orientation = "h"))
    saveWidget(util_trend_html, "docs/plots/time_series/utilization_trend.html", selfcontained = TRUE)
  }

  # Generate README with enhanced content
  readme_content <- paste0(
    "# 🚲 Toronto Bike Share Analytics\n\n",
    "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), " (Toronto Time)\n\n",

    "## 🖥️ Live Dashboard\n",
    "View the interactive dashboard with the full history of bike availability: ",
    "[https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)\n\n",

    "## 📊 System Overview\n",
    "| Metric | Value | Change |\n",
    "|--------|-------|--------|\n",
    "| **Total bikes available** | ", format(total_bikes, big.mark = ","), " | ", delta_formatted$total_bikes, " |\n",
    "| **Total docks available** | ", format(total_docks, big.mark = ","), " | ", delta_formatted$total_docks, " |\n",
    "| **System utilization rate** | ", round(utilization_rate, 1), "% | ", delta_formatted$utilization_rate, " |\n",
    "| **Active stations** | ", active_stations, "/", total_stations, " (",
    round(active_stations/total_stations*100, 1), "%) | ", delta_formatted$active_stations, " |\n",
    "| **Average bikes per station** | ", round(avg_bikes_per_station, 1), " | ", delta_formatted$avg_bikes_per_station, " |\n",
    "| **Median station capacity** | ", median_capacity, " | - |\n",
    "| **Empty stations** | ", empty_stations, " (", round(empty_stations/total_stations*100, 1), "%) | ", delta_formatted$empty_stations, " |\n",
    "| **Full stations** | ", full_stations, " (", round(full_stations/total_stations*100, 1), "%) | ", delta_formatted$full_stations, " |\n\n",

    "## 🏆 Top 10 Stations by Bike Availability\n",
    "| Station | Bikes Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_bike_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## 🏆 Top 10 Stations by Dock Availability\n",
    "| Station | Docks Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_dock_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## 📊 Station Status Distribution\n",
    "| Status     | Number of Stations |\n",
    "|------------|-------------------:|\n",
    "| Empty      | ", status_summary$n[status_summary$status == "Empty"], " |\n",
    "| Full       | ", status_summary$n[status_summary$status == "Full"], " |\n",
    "| Available  | ", status_summary$n[status_summary$status == "Available"], " |\n\n",

    "## 📍 Bike Locations\n",
    "![Bike Locations](docs/plots/location_plot.png)\n\n",

    "## 📊 Station Status Distribution\n",
    "![Status Distribution](docs/plots/status_distribution.png)\n\n",

    "## 📈 Bike Availability Distribution\n",
    "![Availability Distribution](docs/plots/availability_dist.png)\n\n",

    if (nrow(historical_metrics) > 1) {
      paste0(
        "## 📈 Historical Trends\n",
        "### Bike and Dock Availability\n",
        "![Bike and Dock Trend](docs/plots/time_series/bike_dock_trend.png)\n\n",
        "### System Utilization Rate\n",
        "![Utilization Trend](docs/plots/time_series/utilization_trend.png)\n\n"
      )
    } else "",

    "## 📊 Sampling Methodology\n",
    "The data is collected from the Toronto Bike Share GBFS API at a single point in time. ",
    "This provides a snapshot of the system but may not capture temporal variations.\n\n",

    "### Key Metrics Explained\n",
    "1. **Utilization Rate**: The proportion of total bike slots that are occupied by bikes:\n",
    "   $$\\text{Utilization Rate} = \\frac{\\text{Total Bikes}}{\\text{Total Bikes} + \\text{Total Docks}} \\times 100\\%$$\n\n",
    "2. **Station Status Classification**:\n",
    "   - **Empty**: $\\text{bikes} = 0$\n",
    "   - **Full**: $\\text{docks} = 0$\n",
    "   - **Available**: $\\text{bikes} > 0$ and $\\text{docks} > 0$\n\n",

    "### Statistical Notes\n",
    "- The distribution of bikes across stations follows a ",
    ifelse(mean(availability_dist$availability_pct) > median(availability_dist$availability_pct),
           "right-skewed", "left-skewed"), " distribution\n",
    "- The mean availability is ", round(mean(availability_dist$availability_pct), 1), "% ",
    "with a standard deviation of ", round(sd(availability_dist$availability_pct), 1), "%\n",
    "- The system is currently operating at ", round(utilization_rate), "% capacity\n\n",

    "## ℹ️ Data Source\n",
    "Data is sourced from the [Toronto Bike Share GBFS API]",
    "(https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)"
  )

  # Run predictive model and append predictions to README
  source("predictive_model.R")
  prediction_results <- run_predictive_model()
  predictions_markdown <- format_predictions_for_readme(prediction_results$predictions, prediction_results$events_data)

  readme_content <- paste0(readme_content, "\n\n", predictions_markdown)

  writeLines(readme_content, "README.md")

  # Generate interactive dashboard
  dashboard_html <- generate_dashboard_html(current_metrics, timestamp, nrow(historical_metrics) > 1)
  writeLines(dashboard_html, "docs/index.html")
  cat("Generated docs/index.html dashboard\n")

}, error = function(e) {
  message("Error processing data: ", conditionMessage(e))
  # Create error placeholder
  error_content <- paste(
    "# 🚨 Error in Bike Share Dashboard",
    "The automated update failed to process the bike share data.",
    "## Details:",
    paste("```", conditionMessage(e), "```", sep = "\n"),
    sep = "\n\n"
  )
  writeLines(error_content, "README.md")
  writeLines(
    paste0(
      '<!DOCTYPE html>\n<html lang="en"><head><meta charset="utf-8"/>\n',
      '<title>Toronto Bike Share Dashboard</title></head>\n',
      '<body style="font-family:sans-serif;text-align:center;padding-top:60px;">\n',
      '<h1>🚨 Error in Bike Share Dashboard</h1>\n',
      '<p>The automated update failed to process the bike share data.</p>\n',
      '<pre>', htmltools::htmlEscape(conditionMessage(e)), '</pre>\n',
      '</body></html>\n'
    ),
    "docs/index.html"
  )
})
