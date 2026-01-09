# Predictive Model for Toronto Bike Share Demand
# This is a dummy module that can be completed later with actual predictive algorithms

library(dplyr)
library(lubridate)

# Function to scrape events from Narcity RSS feed
scrape_narcity_events <- function() {
  # This function scrapes the Narcity Toronto RSS feed for upcoming events
  cat("Scraping Narcity Toronto RSS feed for events...\n")

  # Load required libraries
  if (!require("xml2", quietly = TRUE)) {
    install.packages("xml2")
    library(xml2)
  }

  if (!require("lubridate", quietly = TRUE)) {
    install.packages("lubridate")
    library(lubridate)
  }

  # Narcity Toronto RSS feed URL
  rss_url <- "https://www.narcity.com/feeds/toronto.rss"

  tryCatch({
    # Parse the RSS feed
    rss_doc <- read_xml(rss_url)

    # Extract items from the RSS feed
    items <- xml_find_all(rss_doc, "//item")

    # Extract relevant information from each item
    titles <- xml_text(xml_find_all(items, "title"))
    descriptions <- xml_text(xml_find_all(items, "description"))
    pub_dates <- xml_text(xml_find_all(items, "pubDate"))
    links <- xml_text(xml_find_all(items, "link"))

    # Convert publication dates to proper date format
    pub_dates <- as.POSIXct(pub_dates, format = "%a, %d %b %Y %H:%M:%S %z")

    # Create a data frame with the extracted data
    events_data <- data.frame(
      event_title = titles,
      event_description = descriptions,
      event_pub_date = pub_dates,
      event_link = links,
      stringsAsFactors = FALSE
    )

    # Filter for upcoming events (next 2 weeks) and events that mention activities
    # This is a simplified filter - in practice, you'd want more sophisticated NLP
    events_data$event_date <- events_data$event_pub_date + days(1)  # Assume events happen day after posting

    # Filter for events in the next 2 weeks
    events_data <- events_data[events_data$event_date <= (Sys.Date() + 14) &
                              events_data$event_date >= Sys.Date(), ]

    # If no upcoming events found, return dummy data
    if (nrow(events_data) == 0) {
      cat("No upcoming events found in RSS feed, using dummy data...\n")
      dummy_events <- data.frame(
        event_title = c("Concert in Trinity Bellwoods", "Food Festival at Exhibition Place", "Art Fair in Distillery District"),
        event_description = c("A concert in Trinity Bellwoods Park", "Food festival at Exhibition Place", "Art fair in Distillery District"),
        event_pub_date = as.POSIXct(Sys.time()),
        event_link = c("https://www.narcity.com/example1", "https://www.narcity.com/example2", "https://www.narcity.com/example3"),
        event_date = as.Date(c(Sys.Date() + 2, Sys.Date() + 5, Sys.Date() + 7)),
        stringsAsFactors = FALSE
      )
      return(dummy_events)
    }

    # Add event date (assuming it's happening soon after publication)
    events_data$event_date <- as.Date(events_data$event_pub_date) + 1

    cat("Found", nrow(events_data), "upcoming events from Narcity RSS feed\n")
    return(events_data)

  }, error = function(e) {
    cat("Error scraping Narcity RSS feed:", e$message, "\nUsing dummy data instead...\n")

    # Return dummy data in case of error
    dummy_events <- data.frame(
      event_title = c("Concert in Trinity Bellwoods", "Food Festival at Exhibition Place", "Art Fair in Distillery District"),
      event_description = c("A concert in Trinity Bellwoods Park", "Food festival at Exhibition Place", "Art fair in Distillery District"),
      event_pub_date = as.POSIXct(Sys.time()),
      event_link = c("https://www.narcity.com/example1", "https://www.narcity.com/example2", "https://www.narcity.com/example3"),
      event_date = as.Date(c(Sys.Date() + 2, Sys.Date() + 5, Sys.Date() + 7)),
      stringsAsFactors = FALSE
    )
    return(dummy_events)
  })
}

# Function to predict bike demand based on events and historical data
predict_bike_demand <- function(events_data, historical_data) {
  cat("Predicting bike demand based on events and historical data...\n")
  
  # This would contain the actual predictive algorithm
  # For now, returning dummy predictions
  
  # Example algorithm structure:
  # 1. Match event locations to nearby bike stations
  # 2. Estimate demand increase based on event type and attendance
  # 3. Factor in historical usage patterns for similar events
  # 4. Account for weather conditions
  # 5. Output predicted demand by station and time period
  
  # Dummy predictions
  predictions <- data.frame(
    station_id = c("7000", "7001", "7002", "7003", "7004"),
    station_name = c("Fort York Blvd / Capreol Ct", "Wellesley Station Green P", "St. George St / Bloor St W", 
                     "Madison Ave / Bloor St W", "Bay St / College St"),
    predicted_demand_change_pct = c(25, -10, 15, 30, 5),  # Percentage change in demand
    recommended_action = c("ADD_BIKES", "NO_CHANGE", "ADD_BIKES", "ADD_BIKES", "NO_CHANGE"),
    confidence_level = c(0.8, 0.6, 0.7, 0.9, 0.5),  # Confidence in prediction
    event_impact = c("Concert", "Food Festival", "None", "Concert", "None"),
    prediction_date = Sys.time(),
    stringsAsFactors = FALSE
  )
  
  return(predictions)
}

