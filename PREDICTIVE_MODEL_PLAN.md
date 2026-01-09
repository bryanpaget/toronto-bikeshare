# Completing the Predictive Model for Toronto Bike Share

This document outlines how to enhance the predictive model to create a fully functional system that analyzes multiple RSS feed sources (Narcity Toronto, View The Vibe, YYZ Deals) and predicts bike demand.

## 1. Event Data Scraping

### Current State
The `scrape_multi_source_events()` function currently aggregates data from multiple RSS feeds including Narcity Toronto, View The Vibe, and YYZ Deals. The current implementation supports both RSS and Atom feed formats.

#### A. Multi-Source RSS Feed Implementation
The system now aggregates events from multiple sources:

1. **Narcity Toronto**: https://www.narcity.com/feeds/toronto.rss
2. **View The Vibe**: https://viewthevibe.com/feed/
3. **YYZ Deals**: https://yyzdeals.com/atom/1

The implementation handles both RSS and Atom feed formats and includes error handling for when feeds are unavailable or have no upcoming events.

```r
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

    # Extract items from the RSS feed (try both RSS and Atom formats)
    items <- xml_find_all(rss_doc, "//item")
    if (length(items) == 0) {
      items <- xml_find_all(rss_doc, "//entry")  # Try Atom format
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
```

## 2. Geolocation Matching

Match event locations to bike station coordinates. Since RSS feeds typically don't include precise locations, you'll need to:

#### A. Extract Location Information from Content
```r
# Function to extract location information from event descriptions
extract_locations_from_text <- function(description) {
  # Use NLP techniques to identify location mentions
  # This could use keyword matching or more advanced NER (Named Entity Recognition)
  
  # Common Toronto location keywords
  toronto_locations <- c("downtown", "distillery district", "exhibition place", "trinity bellwoods", 
                        "high park", "royal ontario museum", "cn tower", "ripley's aquarium",
                        "toronto islands", "st. lawrence market", "kensington market", 
                        "yonge-dundas square", "union station", "brookfield place")
  
  found_locations <- sapply(toronto_locations, function(loc) grepl(tolower(loc), tolower(description)))
  return(names(found_locations[found_locations]))
}
```

#### B. Find Stations Near Events
```r
# Function to find stations near events based on extracted location
find_nearby_stations <- function(event_location_keywords, radius_km = 2) {
  # Load station data
  stations <- read.csv("data/consolidated_stations.csv")
  
  # For each location keyword, find nearby stations
  # This would require a mapping of location keywords to coordinates
  # or more sophisticated NLP to extract actual addresses
  
  # Example mapping (would need to be expanded)
  location_coords <- list(
    "trinity bellwoods" = c(lat = 43.6478, lon = -79.4042),
    "exhibition place" = c(lat = 43.6392, lon = -79.4003),
    "distillery district" = c(lat = 43.6469, lon = -79.3729)
  )
  
  if (length(event_location_keywords) > 0) {
    # Get coordinates for the first matched location
    loc_name <- event_location_keywords[1]
    if (loc_name %in% names(location_coords)) {
      event_coords <- location_coords[[loc_name]]
      
      # Calculate distances and filter by radius
      distances <- sqrt((stations$lat - event_coords[1])^2 + (stations$lon - event_coords[2])^2) * 111  # Approx km per degree
      
      nearby_stations <- stations[distances <= radius_km, ]
      return(nearby_stations)
    }
  }
  
  # If no specific location found, return all stations
  return(stations)
}
```

## 3. Machine Learning Model Implementation

### A. Feature Engineering
```r
# Function to create features from historical data and event data
prepare_features <- function(historical_data, events_data) {
  # Create features from historical data
  features <- historical_data %>%
    group_by(station_id) %>%
    summarise(
      avg_daily_usage = mean(total_bikes, na.rm = TRUE),
      usage_std_dev = sd(total_bikes, na.rm = TRUE),
      peak_hours = # calculate most active hours
      seasonal_trends = # calculate seasonal patterns
    )
  
  # Process events data to extract relevant features
  processed_events <- events_data %>%
    mutate(
      # Extract event characteristics from text
      contains_concert = grepl("(?i)music|concert|festival|show", event_title),
      contains_sports = grepl("(?i)sport|game|match|team", event_title),
      contains_food = grepl("(?i)food|restaurant|eat|dining|market", event_title),
      # Add more categories as needed
    )
  
  # Extract locations from event descriptions
  processed_events$location_keywords <- sapply(processed_events$event_description, extract_locations_from_text)
  
  # For each event, find nearby stations
  for(i in 1:nrow(processed_events)) {
    nearby_stations <- find_nearby_stations(processed_events$location_keywords[[i]])
    # Add event impact to nearby stations in features
    # This would require more complex logic to associate events with stations
  }
  
  return(list(features = features, events = processed_events))
}
```

### B. Model Selection
Consider implementing one or more of these approaches:

1. **Time Series Forecasting** (ARIMA, Prophet)
2. **Regression Models** (Random Forest, Gradient Boosting)
3. **Neural Networks** (LSTM for temporal patterns)

```r
library(randomForest)
library(forecast)

train_prediction_model <- function(feature_data) {
  # Train model to predict demand changes based on historical patterns and upcoming events
  model <- randomForest(
    formula = predicted_demand_change ~ avg_daily_usage + usage_std_dev + contains_concert + contains_sports + contains_food,  # Adjust formula as needed
    data = feature_data,
    ntree = 500,
    importance = TRUE
  )
  
  return(model)
}
```

