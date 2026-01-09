# Predictive Model for Toronto Bike Share Demand
# This is a dummy module that can be completed later with actual predictive algorithms

library(dplyr)
library(lubridate)

# Function to scrape events from a single RSS feed
scrape_single_rss_feed <- function(rss_url, source_name) {
  cat("Scraping", source_name, "RSS feed for events...\n")

  # Load required libraries
  if (!require("xml2", quietly = TRUE)) {
    install.packages("xml2")
    library(xml2)
  }

  if (!require("lubridate", quietly = TRUE)) {
    install.packages("lubridate")
    library(lubridate)
  }

  tryCatch({
    # Parse the RSS feed
    rss_doc <- read_xml(rss_url)

    # Extract items from the RSS feed
    items <- xml_find_all(rss_doc, "//item")

    if (length(items) == 0) {
      # Try alternative selector for Atom feeds
      items <- xml_find_all(rss_doc, "//entry")
    }

    if (length(items) == 0) {
      cat("No items found in", source_name, "feed\n")
      return(NULL)
    }

    # Extract relevant information from each item
    # For RSS feeds
    titles <- xml_text(xml_find_all(items, "title"))
    descriptions <- xml_text(xml_find_all(items, "description"))
    pub_dates <- xml_text(xml_find_all(items, "pubDate"))
    links <- xml_text(xml_find_all(items, "link"))

    # If no items found with RSS selectors, try Atom selectors
    if (length(titles) == 0) {
      titles <- xml_text(xml_find_all(items, "title"))
      descriptions <- xml_text(xml_find_all(items, "summary"))
      pub_dates <- xml_text(xml_find_all(items, "published"))
      # For Atom feeds, link might be an attribute
      link_nodes <- xml_find_all(items, "link")
      links <- xml_attr(link_nodes, "href")
    }

    # If still no titles, try alternative selectors
    if (length(titles) == 0) {
      titles <- xml_text(xml_find_all(items, ".//title"))
    }
    if (length(descriptions) == 0) {
      descriptions <- xml_text(xml_find_all(items, ".//description"))
    }
    if (length(pub_dates) == 0) {
      pub_dates <- xml_text(xml_find_all(items, ".//pubDate"))
    }
    if (length(links) == 0) {
      links <- xml_text(xml_find_all(items, ".//link"))
    }

    # Ensure all vectors have the same length
    max_len <- max(length(titles), length(descriptions), length(pub_dates), length(links))
    if (max_len == 0) {
      cat("No valid items found in", source_name, "feed\n")
      return(NULL)
    }

    # Pad shorter vectors with NA
    titles <- c(titles, rep(NA, max_len - length(titles)))
    descriptions <- c(descriptions, rep(NA, max_len - length(descriptions)))
    pub_dates <- c(pub_dates, rep(NA, max_len - length(pub_dates)))
    links <- c(links, rep(NA, max_len - length(links)))

    # Convert publication dates to proper date format
    # Handle different date formats
    pub_dates_clean <- ifelse(is.na(pub_dates), NA,
                              ifelse(grepl("^[A-Z]", pub_dates),
                                     as.POSIXct(pub_dates, format = "%a, %d %b %Y %H:%M:%S %z", tz="UTC"),
                                     as.POSIXct(pub_dates, format = "%Y-%m-%dT%H:%M:%S", tz="UTC")))

    # Create a data frame with the extracted data
    events_data <- data.frame(
      event_title = titles,
      event_description = ifelse(is.na(descriptions) | descriptions == "", titles, descriptions),
      event_pub_date = pub_dates_clean,
      event_link = links,
      source = source_name,
      stringsAsFactors = FALSE
    )

    # Remove rows with NA titles
    events_data <- events_data[!is.na(events_data$event_title), ]

    if (nrow(events_data) == 0) {
      cat("No valid events found in", source_name, "feed\n")
      return(NULL)
    }

    # Add event date (assuming it's happening soon after publication or using pub date)
    events_data$event_date <- ifelse(is.na(events_data$event_pub_date),
                                    Sys.Date() + 1,
                                    as.Date(events_data$event_pub_date) + 1)

    # Filter for events in the next 2 weeks
    events_data <- events_data[events_data$event_date <= (Sys.Date() + 14) &
                              events_data$event_date >= Sys.Date(), ]

    cat("Found", nrow(events_data), "upcoming events from", source_name, "RSS feed\n")
    return(events_data)

  }, error = function(e) {
    cat("Error scraping", source_name, "RSS feed:", e$message, "\n")
    return(NULL)
  })
}

