library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(knitr)
library(tidyr)
library(arrow)

# Clean output folders
unlink("data", recursive = TRUE)
unlink("plots", recursive = TRUE)
dir.create("data", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# GBFS endpoints
gbfs_endpoints <- fromJSON("https://tor.publicbikesystem.net/ube/gbfs/gbfs.json")
feeds <- gbfs_endpoints$data$en$feeds

# Get station information
station_info_url <- feeds$url[feeds$name == "station_information"]
station_status_url <- feeds$url[feeds$name == "station_status"]

# Fetch station data
station_info <- fromJSON(station_info_url)$data$stations
station_status <- fromJSON(station_status_url)$data$stations

# Merge station data
stations <- station_info %>%
  left_join(station_status, by = "station_id") %>%
  select(station_id, name, capacity, num_bikes_available, num_docks_available, 
         last_reported, lat, lon, is_installed, is_renting, is_returning)

# Calculate metrics
timestamp <- as.POSIXct(stations$last_reported[1], origin = "1970-01-01")
total_bikes <- sum(stations$num_bikes_available, na.rm = TRUE)
total_docks <- sum(stations$num_docks_available, na.rm = TRUE)
utilization_rate <- total_bikes / (total_bikes + total_docks) * 100
active_stations <- sum(stations$is_installed == 1 & stations$is_renting == 1 & stations$is_returning == 1)

# Top stations by bike availability
top_bike_stations <- stations %>%
  arrange(desc(num_bikes_available)) %>%
  slice_head(n = 5) %>%
  select(name, num_bikes_available, capacity)

# Top stations by dock availability
top_dock_stations <- stations %>%
  arrange(desc(num_docks_available)) %>%
  slice_head(n = 5) %>%
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

# Simple location plot without ggmap
location_plot <- ggplot(stations, aes(x = lon, y = lat, size = num_bikes_available, color = num_bikes_available)) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "yellow", high = "red") +
  labs(title = "Bike Availability Across Toronto",
       subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
       x = "Longitude", y = "Latitude") +
  theme_minimal()

ggsave("plots/location_plot.png", location_plot, width = 10, height = 8)

# Availability distribution plot
dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
  geom_histogram(fill = "#1E88E5", bins = 20) +
  labs(title = "Station Bike Availability Distribution",
       x = "Percentage of Bikes Available", y = "Number of Stations") +
  theme_minimal()

ggsave("plots/availability_dist.png", dist_plot, width = 10, height = 6)

# Status distribution plot
status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
  geom_col() +
  geom_text(aes(label = n), vjust = -0.3) +
  labs(title = "Station Status Distribution", 
       x = "Status", y = "Number of Stations") +
  scale_fill_manual(values = c("Available" = "#4CAF50", "Empty" = "#F44336", "Full" = "#FFC107")) +
  theme_minimal()

ggsave("plots/status_distribution.png", status_plot, width = 10, height = 6)

# Generate README
readme_content <- paste0(
  "# 🚲 Toronto Bike Share Analytics\n\n",
  "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), "\n\n",
  "## 📊 System Overview\n",
  "- **Total bikes available:** ", format(total_bikes, big.mark = ","), "\n",
  "- **Total docks available:** ", format(total_docks, big.mark = ","), "\n",
  "- **System utilization rate:** ", round(utilization_rate, 1), "%\n",
  "- **Active stations:** ", active_stations, "/", nrow(stations), "\n\n",
  
  "## 🏆 Top 5 Stations by Bike Availability\n",
  kable(top_bike_stations, format = "markdown", col.names = c("Station", "Bikes Available", "Capacity")),
  "\n\n",
  
  "## 🏆 Top 5 Stations by Dock Availability\n",
  kable(top_dock_stations, format = "markdown", col.names = c("Station", "Docks Available", "Capacity")),
  "\n\n",
  
  "## 📍 Bike Locations\n",
  "![Bike Locations](plots/location_plot.png)\n\n",
  
  "## 📊 Station Status Distribution\n",
  "![Status Distribution](plots/status_distribution.png)\n\n",
  
  "## 📈 Bike Availability Distribution\n",
  "![Availability Distribution](plots/availability_dist.png)\n"
)

writeLines(readme_content, "README.md")

# Save data for future analysis
write_parquet(stations, "data/bike_stations.parquet")
