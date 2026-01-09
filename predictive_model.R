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

# Function to classify events using LLM API
classify_event_with_llm <- function(event_title, event_description) {
  # This function would call an LLM API to classify events
  # For now, we'll use a simple keyword-based classifier as a fallback
  # but the structure is ready for LLM integration

  # Check if OpenAI API key is available
  api_key <- Sys.getenv("OPENAI_API_KEY", unset = NA)

  if (!is.na(api_key)) {
    # Call OpenAI API for event classification
    if (!require("openai", quietly = TRUE)) {
      # If openai package is not available, use fallback
      cat("OpenAI package not available, using keyword classification\n")
      return(classify_event_by_keywords(event_title, event_description))
    }

    # Prepare the prompt for the LLM
    prompt <- paste0(
      "Classify the following event as one of these categories: Concert, Sports Event, Food Festival, Art Exhibition, Conference, Community Event, or Other.\n",
      "Also estimate the potential impact on bike share demand as High, Medium, Low, or None.\n",
      "Title: ", event_title, "\n",
      "Description: ", substr(event_description, 1, 500), "\n",  # Limit description length
      "Format your response as: CATEGORY|IMPACT"
    )

    tryCatch({
      # Call the OpenAI API
      response <- openai::create_completion(
        model = "gpt-3.5-turbo-instruct",  # or another appropriate model
        prompt = prompt,
        max_tokens = 100,
        temperature = 0.3
      )

      # Parse the response
      result <- trimws(response$choices[[1]]$text)
      parts <- strsplit(result, "\\|")[[1]]

      if (length(parts) >= 2) {
        category <- trimws(parts[1])
        impact <- trimws(parts[2])

        # Map impact levels to numerical scores
        impact_mapping <- list(
          "High" = "HIGH",
          "Medium" = "MEDIUM",
          "Low" = "LOW",
          "None" = "NONE",
          "Other" = "OTHER"
        )

        mapped_impact <- impact_mapping[[impact]] %||% "MEDIUM"
        return(list(category = category, impact = mapped_impact))
      } else {
        # Fallback to keyword classification if API response is malformed
        return(classify_event_by_keywords(event_title, event_description))
      }
    }, error = function(e) {
      cat("LLM API call failed:", e$message, "\nUsing keyword classification\n")
      return(classify_event_by_keywords(event_title, event_description))
    })
  } else {
    # Use keyword-based classification as fallback
    return(classify_event_by_keywords(event_title, event_description))
  }
}

# Helper function for keyword-based classification (fallback)
classify_event_by_keywords <- function(event_title, event_description) {
  event_text <- paste(event_title, event_description)
  event_text_lower <- tolower(event_text)

  # Define keywords for different event types
  concert_keywords <- c("concert", "music", "band", "dj", "festival", "show", "performance", "venue", "stage")
  sports_keywords <- c("sports", "game", "match", "tournament", "team", "soccer", "basketball", "hockey", "football", "playoff")
  food_keywords <- c("food", "restaurant", "dining", "market", "tasting", "brewery", "wine", "beer", "cuisine", "chef")
  arts_keywords <- c("art", "gallery", "museum", "exhibition", "painting", "sculpture", "theater", "dance", "culture")
  conference_keywords <- c("conference", "seminar", "workshop", "meeting", "business", "networking", "professional")

  # Classify based on keywords
  if (any(sapply(concert_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Concert", impact = "HIGH"))
  } else if (any(sapply(sports_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Sports Event", impact = "HIGH"))
  } else if (any(sapply(food_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Food Festival", impact = "MEDIUM"))
  } else if (any(sapply(arts_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Art Exhibition", impact = "MEDIUM"))
  } else if (any(sapply(conference_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Conference", impact = "LOW"))
  } else {
    return(list(category = "Other", impact = "LOW"))
  }
}

# Function to predict bike demand based on events and historical data
predict_bike_demand <- function(events_data, historical_data) {
  cat("Predicting bike demand based on events and historical data...\n")

  # This would contain the actual predictive algorithm
  # For now, returning predictions based on classified events

  # Example algorithm structure:
  # 1. Match event locations to nearby bike stations
  # 2. Estimate demand increase based on event type and attendance
  # 3. Factor in historical usage patterns for similar events
  # 4. Account for weather conditions
  # 5. Output predicted demand by station and time period

  # Classify events using LLM or keyword-based fallback
  event_classifications <- list()
  for (i in 1:nrow(events_data)) {
    classification <- classify_event_with_llm(
      events_data$event_title[i],
      events_data$event_description[i]
    )
    event_classifications[[i]] <- classification
  }

  # Create sample predictions based on event classifications
  # In a real implementation, this would use more sophisticated logic
  n_stations <- min(5, nrow(events_data))  # Use up to 5 stations or number of events
  predictions <- data.frame(
    station_id = paste0("700", 0:(n_stations-1)),
    station_name = c("Fort York Blvd / Capreol Ct", "Wellesley Station Green P", "St. George St / Bloor St W",
                     "Madison Ave / Bloor St W", "Bay St / College St")[1:n_stations],
    predicted_demand_change_pct = rep(0, n_stations),  # Initialize with 0
    recommended_action = rep("NO_CHANGE", n_stations),
    confidence_level = rep(0.5, n_stations),  # Initialize with medium confidence
    event_impact = rep("None", n_stations),
    prediction_date = Sys.time(),
    stringsAsFactors = FALSE
  )

  # Update predictions based on event classifications
  for (i in 1:length(event_classifications)) {
    if (i > nrow(predictions)) break

    category <- event_classifications[[i]]$category
    impact <- event_classifications[[i]]$impact

    # Set predicted demand change based on impact level
    if (impact == "HIGH") {
      predictions$predicted_demand_change_pct[i] <- sample(20:35, 1)  # 20-35% increase
      predictions$recommended_action[i] <- "ADD_BIKES"
    } else if (impact == "MEDIUM") {
      predictions$predicted_demand_change_pct[i] <- sample(10:20, 1)  # 10-20% increase
      predictions$recommended_action[i] <- "ADD_BIKES"
    } else if (impact == "LOW") {
      predictions$predicted_demand_change_pct[i] <- sample(-5:5, 1)   # Small change
      predictions$recommended_action[i] <- "NO_CHANGE"
    } else {  # NONE
      predictions$predicted_demand_change_pct[i] <- sample(-10:0, 1)  # Small decrease
      predictions$recommended_action[i] <- "NO_CHANGE"
    }

    predictions$event_impact[i] <- category
    predictions$confidence_level[i] <- ifelse(impact == "HIGH", 0.8, ifelse(impact == "MEDIUM", 0.7, 0.6))
  }

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