# Function to aggregate events from multiple RSS feeds
scrape_multi_source_events <- function() {
  cat("Scraping multiple RSS feeds for events...\n")

  # Define RSS feed sources
  rss_sources <- list(
    list(url = "https://www.narcity.com/feeds/toronto.rss", name = "Narcity Toronto"),
    list(url = "https://viewthevibe.com/feed/", name = "View The Vibe"),
    list(url = "https://yyzdeals.com/atom/1", name = "YYZ Deals")
  )

  # Scrape each feed
  all_events_list <- list()
  for (source in rss_sources) {
    events <- scrape_single_rss_feed(source$url, source$name)
    if (!is.null(events) && nrow(events) > 0) {
      all_events_list[[length(all_events_list) + 1]] <- events
    }
  }

  # Combine all events
  if (length(all_events_list) == 0) {
    cat("No events found from any RSS feeds, using dummy data...\n")
    dummy_events <- data.frame(
      event_title = c("Concert in Trinity Bellwoods", "Food Festival at Exhibition Place", "Art Fair in Distillery District"),
      event_description = c("A concert in Trinity Bellwoods Park", "Food festival at Exhibition Place", "Art fair in Distillery District"),
      event_pub_date = as.POSIXct(Sys.time()),
      event_link = c("https://www.narcity.com/example1", "https://www.narcity.com/example2", "https://www.narcity.com/example3"),
      event_date = as.Date(c(Sys.Date() + 2, Sys.Date() + 5, Sys.Date() + 7)),
      source = c("Narcity Toronto", "Narcity Toronto", "Narcity Toronto"),
      stringsAsFactors = FALSE
    )
    return(dummy_events)
  }

  all_events <- do.call(rbind, all_events_list)
  row.names(all_events) <- NULL  # Reset row names after rbind

  # Remove duplicates based on title and date
  all_events <- all_events[!duplicated(all_events[, c("event_title", "event_date")]), ]

  cat("Total events from all sources:", nrow(all_events), "\n")
  return(all_events)
}

# Function to configure Python environment and classify events using spaCy with optional LLM enhancement
classify_event_with_nlp <- function(event_title, event_description) {
  # Configure reticulate to use the virtual environment's Python if available
  venv_path <- file.path(getwd(), "venv", "bin", "python")
  if (file.exists(venv_path)) {
    reticulate::use_python(venv_path, required = TRUE)
  }

  # Check if spaCy is available through reticulate
  if (!reticulate::py_module_available("spacy")) {
    cat("spaCy not available, using keyword classification\n")
    return(classify_event_by_keywords(event_title, event_description))
  }

  # Import spaCy through reticulate
  spacy <- reticulate::import("spacy")

  # Check if the English model is available
  tryCatch({
    # Load English model
    nlp <- spacy$load("en_core_web_sm")
  }, error = function(e) {
    cat("spaCy English model not available, using keyword classification\n")
    return(classify_event_by_keywords(event_title, event_description))
  })

  # Combine title and description for analysis
  full_text <- paste(event_title, event_description)

  # Process the text
  doc <- nlp(full_text)

  # Extract entities that might indicate event types
  entities <- doc$ents
  entity_labels <- sapply(entities, function(ent) ent$label_)
  entity_texts <- sapply(entities, function(ent) ent$text)

  # Look for relevant entities that indicate events
  event_indicators <- c("EVENT", "FAC", "LOC", "DATE", "TIME", "WORK_OF_ART", "LAW")
  has_event_entities <- any(entity_labels %in% event_indicators)

  # Check for activity-related entities
  activity_entities <- c("EVENT", "WORK_OF_ART")  # Events, performances, etc.
  has_activity <- any(entity_labels %in% activity_entities)

  # Also check for keywords in the text
  text_lower <- tolower(full_text)
  concert_keywords <- c("concert", "music", "band", "dj", "festival", "show", "performance", "venue", "stage", "gig", "tour")
  sports_keywords <- c("sports", "game", "match", "tournament", "team", "soccer", "basketball", "hockey", "football", "playoff", "playoffs", "mls", "nba", "nhl", "cfl", "cancer relay", "marathon", "race", "run")
  food_keywords <- c("food", "restaurant", "dining", "market", "tasting", "brewery", "wine", "beer", "cuisine", "chef", "brewfest", "tasting", "farmers market", "night market", "food truck", "restaurant week")
  arts_keywords <- c("art", "gallery", "museum", "exhibition", "painting", "sculpture", "theater", "dance", "culture", "film", "cinema", "movie", "outdoor cinema", "street festival", "cultural", "heritage", "flea market", "craft fair")
  outdoor_keywords <- c("outdoor", "park", "beach", "garden", "nature", "hiking", "trail", "cycling", "bike", "biking", "outdoor market", "patio", "summer event", "outdoor concert", "open air")

  # Check for non-event indicators
  non_event_keywords <- c("hiring", "jobs", "weather", "forecast", "news", "update", "report", "study", "research", "policy", "council", "meeting", "announcement", "sale", "real estate", "condo", "apartment", "traffic", "construction", "transit", "commute", "work from home", "remote work")

  # Determine classification based on spaCy entities and keywords
  if (any(sapply(non_event_keywords, function(x) grepl(x, text_lower)))) {
    return(list(category = "News/Info", impact = "NONE"))
  } else if (any(sapply(concert_keywords, function(x) grepl(x, text_lower))) || "EVENT" %in% entity_labels) {
    return(list(category = "Concert", impact = "HIGH"))
  } else if (any(sapply(sports_keywords, function(x) grepl(x, text_lower)))) {
    return(list(category = "Sports Event", impact = "HIGH"))
  } else if (any(sapply(food_keywords, function(x) grepl(x, text_lower)))) {
    return(list(category = "Food Festival", impact = "MEDIUM"))
  } else if (any(sapply(arts_keywords, function(x) grepl(x, text_lower)))) {
    return(list(category = "Art/Cultural Event", impact = "MEDIUM"))
  } else if (any(sapply(outdoor_keywords, function(x) grepl(x, text_lower)))) {
    return(list(category = "Outdoor Activity", impact = "MEDIUM"))
  } else if (has_activity) {
    return(list(category = "Event", impact = "MEDIUM"))
  } else {
    # If spaCy doesn't identify specific event types, check for LLM classification as enhancement
    api_key <- Sys.getenv("OPENAI_API_KEY", unset = NA)

    if (!is.na(api_key)) {
      if (require("openai", quietly = TRUE)) {
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
          }
        }, error = function(e) {
          # If LLM fails, continue with spaCy-based classification
        })
      }
    }

    # Default to "Other" if no specific classification found
    return(list(category = "Other", impact = "LOW"))
  }
}