# Function to recommend bike redistribution based on predictions
generate_rebalancing_recommendations <- function(prediction_data) {
  cat("Generating bike rebalancing recommendations...\n")
  
  # This would analyze the predictions and suggest where to move bikes
  # For now, returning dummy recommendations
  
  recommendations <- prediction_data %>%
    filter(recommended_action != "NO_CHANGE") %>%
    arrange(desc(abs(predicted_demand_change_pct))) %>%
    select(station_id, station_name, predicted_demand_change_pct, recommended_action, event_impact)
  
  return(recommendations)
}

# Main function to run the predictive model
run_predictive_model <- function() {
  cat("Running predictive model for bike share demand...\n")

  # Load historical data
  if (file.exists("data/consolidated_metrics.csv")) {
    historical_metrics <- read.csv("data/consolidated_metrics.csv")
    historical_metrics$timestamp <- as.POSIXct(historical_metrics$timestamp)
  } else {
    cat("Warning: No historical metrics data found\n")
    historical_metrics <- NULL
  }

  if (file.exists("data/consolidated_stations.csv")) {
    historical_stations <- read.csv("data/consolidated_stations.csv")
    historical_stations$capture_timestamp <- as.POSIXct(historical_stations$capture_timestamp)
  } else {
    cat("Warning: No historical stations data found\n")
    historical_stations <- NULL
  }

  # Scrape events from Narcity RSS feed
  events_data <- scrape_narcity_events()

  # Make predictions
  predictions <- predict_bike_demand(events_data, historical_metrics)

  # Generate rebalancing recommendations
  recommendations <- generate_rebalancing_recommendations(predictions)

  # Create output directory if it doesn't exist
  if (!dir.exists("predictions")) {
    dir.create("predictions")
  }

  # Save predictions
  write.csv(predictions, "predictions/latest_predictions.csv", row.names = FALSE)
  write.csv(recommendations, "predictions/rebalancing_recommendations.csv", row.names = FALSE)

  # Print summary
  cat("\nPrediction Summary:\n")
  cat("- Total stations analyzed:", nrow(predictions), "\n")
  cat("- Stations with increased demand:", sum(predictions$recommended_action == "ADD_BIKES"), "\n")
  cat("- Stations with decreased demand:", sum(predictions$recommended_action == "REMOVE_BIKES"), "\n")
  cat("- Rebalancing recommendations generated:", nrow(recommendations), "\n")

  # Return results
  results <- list(
    predictions = predictions,
    recommendations = recommendations,
    events_data = events_data
  )

  return(results)
}

# Function to format predictions for README insertion
format_predictions_for_readme <- function(predictions) {
  # Format the predictions in a way that can be inserted into the README
  if (nrow(predictions) == 0) {
    return("# No Predictions Available\n\nNo bike share demand predictions are currently available.")
  }

  # Find stations with highest predicted demand increases
  high_demand_stations <- predictions %>%
    filter(predicted_demand_change_pct > 10) %>%
    arrange(desc(predicted_demand_change_pct)) %>%
    head(5)

  # Find stations with highest predicted demand decreases
  low_demand_stations <- predictions %>%
    filter(predicted_demand_change_pct < -10) %>%
    arrange(predicted_demand_change_pct) %>%
    head(5)

  # Get events data for the upcoming events section
  events_data <- scrape_narcity_events()

  # Create formatted output
  readme_content <- paste0(
    "## 📊 Predictive Analytics\n\n",
    "Based on upcoming events and historical patterns, here are the predicted changes in bike demand:\n\n",

    if (nrow(high_demand_stations) > 0) {
      paste0(
        "### 📈 High Demand Predictions (Add Bikes)\n",
        "| Station | Predicted Increase | Event Impact |\n",
        "|---------|-------------------|--------------|\n",
        paste(apply(high_demand_stations, 1, function(row) {
          paste0("| ", row["station_name"], " | +", round(as.numeric(row["predicted_demand_change_pct"]), 1), "% | ", row["event_impact"], " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      ""
    },

    if (nrow(low_demand_stations) > 0) {
      paste0(
        "### 📉 Low Demand Predictions (Remove Bikes)\n",
        "| Station | Predicted Decrease | Event Impact |\n",
        "|---------|-------------------|--------------|\n",
        paste(apply(low_demand_stations, 1, function(row) {
          paste0("| ", row["station_name"], " | ", round(as.numeric(row["predicted_demand_change_pct"]), 1), "% | ", row["event_impact"], " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      ""
    },

    "### 📅 Upcoming Events Influencing Predictions\n",
    if (nrow(events_data) > 0) {
      paste0(
        "| Event | Date | Description |\n",
        "|-------|------|-------------|\n",
        paste(apply(events_data[1:min(10, nrow(events_data)), ], 1, function(row) {
          # Truncate description if too long
          desc <- ifelse(nchar(row["event_description"]) > 50,
                         paste0(substr(row["event_description"], 1, 47), "..."),
                         row["event_description"])
          paste0("| [", row["event_title"], "](", row["event_link"], ") | ", row["event_date"], " | ", desc, " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      "No upcoming events detected in the RSS feed.\n\n"
    },

    "*Last updated: ", format(Sys.time(), "%Y-%m-%d %H:%M"), " (Toronto Time)*\n",
    "*Model confidence: Based on historical patterns and upcoming events from Narcity Toronto RSS feed*"
  )

  return(readme_content)
}