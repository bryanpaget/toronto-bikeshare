library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(knitr)
library(viridis)

# Simplified output directory setup
if (!dir.exists("docs")) dir.create("docs")
if (!dir.exists("docs/plots")) dir.create("docs/plots")

# Clear existing plot files
plot_files <- list.files("docs/plots", full.names = TRUE, pattern = "\\.png$")
if (length(plot_files) > 0) file.remove(plot_files)

# GBFS endpoints
endpoints <- list(
  system_regions = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_regions",
  system_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_information",
  station_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information",
  station_status = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status"
)

tryCatch({
  # Fetch station data
  station_info <- fromJSON(endpoints$station_information)$data$stations
  station_status <- fromJSON(endpoints$station_status)$data$stations
  
  # Merge station data
  stations <- station_info %>%
    left_join(station_status, by = "station_id") %>%
    select(station_id, name, capacity, num_bikes_available, num_docks_available, 
           last_reported, lat, lon, is_installed, is_renting, is_returning)
  
  # Calculate metrics with Toronto timezone
  timestamp <- as.POSIXct(stations$last_reported[1], origin = "1970-01-01", tz = "UTC") %>%
    with_tz(tzone = "America/Toronto")
  
  total_bikes <- sum(stations$num_bikes_available, na.rm = TRUE)
  total_docks <- sum(stations$num_docks_available, na.rm = TRUE)
  utilization_rate <- total_bikes / (total_bikes + total_docks) * 100
  active_stations <- sum(stations$is_installed == 1 & stations$is_renting == 1 & stations$is_returning == 1)
  
  # Calculate additional statistics
  avg_bikes_per_station <- mean(stations$num_bikes_available, na.rm = TRUE)
  median_capacity <- median(stations$capacity, na.rm = TRUE)
  empty_stations <- sum(stations$num_bikes_available == 0)
  full_stations <- sum(stations$num_docks_available == 0)
  
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
  
  # Generate README with enhanced content
  readme_content <- paste0(
    "# 🚲 Toronto Bike Share Analytics\n\n",
    "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), " (Toronto Time)\n\n",
    
    "## 📊 System Overview\n",
    "- **Total bikes available:** ", format(total_bikes, big.mark = ","), "\n",
    "- **Total docks available:** ", format(total_docks, big.mark = ","), "\n",
    "- **System utilization rate:** ", round(utilization_rate, 1), "%\n",
    "- **Active stations:** ", active_stations, "/", nrow(stations), " (", 
    round(active_stations/nrow(stations)*100, 1), "%)\n",
    "- **Average bikes per station:** ", round(avg_bikes_per_station, 1), "\n",
    "- **Median station capacity:** ", median_capacity, "\n",
    "- **Empty stations:** ", empty_stations, " (", round(empty_stations/nrow(stations)*100, 1), "%)\n",
    "- **Full stations:** ", full_stations, " (", round(full_stations/nrow(stations)*100, 1), "%)\n\n",
    
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
  
  writeLines(readme_content, "README.md")
  
}, error = function(e) {
  message("Error processing data: ", e$message)
  # Create error placeholder
  error_content <- paste(
    "# 🚨 Error in Bike Share Dashboard",
    "The automated update failed to process the bike share data.",
    "## Details:",
    paste("```", e$message, "```", sep = "\n"),
    sep = "\n\n"
  )
  writeLines(error_content, "README.md")
})