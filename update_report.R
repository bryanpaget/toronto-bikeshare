# Libraries
library(readr)
library(dplyr)
library(ggplot2)
library(lubridate)
library(knitr)
library(tidyr)

# Clean output folders
unlink("data", recursive = TRUE)
unlink("plots", recursive = TRUE)
dir.create("data", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# Download and process bike share data
bike_url <- "https://ckan0.cf.opendata.inter.prod-toronto.ca/dataset/7e876c24-177c-4605-9cef-e50dd74c617f/resource/8a6ebe47-41a4-4f82-bfba-c3d4723d20f1/download/bike-share-toronto-ridership-2023.csv"
bike_data <- read_csv(bike_url, 
                     col_types = cols_only(
                       start_time = col_character(),
                       end_time = col_character(),
                       start_station_id = col_integer(),
                       end_station_id = col_integer(),
                       user_type = col_character()
                     ))

# Process data
processed <- bike_data %>%
  mutate(
    start_time = as.POSIXct(start_time, format = "%Y-%m-%d %H:%M:%S"),
    end_time = as.POSIXct(end_time, format = "%Y-%m-%d %H:%M:%S"),
    trip_duration = as.numeric(difftime(end_time, start_time, units = "mins")),
    date = as.Date(start_time),
    hour = hour(start_time),
    day_type = ifelse(wday(date) %in% 2:6, "Weekday", "Weekend")
  ) %>%
  filter(trip_duration > 1 & trip_duration < 1440)  # Filter valid trips (1 min to 24 hrs)

# Key metrics
total_trips <- nrow(processed)
avg_duration <- mean(processed$trip_duration)
member_pct <- mean(processed$user_type == "Member") * 100

# Time-based analysis
hourly_trips <- processed %>%
  count(hour, name = "trips") %>%
  mutate(pct_of_total = trips / sum(trips) * 100)

daily_trips <- processed %>%
  count(date, name = "trips")

# Popular stations
top_stations <- processed %>%
  count(start_station_id, name = "departures") %>%
  arrange(desc(departures)) %>%
  slice_head(n = 5)

# Plots
# 1. Daily trips trend
daily_plot <- ggplot(daily_trips, aes(x = date, y = trips)) +
  geom_line(color = "#1E88E5") +
  labs(title = "Daily Bike Trips Trend (2023)",
       x = "Date", y = "Number of Trips") +
  theme_minimal()

ggsave("plots/daily_trips.png", daily_plot, width = 10, height = 6)

# 2. Hourly usage pattern
hourly_plot <- ggplot(hourly_trips, aes(x = hour, y = pct_of_total)) +
  geom_col(fill = "#FFC107") +
  labs(title = "Hourly Bike Usage Pattern",
       x = "Hour of Day", y = "% of Daily Trips") +
  theme_minimal()

ggsave("plots/hourly_usage.png", hourly_plot, width = 10, height = 6)

# 3. Trip duration distribution
duration_plot <- ggplot(processed, aes(x = trip_duration)) +
  geom_density(fill = "#004D40", alpha = 0.7) +
  scale_x_continuous(limits = c(0, 120)) +
  labs(title = "Trip Duration Distribution",
       x = "Duration (minutes)", y = "Density") +
  theme_minimal()

ggsave("plots/trip_duration.png", duration_plot, width = 10, height = 6)

# Generate README
readme_content <- paste0(
  "# 🚲 Toronto Bike Share Analytics\n\n",
  "Updated automatically with daily insights\n\n",
  "## 📊 Key Metrics (2023 Data)\n",
  "- **Total trips:** ", format(total_trips, big.mark = ","), "\n",
  "- **Average trip duration:** ", round(avg_duration, 1), " minutes\n",
  "- **Member rides:** ", round(member_pct, 1), "%\n\n",
  "## 📈 Daily Trip Volume\n",
  "![Daily Trips](plots/daily_trips.png)\n\n",
  "## 🕒 Hourly Usage Pattern\n",
  "![Hourly Usage](plots/hourly_usage.png)\n\n",
  "## ⏱ Trip Duration Distribution\n",
  "![Trip Duration](plots/trip_duration.png)\n\n",
  "## 🏆 Top 5 Stations by Departures\n",
  knitr::kable(top_stations, format = "markdown", col.names = c("Station ID", "Departures"))
)

writeLines(readme_content, "README.md")
