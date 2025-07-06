library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(plotly)
library(DT)
library(htmltools)
library(leaflet)
library(viridis)
library(htmlwidgets)

# Custom markdown table formatter
format_markdown_table <- function(df, col_names) {
  header <- paste0("|", paste(col_names, collapse = "|"), "|")
  separator <- paste0("|", paste(rep("---", length(col_names)), collapse = "|"), "|")
  rows <- apply(df, 1, function(row) {
    paste0("|", paste(row, collapse = "|"), "|")
  })
  paste(c(header, separator, rows), collapse = "\n")
}

# Setup output directories
if (!dir.exists("docs")) dir.create("docs")
if (!dir.exists("docs/plots")) dir.create("docs/plots")
if (!dir.exists("docs/data")) dir.create("docs/data")

# Clear existing plot files
plot_files <- list.files("docs/plots", full.names = TRUE)
if (length(plot_files) file.remove(plot_files)

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
  
  # Advanced Leaflet map
  pal <- colorNumeric(viridis(10), domain = stations$num_bikes_available)
  
  bike_map <- leaflet(stations) %>%
    addTiles() %>%
    addCircleMarkers(
      lat = ~lat, lng = ~lon,
      radius = ~sqrt(num_bikes_available) * 2,
      color = ~pal(num_bikes_available),
      stroke = FALSE,
      fillOpacity = 0.8,
      popup = ~paste(
        "<b>", name, "</b><br>",
        "Bikes: ", num_bikes_available, "<br>",
        "Docks: ", num_docks_available, "<br>",
        "Capacity: ", capacity
      )
    ) %>%
    addLegend(
      position = "bottomright",
      pal = pal,
      values = ~num_bikes_available,
      title = "Bikes Available"
    )
  
  # Save leaflet map as HTML widget
  saveWidget(bike_map, file = "docs/plots/bike_map.html", selfcontained = TRUE)
  
  # Save static version for README
  static_map <- ggplot(stations, aes(x = lon, y = lat, size = num_bikes_available, color = num_bikes_available)) +
    geom_point(alpha = 0.7) +
    scale_color_viridis_c(option = "plasma") +
    labs(title = "Bike Availability Across Toronto",
         subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
         x = "Longitude", y = "Latitude") +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  ggsave("docs/plots/location_plot.png", static_map, width = 10, height = 8)
  
  # Interactive distribution plot
  dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
    geom_histogram(fill = "#1E88E5", bins = 20) +
    labs(title = "Station Bike Availability Distribution",
         x = "Percentage of Bikes Available", y = "Number of Stations") +
    theme_minimal()
  
  dist_plotly <- ggplotly(dist_plot)
  saveWidget(dist_plotly, "docs/plots/availability_dist.html", selfcontained = TRUE)
  
  # Interactive status plot
  status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
    geom_col() +
    geom_text(aes(label = n), vjust = -0.3) +
    labs(title = "Station Status Distribution", 
         x = "Status", y = "Number of Stations") +
    scale_fill_viridis_d(option = "D", end = 0.8) +
    theme_minimal()
  
  status_plotly <- ggplotly(status_plot)
  saveWidget(status_plotly, "docs/plots/status_distribution.html", selfcontained = TRUE)
  
  # Generate tables
  bike_table <- datatable(top_bike_stations, 
                          colnames = c('Station', 'Bikes Available', 'Capacity'),
                          options = list(pageLength = 10, dom = 'tip'),
                          rownames = FALSE) %>%
                formatStyle(columns = c(2), 
                          background = styleColorBar(range(top_bike_stations$num_bikes_available), 'plasma'),
                          backgroundSize = '98% 88%',
                          backgroundRepeat = 'no-repeat',
                          backgroundPosition = 'center')
  
  saveWidget(bike_table, "docs/plots/bike_table.html", selfcontained = TRUE)
  
  dock_table <- datatable(top_dock_stations, 
                          colnames = c('Station', 'Docks Available', 'Capacity'),
                          options = list(pageLength = 10, dom = 'tip'),
                          rownames = FALSE) %>%
                formatStyle(columns = c(2), 
                          background = styleColorBar(range(top_dock_stations$num_docks_available), 'viridis'),
                          backgroundSize = '98% 88%',
                          backgroundRepeat = 'no-repeat',
                          backgroundPosition = 'center')
  
  saveWidget(dock_table, "docs/plots/dock_table.html", selfcontained = TRUE)
  
  # Generate README with custom table formatting
  readme_content <- paste0(
    "# 🚲 Toronto Bike Share Analytics\n\n",
    "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), "\n\n",
    "## 📊 System Overview\n",
    "- **Total bikes available:** ", format(total_bikes, big.mark = ","), "\n",
    "- **Total docks available:** ", format(total_docks, big.mark = ","), "\n",
    "- **System utilization rate:** ", round(utilization_rate, 1), "%\n",
    "- **Active stations:** ", active_stations, "/", nrow(stations), "\n\n",
    
    "## 🏆 Top 10 Stations by Bike Availability\n",
    format_markdown_table(top_bike_stations, c("Station", "Bikes Available", "Capacity")),
    "\n\n",
    
    "## 🏆 Top 10 Stations by Dock Availability\n",
    format_markdown_table(top_dock_stations, c("Station", "Docks Available", "Capacity")),
    "\n\n",
    
    "## 📍 Bike Locations\n",
    "![Bike Locations](docs/plots/location_plot.png)\n\n",
    
    "## 📊 Station Status Distribution\n",
    "![Status Distribution](docs/plots/status_distribution.png)\n\n",
    
    "## 📈 Bike Availability Distribution\n",
    "![Availability Distribution](docs/plots/availability_dist.png)\n\n",
    
    "## 📊 Interactive Dashboard\n",
    "For the full interactive experience, check out the [Bike Share Dashboard](index.html)"
  )
  
  writeLines(readme_content, "README.md")
  
  # Generate HTML dashboard
  dashboard <- tags$html(
    tags$head(
      tags$title("Toronto Bike Share Dashboard"),
      tags$link(rel = "stylesheet", href = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"),
      tags$script(src = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"),
      tags$style(HTML("
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; }
        .card { border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); border: none; margin-bottom: 20px; }
        .metric-card { background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%); color: white; text-align: center; }
        .metric-value { font-size: 2.5rem; font-weight: bold; }
        .metric-label { font-size: 1rem; opacity: 0.9; }
        .section-title { border-bottom: 2px solid #2575fc; padding-bottom: 10px; margin-top: 30px; color: #2575fc; }
        .plot-container { background-color: white; border-radius: 8px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .header { background: linear-gradient(135deg, #2575fc 0%, #6a11cb 100%); color: white; padding: 20px 0; margin-bottom: 30px; }
        .footer { background-color: #343a40; color: white; padding: 20px 0; margin-top: 40px; }
        .table-hover tbody tr:hover { background-color: rgba(37, 117, 252, 0.1); }
        .iframe-container { height: 500px; border: none; }
        .small-iframe { height: 400px; }
      "))
    ),
    tags$body(
      div(class = "header text-center",
          h1("🚲 Toronto Bike Share Dashboard", class = "display-4 fw-bold"),
          h3(paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")), class = "fw-light")
      ),
      
      div(class = "container-fluid",
          div(class = "row",
              div(class = "col-lg-3 col-md-6",
                  div(class = "card metric-card",
                      div(class = "card-body",
                          div(class = "metric-value", format(total_bikes, big.mark = ",")),
                          div(class = "metric-label", "Bikes Available")
                      )
                  )
              ),
              div(class = "col-lg-3 col-md-6",
                  div(class = "card metric-card",
                      div(class = "card-body",
                          div(class = "metric-value", format(total_docks, big.mark = ",")),
                          div(class = "metric-label", "Docks Available")
                      )
                  )
              ),
              div(class = "col-lg-3 col-md-6",
                  div(class = "card metric-card",
                      div(class = "card-body",
                          div(class = "metric-value", paste0(round(utilization_rate, 1), "%")),
                          div(class = "metric-label", "Utilization Rate")
                      )
                  )
              ),
              div(class = "col-lg-3 col-md-6",
                  div(class = "card metric-card",
                      div(class = "card-body",
                          div(class = "metric-value", paste0(active_stations, "/", nrow(stations))),
                          div(class = "metric-label", "Active Stations")
                      )
                  )
              )
          ),
          
          div(class = "row",
              div(class = "col-md-12",
                  div(class = "plot-container",
                      h3("📍 Live Bike Availability Map", class = "section-title"),
                      tags$iframe(src = "plots/bike_map.html", class = "iframe-container w-100")
                  )
              )
          ),
          
          div(class = "row",
              div(class = "col-md-6",
                  div(class = "plot-container",
                      h3("📊 Station Status Distribution", class = "section-title"),
                      tags$iframe(src = "plots/status_distribution.html", class = "iframe-container w-100 small-iframe")
                  )
              ),
              div(class = "col-md-6",
                  div(class = "plot-container",
                      h3("📈 Bike Availability Distribution", class = "section-title"),
                      tags$iframe(src = "plots/availability_dist.html", class = "iframe-container w-100 small-iframe")
                  )
              )
          ),
          
          div(class = "row",
              div(class = "col-md-6",
                  div(class = "plot-container",
                      h3("🏆 Top Stations by Bike Availability", class = "section-title"),
                      tags$iframe(src = "plots/bike_table.html", class = "iframe-container w-100 small-iframe")
                  )
              ),
              div(class = "col-md-6",
                  div(class = "plot-container",
                      h3("🏆 Top Stations by Dock Availability", class = "section-title"),
                      tags$iframe(src = "plots/dock_table.html", class = "iframe-container w-100 small-iframe")
                  )
              )
          )
      ),
      
      div(class = "footer text-center",
          div(class = "container",
              p("Automatically generated with ❤️ using R and GitHub Actions"),
              p(paste("Last updated:", format(with_tz(Sys.time(), "America/Toronto"), "%Y-%m-%d %H:%M:%S"))),
              p("Data source: Toronto Bike Share GBFS API")
          )
      )
    )
  )
  
  # Save HTML dashboard
  htmltools::save_html(dashboard, file = "docs/index.html", background = "white")
  
  # Debug output
  message("Files created:")
  message(paste(list.files("docs", recursive = TRUE), collapse = "\n"))
  message("README size: ", file.size("README.md"), " bytes")
  message("Dashboard size: ", file.size("docs/index.html"), " bytes")
  
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
  writeLines("<h1>Error Processing Data</h1>", "docs/index.html")
})
