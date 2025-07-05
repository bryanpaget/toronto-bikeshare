library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(knitr)
library(tidyr)
library(arrow)
library(plotly)
library(DT)
library(flexdashboard)
library(htmltools)


# Clean output folders
unlink("docs", recursive = TRUE)
dir.create("docs", showWarnings = FALSE)
dir.create("docs/plots", showWarnings = FALSE)

# GBFS endpoints
endpoints <- list(
  system_regions = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_regions",
  system_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_information",
  station_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information",
  station_status = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status",
  system_pricing_plans = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_pricing_plans"
)

# Fetch station data
station_info <- fromJSON(endpoints$station_information)$data$stations
station_status <- fromJSON(endpoints$station_status)$data$stations

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

# Interactive location plot
location_plot <- ggplot(stations, aes(x = lon, y = lat, 
                                      size = num_bikes_available, 
                                      color = num_bikes_available,
                                      text = paste("Station:", name, 
                                                   "<br>Bikes:", num_bikes_available,
                                                   "<br>Docks:", num_docks_available))) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "yellow", high = "red") +
  labs(title = "Bike Availability Across Toronto",
       subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
       x = "Longitude", y = "Latitude") +
  theme_minimal()

# Convert to interactive plot
interactive_map <- ggplotly(location_plot, tooltip = "text") %>%
  layout(autosize = TRUE)

# Save static version for README
static_map <- ggplot(stations, aes(x = lon, y = lat, size = num_bikes_available, color = num_bikes_available)) +
  geom_point(alpha = 0.7) +
  scale_color_gradient(low = "yellow", high = "red") +
  labs(title = "Bike Availability Across Toronto",
       subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
       x = "Longitude", y = "Latitude") +
  theme_minimal()

ggsave("docs/plots/location_plot.png", static_map, width = 10, height = 8)

# Availability distribution plot
dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
  geom_histogram(fill = "#1E88E5", bins = 20) +
  labs(title = "Station Bike Availability Distribution",
       x = "Percentage of Bikes Available", y = "Number of Stations") +
  theme_minimal()

ggsave("docs/plots/availability_dist.png", dist_plot, width = 10, height = 6)

# Interactive distribution plot
interactive_dist <- ggplotly(dist_plot)

# Status distribution plot
status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
  geom_col() +
  geom_text(aes(label = n), vjust = -0.3) +
  labs(title = "Station Status Distribution", 
       x = "Status", y = "Number of Stations") +
  scale_fill_manual(values = c("Available" = "#4CAF50", "Empty" = "#F44336", "Full" = "#FFC107")) +
  theme_minimal()

ggsave("docs/plots/status_distribution.png", status_plot, width = 10, height = 6)

# Interactive status plot
interactive_status <- ggplotly(status_plot)

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
  "![Bike Locations](docs/plots/location_plot.png)\n\n",
  
  "## 📊 Station Status Distribution\n",
  "![Status Distribution](docs/plots/status_distribution.png)\n\n",
  
  "## 📈 Bike Availability Distribution\n",
  "![Availability Distribution](docs/plots/availability_dist.png)\n\n",
  
  "## 📊 Interactive Dashboard\n",
  "For the full interactive experience, check out the [Bike Share Dashboard](docs/index.html)"
)

writeLines(readme_content, "README.md")

# Generate HTML dashboard
dashboard <- tags$html(
  tags$head(
    tags$title("Toronto Bike Share Dashboard"),
    tags$style(HTML("
      body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
      .card { border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); padding: 20px; margin-bottom: 20px; }
      .metric-card { background-color: #f8f9fa; text-align: center; }
      .metric-value { font-size: 2.5rem; font-weight: bold; color: #1E88E5; }
      .metric-label { font-size: 1rem; color: #6c757d; }
      .section-title { border-bottom: 2px solid #1E88E5; padding-bottom: 10px; margin-top: 30px; }
      .plot-container { background-color: white; border-radius: 8px; padding: 15px; margin-bottom: 20px; }
    "))
  ),
  tags$body(
    div(class = "container-fluid",
        h1("🚲 Toronto Bike Share Dashboard", style = "color: #1E88E5;"),
        h3(paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")), 
        
        div(class = "row",
            div(class = "col-md-3",
                div(class = "card metric-card",
                    div(class = "metric-value", format(total_bikes, big.mark = ",")),
                    div(class = "metric-label", "Bikes Available")
                )
            ),
            div(class = "col-md-3",
                div(class = "card metric-card",
                    div(class = "metric-value", format(total_docks, big.mark = ",")),
                    div(class = "metric-label", "Docks Available")
                )
            ),
            div(class = "col-md-3",
                div(class = "card metric-card",
                    div(class = "metric-value", paste0(round(utilization_rate, 1), "%")),
                    div(class = "metric-label", "Utilization Rate")
                )
            ),
            div(class = "col-md-3",
                div(class = "card metric-card",
                    div(class = "metric-value", paste0(active_stations, "/", nrow(stations))),
                    div(class = "metric-label", "Active Stations")
                )
            )
        ),
        
        div(class = "row",
            div(class = "col-md-12",
                div(class = "plot-container",
                    h3("📍 Bike Availability Map", class = "section-title"),
                    interactive_map
                )
            )
        ),
        
        div(class = "row",
            div(class = "col-md-6",
                div(class = "plot-container",
                    h3("📊 Station Status Distribution", class = "section-title"),
                    interactive_status
                )
            ),
            div(class = "col-md-6",
                div(class = "plot-container",
                    h3("📈 Bike Availability Distribution", class = "section-title"),
                    interactive_dist
                )
            )
        ),
        
        div(class = "row",
            div(class = "col-md-6",
                div(class = "plot-container",
                    h3("🏆 Top Stations by Bike Availability", class = "section-title"),
                    renderDataTable({
                      datatable(top_bike_stations, 
                                colnames = c('Station', 'Bikes Available', 'Capacity'),
                                options = list(pageLength = 5, dom = 't'))
                    })
                )
            ),
            div(class = "col-md-6",
                div(class = "plot-container",
                    h3("🏆 Top Stations by Dock Availability", class = "section-title"),
                    renderDataTable({
                      datatable(top_dock_stations, 
                                colnames = c('Station', 'Docks Available', 'Capacity'),
                                options = list(pageLength = 5, dom = 't'))
                    })
                )
            )
        ),
        
        div(class = "row",
            div(class = "col-md-12",
                div(class = "text-center", style = "margin-top: 30px;",
                    p("Automatically generated with ❤️ using R and GitHub Actions"),
                    p(paste("Last updated:", format(Sys.time(), "%Y-%m-%d %H:%M:%S")))
                )
            )
        )
    )
  )
)

# Save HTML dashboard
save_html(dashboard, file = "docs/index.html")

# Save data for future analysis
write_parquet(stations, "docs/data/bike_stations.parquet")
