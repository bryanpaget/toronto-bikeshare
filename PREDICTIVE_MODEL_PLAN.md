# Completing the Predictive Model for Toronto Bike Share

This document outlines how to enhance the predictive model to create a fully functional system that analyzes Narcity Toronto RSS feed events and predicts bike demand.

## 1. Event Data Scraping

### Current State
The `scrape_narcity_events()` function currently extracts data from the Narcity Toronto RSS feed. The current implementation:

#### A. Current Narcity RSS Feed Implementation
```r
library(xml2)
library(lubridate)

scrape_narcity_events <- function() {
  # Narcity Toronto RSS feed URL
  rss_url <- "https://www.narcity.com/feeds/toronto.rss"
  
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
  
  # Add event date (assuming it's happening soon after publication)
  events_data$event_date <- as.Date(events_data$event_pub_date) + 1
  
  return(events_data)
}
```

#### B. Enhancement Opportunities
The current implementation can be enhanced with:

1. **Natural Language Processing** to identify actual events vs. news articles
2. **Location Extraction** to determine where events are happening in Toronto
3. **Event Type Classification** to categorize events by type (concert, festival, sports, etc.)
4. **Attendance Estimation** based on event type and description

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

## 4. Event Impact Scoring

Develop a system to score how much an event might impact bike demand:

```r
calculate_event_impact <- function(event_title, event_description, event_date) {
  # Different types of events have different impacts on bike usage
  # Use keywords to classify event type and estimate impact
  
  # Score based on event type keywords
  type_scores <- c(
    concert = 1.5,
    festival = 1.8,
    sports = 1.6,
    food = 1.3,
    art = 1.2,
    conference = 0.8  # Business events might have lower bike impact
  )
  
  # Determine event type from title/description
  event_text <- paste(event_title, event_description)
  event_type <- "general"  # default
  
  for(type in names(type_scores)) {
    if(grepl(paste0("(?i)", type), event_text)) {
      event_type <- type
      break
    }
  }
  
  # Base impact score on event type
  impact_score <- type_scores[event_type]
  
  # Adjust for event timing (weekend vs weekday, season, etc.)
  event_day <- weekdays(as.Date(event_date))
  if(event_day %in% c("Saturday", "Sunday")) {
    impact_score <- impact_score * 1.2  # Weekend events might have higher impact
  }
  
  # Return impact score
  return(impact_score %||% 1.0)
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
  "NLP"           # Natural language processing
))
```

This roadmap provides a clear path to transform the current RSS-based model into a production-ready predictive system for Toronto bike share demand.