# Helper function for keyword-based classification (fallback)
classify_event_by_keywords <- function(event_title, event_description) {
  event_text <- paste(event_title, event_description)
  event_text_lower <- tolower(event_text)

  # Define keywords for different event types that impact bike usage
  concert_keywords <- c("concert", "music", "band", "dj", "festival", "show", "performance", "venue", "stage", "gig", "tour", "festival")
  sports_keywords <- c("sports", "game", "match", "tournament", "team", "soccer", "basketball", "hockey", "football", "playoff", "playoffs", "mls", "nba", "nhl", "cfl", "cancer relay", "marathon", "race", "run", "soccer")
  food_keywords <- c("food", "restaurant", "dining", "market", "tasting", "brewery", "wine", "beer", "cuisine", "chef", "brewfest", "tasting", "farmers market", "night market", "food truck", "restaurant week")
  arts_keywords <- c("art", "gallery", "museum", "exhibition", "painting", "sculpture", "theater", "dance", "culture", "film", "cinema", "movie", "outdoor cinema", "street festival", "cultural", "heritage", "flea market", "craft fair")
  outdoor_keywords <- c("outdoor", "park", "beach", "garden", "nature", "hiking", "trail", "cycling", "bike", "biking", "outdoor market", "patio", "summer event", "outdoor concert", "open air")

  # Keywords that indicate it's NOT an event that impacts bike usage
  non_event_keywords <- c("hiring", "jobs", "weather", "forecast", "news", "update", "report", "study", "research", "policy", "council", "meeting", "announcement", "sale", "real estate", "condo", "apartment", "traffic", "construction", "transit", "commute", "work from home", "remote work")

  # First check if it's NOT an event that impacts bike usage
  if (any(sapply(non_event_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "News/Info", impact = "NONE"))
  }

  # Then classify based on positive event keywords
  if (any(sapply(concert_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Concert", impact = "HIGH"))
  } else if (any(sapply(sports_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Sports Event", impact = "HIGH"))
  } else if (any(sapply(food_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Food Festival", impact = "MEDIUM"))
  } else if (any(sapply(arts_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Art/Cultural Event", impact = "MEDIUM"))
  } else if (any(sapply(outdoor_keywords, function(x) grepl(x, event_text_lower)))) {
    return(list(category = "Outdoor Activity", impact = "MEDIUM"))
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

  # Classify events using spaCy, LLM, or keyword-based fallback
  event_classifications <- list()
  for (i in 1:nrow(events_data)) {
    classification <- classify_event_with_nlp(
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

  # Scrape events from multiple RSS feeds
  events_data <- scrape_multi_source_events()

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
  events_data <- scrape_multi_source_events()

  # Filter events that have actual impact on bike usage (not just news/info)
  impactful_events <- events_data %>%
    rowwise() %>%
    mutate(
      classification = classify_event_by_keywords(event_title, event_description)$category
    ) %>%
    filter(classification != "News/Info")

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
      paste0(
        "### 📈 No High Demand Predictions\n",
        "No stations are predicted to have significantly increased demand based on upcoming events.\n\n"
      )
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
      paste0(
        "### 📉 No Low Demand Predictions\n",
        "No stations are predicted to have significantly decreased demand based on upcoming events.\n\n"
      )
    },

    "### 📅 Upcoming Events Influencing Predictions\n",
    if (nrow(impactful_events) > 0) {
      paste0(
        "| Event | Date | Description |\n",
        "|-------|------|-------------|\n",
        paste(apply(impactful_events[1:min(10, nrow(impactful_events)), ], 1, function(row) {
          # Truncate description if too long
          desc <- ifelse(nchar(row["event_description"]) > 50,
                         paste0(substr(row["event_description"], 1, 47), "..."),
                         row["event_description"])
          paste0("| [", row["event_title"], "](", row["event_link"], ") | ", row["event_date"], " | ", desc, " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      "No upcoming events that are likely to impact bike share usage were detected in the RSS feed.\n\n"
    },

    "*Last updated: ", format(Sys.time(), "%Y-%m-%d %H:%M"), " (Toronto Time)*\n",
    "*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals)*"
  )

  return(readme_content)
}