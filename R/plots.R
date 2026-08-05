# Static plot generation for the README.
#
# The interactive dashboard uses plotly; these static PNGs give GitHub
# README rendering a lightweight visual summary of the snapshot.

library(ggplot2)

# Remove stale PNG/HTML/widget assets from previous runs so plots/ only
# ever reflects the current snapshot. (HTML/widget files are legacy output
# from an earlier htmlwidgets-based approach.)
clean_stale_outputs <- function() {
  for (dir in c(PLOTS_DIR, TIME_SERIES_DIR)) {
    files <- list.files(dir, full.names = TRUE, pattern = "\\.(png|html)$")
    if (length(files) > 0) file.remove(files)
  }
  widget_dirs <- list.files(PLOTS_DIR, full.names = TRUE, pattern = "_files$")
  if (length(widget_dirs) > 0) unlink(widget_dirs, recursive = TRUE)
}

generate_static_plots <- function(stations, status_summary, availability_dist,
                                  historical_metrics, timestamp) {
  static_map <- ggplot(stations, aes(x = lon, y = lat,
                                     size = num_bikes_available, color = num_bikes_available)) +
    geom_point(alpha = 0.7) +
    scale_color_viridis_c(option = "plasma") +
    labs(title = "Bike Availability Across Toronto",
         subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
         x = "Longitude", y = "Latitude") +
    theme_minimal() +
    theme(legend.position = "bottom")
  ggsave(file.path(PLOTS_DIR, "location_plot.png"), static_map, width = 10, height = 8)

  status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
    geom_col() +
    geom_text(aes(label = n), vjust = -0.3) +
    labs(title = "Station Status Distribution",
         x = "Status", y = "Number of Stations") +
    scale_fill_viridis_d(option = "D", end = 0.8) +
    theme_minimal()
  ggsave(file.path(PLOTS_DIR, "status_distribution.png"), status_plot, width = 10, height = 6)

  dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
    geom_histogram(fill = "#1E88E5", bins = 20, color = "white") +
    labs(title = "Station Bike Availability Distribution",
         x = "Percentage of Bikes Available", y = "Number of Stations") +
    theme_minimal()
  ggsave(file.path(PLOTS_DIR, "availability_dist.png"), dist_plot, width = 10, height = 6)

  if (!is.null(historical_metrics) && nrow(historical_metrics) > 1) {
    bike_trend <- ggplot(historical_metrics, aes(x = timestamp)) +
      geom_line(aes(y = total_bikes, color = "Bikes"), linewidth = 1) +
      geom_line(aes(y = total_docks, color = "Docks"), linewidth = 1) +
      geom_line(aes(y = bikes_ma, color = "Bikes (7d MA)"), linetype = "dashed") +
      scale_color_manual(values = c("Bikes" = "#E41A1C", "Docks" = "#377EB8",
                                    "Bikes (7d MA)" = "#4DAF4A")) +
      labs(title = "Bike and Dock Availability Trend",
           x = "Date", y = "Count", color = "Metric") +
      theme_minimal() +
      theme(legend.position = "bottom")
    ggsave(file.path(TIME_SERIES_DIR, "bike_dock_trend.png"), bike_trend, width = 10, height = 6)

    util_trend <- ggplot(historical_metrics, aes(x = timestamp, y = utilization_rate)) +
      geom_line(color = "#984EA3", linewidth = 1) +
      geom_line(aes(y = utilization_ma), color = "#FF7F00", linetype = "dashed") +
      labs(title = "System Utilization Rate Trend",
           x = "Date", y = "Utilization Rate (%)") +
      theme_minimal()
    ggsave(file.path(TIME_SERIES_DIR, "utilization_trend.png"), util_trend, width = 10, height = 6)
  }

  invisible(NULL)
}