## 4. Event Classification and Impact Scoring

Develop a system to classify events and score their impact on bike demand:

### A. spaCy-Based Event Classification with Optional LLM Enhancement
The system now includes a function to classify events using spaCy NLP as the primary method, with optional LLM enhancement when API key is available:

```r
# Function to classify events using spaCy with optional LLM enhancement
classify_event_with_nlp <- function(event_title, event_description) {
  # Import spaCy through reticulate (assumed to be available)
  spacy <- reticulate::import("spacy")

  # Load English model
  nlp <- spacy$load("en_core_web_sm")

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
```

### B. GitHub Actions Integration with spaCy and Optional LLM
To use the enhanced classification in GitHub Actions:

1. **spaCy Integration**: Install Python and spaCy in the workflow (assumed to be available)
2. **LLM Enhancement**: Set up secrets for API keys (optional enhancement)

Example GitHub Action workflow with spaCy:
```yaml
- name: Install Python dependencies
  run: |
    python -m pip install --upgrade pip
    pip install spacy
    python -m spacy download en_core_web_sm

- name: Event Classification with spaCy
  env:
    OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}  # Optional: for LLM enhancement
  run: |
    Rscript -e "source('predictive_model.R'); classify_event_with_nlp('Sample Event', 'Sample Description')"
```

### C. Keyword-Based Fallback Classification
For environments without spaCy or LLM access, the system uses sophisticated keyword matching:

```r
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
```

## 5. Real-time Integration

Set up the model to run automatically:

### A. Scheduling
- Use cron jobs (Linux/Mac) or Task Scheduler (Windows) to run the script regularly
- Consider running the predictive model daily or weekly to update recommendations

### B. Alert System
```r
send_alerts_if_needed <- function(recommendations) {
  # Send notifications if major rebalancing is needed
  high_priority_moves <- recommendations[
    abs(recommendations$predicted_demand_change_pct) > 25, 
  ]
  
  if (nrow(high_priority_moves) > 0) {
    # Send email/SMS notification to operations team
    send_notification(high_priority_moves)
  }
}
```

## 6. Model Evaluation

Implement methods to evaluate model performance:

```r
evaluate_model_performance <- function(predictions, actual_values) {
  # Calculate metrics like MAE, RMSE, accuracy
  mae <- mean(abs(predictions - actual_values), na.rm = TRUE)
  rmse <- sqrt(mean((predictions - actual_values)^2, na.rm = TRUE))
  
  # Compare predicted vs actual demand changes
  accuracy <- sum(sign(predictions) == sign(actual_values)) / length(predictions)
  
  return(list(mae = mae, rmse = rmse, accuracy = accuracy))
}
```

## 7. Weather Integration

Enhance predictions with weather data:

```r
library(rnoaa)  # NOAA weather data

get_weather_forecast <- function(date_range) {
  # Get weather forecast for event dates
  # Weather significantly impacts bike usage
  weather_data <- meteo_pull_monitors(...)  # Use appropriate function
  
  return(weather_data)
}
```

## 8. Testing Strategy

Before deploying the full model:

1. Split historical data into train/test sets
2. Validate that the model performs better than baseline predictions
3. Test with different event types and locations
4. Monitor model performance over time and retrain as needed

## 9. Dependencies to Add

Add these to your project as needed:
```r
# In DESCRIPTION file or install manually
install.packages(c(
  "xml2",         # RSS parsing
  "lubridate",    # Date/time manipulation
  "randomForest", # ML algorithms
  "forecast",     # Time series forecasting
  "rnoaa",        # Weather data
  "geosphere",    # Geographic calculations
  "tm",           # Text mining for NLP
  "NLP",          # Natural language processing
  "reticulate"    # For Python integration (spaCy)
))
```

## 10. Development Environment Setup

To ensure consistent development and deployment environments, create a development setup:

### Python Virtual Environment
Create a virtual environment with required dependencies:

1. **requirements.txt**:
```
# Python dependencies for Toronto Bike Share Analytics
spacy>=3.4.0
requests>=2.28.0
beautifulsoup4>=4.11.0
lxml>=4.9.0
numpy>=1.21.0
pandas>=1.4.0
matplotlib>=3.5.0
seaborn>=0.11.0
scikit-learn>=1.1.0
```

2. **Makefile** for easy environment management:
```
.PHONY: setup install-spacy test clean

setup:
	python3 -m venv venv
	./venv/bin/pip install --upgrade pip
	./venv/bin/pip install -r requirements.txt

install-spacy:
	./venv/bin/python -m spacy download en_core_web_sm

test:
	Rscript update_report.R

clean:
	rm -rf venv
```

### GitHub Actions Integration
The GitHub Actions workflow should install both Python and R dependencies:

```yaml
- name: Install Python dependencies
  run: |
    python -m pip install --upgrade pip
    pip install -r requirements.txt
    python -m spacy download en_core_web_sm

- name: Install R packages
  run: |
    R -e "install.packages(c('xml2', 'lubridate', 'dplyr', 'reticulate'), repos = 'https://cloud.r-project.org')"
```

This ensures that spaCy and other Python dependencies are available in both local development and CI/CD environments.

This roadmap provides a clear path to transform the current multi-RSS-source model into a production-ready predictive system for Toronto bike share demand.