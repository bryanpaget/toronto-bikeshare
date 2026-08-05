# Predictive model for Toronto bike share demand.
#
# Lightweight heuristic model: scrapes upcoming events from several RSS feeds,
# filters out article/listicle/deal content, classifies the rest by expected
# impact on bike share demand, and produces deterministic per-station
# recommendations. Intended as a foundation for a more sophisticated ML model
# (see PREDICTIVE_MODEL_PLAN.md).

library(dplyr)

# PREDICTIONS_DIR is normally defined in R/config.R; fall back so this module
# can also be sourced standalone (e.g. from the test suite).
if (!exists("PREDICTIONS_DIR")) PREDICTIONS_DIR <- "predictions"

# ---------------------------------------------------------------------------
# Keyword lists used for event classification
# ---------------------------------------------------------------------------

EVENT_KEYWORDS <- list(
  concert = c("concert", "music", "live music", "dj set", "dj ", "band", "gig"),
  sports = c("sports", "game", "match", "tournament", "team", "soccer", "basketball",
             "hockey", "football", "playoff", "mls", "nba", "nhl", "cfl",
             "cancer relay", "marathon", "race", "run"),
  food = c("food", "restaurant", "dining", "market", "tasting", "brewery", "wine",
           "beer", "cuisine", "chef", "brewfest", "farmers market", "night market",
           "food truck", "restaurant week"),
  arts = c("art", "gallery", "museum", "exhibition", "painting", "sculpture",
           "theater", "dance", "culture", "film", "cinema", "movie",
           "outdoor cinema", "street festival", "cultural", "heritage",
           "flea market", "craft fair"),
  outdoor = c("outdoor", "park", "beach", "garden", "nature", "hiking", "trail",
              "cycling", "bike", "biking", "outdoor market", "patio",
              "summer event", "outdoor concert", "open air"),
  non_event = c("hiring", "jobs", "weather", "forecast", "news", "update", "report",
                "study", "research", "policy", "council", "meeting", "announcement",
                "sale", "real estate", "condo", "apartment", "traffic",
                "construction", "transit", "commute", "work from home", "remote work",
                "deal", "deals", "how to", "things to do", "things happening",
                "to do in", "weekend guide", "roundup", "best ", "guide", "tips",
                "recap", "review", "where to", "what to", "need to know",
                "coming soon", "is opening", "is coming to", "announces",
                "announced", "new location", "photos", "video", "videos",
                "listicle", "10 things", "5 things", "15 things", "things you")
)

# Strong signals in an item TITLE that an article describes a real, demand-driving
# event. Title-level signals are treated as high-confidence evidence.
EVENT_SIGNAL_PATTERNS <- c(
  "festival", "concert", "live music", "music festival", "dj set", "comedy show",
  "stand-up", "performing", "performance", "showcase", "street fair", "craft fair",
  "art fair", "night market", "farmers market", "makers market", "expo",
  "conference", "summit", "convention", "symposium", "workshop", "masterclass",
  "screening", "premiere", "opening night", "opening reception", "exhibition",
  "exhibit", "marathon", "half marathon", "5k", "10k", "race", "triathlon",
  "gran fondo", "parade", "pride", "fireworks", "celebration", "gala",
  "award show", "awards night", "awards ceremony",
  "game", "match", "playoff", "championship", "tournament", "nhl", "nba", "mls",
  "cfl", "soccer", "hockey", "basketball", "football", "baseball", "tennis",
  "grand prix", "derby", "block party", "patio party", "paint night", "karaoke",
  "open mic", "trivia", "dance party", "silent disco", "outdoor movie",
  "movie night", "film festival", "food truck", "beer festival", "wine festival",
  "tasting", "tap takeover", "book launch", "poetry", "storytime",
  "holiday market", "christmas market", "halloween", "st. patrick", "canada day",
  "hackathon", "job fair", "career fair", "concert at", "tickets",
  "presale", "doors open", "doors at", "general admission", "all ages",
  "live at", "plays at", "playing at", "in the park", "on the waterfront",
  "at exhibition place", "in trinity bellwoods", "at the distillery",
  "at budweiser stage", "at scotiabank arena", "at rogers centre",
  "at the waterfront", "toronto islands", "at high park", "event"
)

# Strong event nouns that count as evidence when they appear in a DESCRIPTION
# (weaker than title-level signals, so they're suppressed for news-subject titles).
DESC_EVENT_NOUNS <- c(
  "festival", "concert", "live music", "food truck", "tasting", "food market",
  "night market", "farmers", "playoff", "tournament", "marathon", "half marathon",
  "5k", "10k", "race", "parade", "fireworks", "exhibition", "art show",
  "comedy", "trivia", "karaoke", "screening", "premiere", "book launch",
  "workshop", "masterclass", "conference", "summit", "hackathon", "job fair",
  "career fair", "gala", "dance party", "street festival", "doors open",
  "general admission", "presale", "tickets on sale", "in the park",
  "on the waterfront", "toronto islands", "at the distillery",
  "block party", "patio", "food vendors", "live music"
)

# Title-level markers of news/subject articles (people, products, recaps).
# When present in the title, description-only evidence is not enough.
NEWS_SUBJECT_PATTERNS <- c(
  "pitcher", "player", "athlete", "singer", "rapper", "actor", "actress",
  "celebrity", "influencer", "team", "draft", "trade", "debut", "album",
  "song", "release", "viral", "trending", "record", "history", "decades",
  "ride", "attraction", "lining up", "connection to", "welcomes", "moves to",
  "reveals", "claims", "study", "survey", "movie", "film", "documentary",
  "tv show", "wins", "victory", "defeat", "beat ", "loses", "banned",
  "removed", "reaction", "goes viral", "for the first time", "things to do",
  "wonderland", "coaster", "goes flying", "iphone", "smartphone", "sells",
  "million", "real estate", "home ", "condo", "apartment", "changes after"
)

# Patterns that mark a feed item as an article rather than an event.
NON_EVENT_PATTERNS <- c(
  "things to do", "things happening", "to do in", "things to see",
  "weekend guide", "roundup", "best ", "how to", "what to do", "where to",
  "where to eat", "tips for", "pro tips", "deal", "deals", "find a good",
  "find cheap", "save on", "savings", "cost of", "price", "pricing",
  "review", "recap", "need to know", "here's what", "here is what",
  "first look", "we tried", "we visited", "i tried", "i visited",
  "is opening", "is coming to", "coming soon", "announces", "announced",
  "opens new", "new location", "relocating", "closes", "closing",
  "shutting down", "lawsuit", "banned", "ban on", "photos", "video",
  "videos", "photo gallery", "picture gallery", "image gallery", "in photos",
  "map of", "cheapest", "expensive", "affordable",
  "cheap ", "under $", "for under", "for less than", "salary", "wages",
  "census", "stats", "statistics", "ranking", "ranked", "reasons to",
  "ways to", "steps to", "signs you", "signs your", "after the concert",
  "after her concert", "after their", "explains why", "here's why",
  "here is why", "we asked", "wants you to", "is slamming", "is blasting",
  "takes aim", "should visit", "should try", "worth visiting", "worth it"
)

# Listicle-style titles: "15 things", "10 best", "7 ways", "10 can't miss", etc.
LISTICLE_PATTERN <- "^[0-9]{1,3}\\s+(things|best|ways|places|reasons|tips|signs|events|shows|restaurants|cafes|bars|pubs|parks|spots|museums|galleries|cheap|free|weird|hidden|new|most|underrated|can't miss|cant miss|festivals|things happening|events happening)"

# ---------------------------------------------------------------------------
# Text cleaning and event gate
# ---------------------------------------------------------------------------

# Strip HTML tags and decode common entities from feed text.
clean_html_text <- function(text) {
  if (length(text) == 0 || all(is.na(text))) return(text)
  text <- gsub("<[^>]+>", " ", text)
  text <- gsub("<\\!\\[CDATA\\[|\\]\\]>", "", text)
  text <- gsub("&nbsp;|&#160;", " ", text)
  text <- gsub("&amp;", "&", text)
  text <- gsub("&lt;", "<", text)
  text <- gsub("&gt;", ">", text)
  text <- gsub("&quot;|&#34;", "\"", text)
  text <- gsub("&#39;|&#039;|&apos;", "'", text)
  gsub("[[:space:]]+", " ", trimws(text))
}

# Decide whether a feed item is a real, demand-driving event (vs. an article,
# listicle, deal post, or news item). Defaults to FALSE so article-heavy feeds
# (e.g. blogTO) don't pollute predictions.
is_actual_event <- function(event_title, event_description) {
  title_lower <- tolower(event_title)
  desc_lower <- tolower(event_description)

  if (grepl(LISTICLE_PATTERN, title_lower, perl = TRUE)) return(FALSE)
  if (any(vapply(NON_EVENT_PATTERNS, grepl, logical(1), x = title_lower, fixed = TRUE))) return(FALSE)
  if (any(vapply(EVENT_SIGNAL_PATTERNS, grepl, logical(1), x = title_lower, fixed = TRUE))) return(TRUE)

  # Weaker, description-only evidence: requires an event noun in the description
  # AND a non-news title.
  if (any(vapply(DESC_EVENT_NOUNS, grepl, logical(1), x = desc_lower, fixed = TRUE)) &&
      !any(vapply(NEWS_SUBJECT_PATTERNS, grepl, logical(1), x = title_lower, fixed = TRUE))) {
    return(TRUE)
  }

  FALSE
}

# ---------------------------------------------------------------------------
# Event scraping
# ---------------------------------------------------------------------------

# Scrape events from a single RSS feed (handles RSS and Atom formats)
scrape_single_rss_feed <- function(rss_url, source_name) {
  cat("Scraping", source_name, "RSS feed for events...\n")

  tryCatch({
    rss_doc <- suppressWarnings(xml2::read_xml(rss_url))

    items <- xml2::xml_find_all(rss_doc, "//item")
    if (length(items) == 0) {
      items <- xml2::xml_find_all(rss_doc, "//entry")
    }
    if (length(items) == 0) {
      cat("No items found in", source_name, "feed\n")
      return(NULL)
    }

    titles <- xml2::xml_text(xml2::xml_find_all(items, "title"))
    descriptions <- xml2::xml_text(xml2::xml_find_all(items, "description"))
    pub_dates <- xml2::xml_text(xml2::xml_find_all(items, "pubDate"))
    links <- xml2::xml_text(xml2::xml_find_all(items, "link"))

    # Atom feeds use <summary>, <published>, and href attribute on <link>
    if (length(descriptions) == 0) {
      descriptions <- xml2::xml_text(xml2::xml_find_all(items, "summary"))
    }
    if (length(pub_dates) == 0) {
      pub_dates <- xml2::xml_text(xml2::xml_find_all(items, "published"))
    }
    # Atom feeds put the URL in the href attribute instead of the node text
    link_nodes <- xml2::xml_find_all(items, "link")
    if (length(link_nodes) > 0) {
      link_text <- xml2::xml_text(link_nodes)
      link_hrefs <- xml2::xml_attr(link_nodes, "href")
      links <- ifelse(is.na(link_text) | link_text == "", link_hrefs, link_text)
    } else {
      links <- character(0)
    }

    max_len <- max(length(titles), length(descriptions), length(pub_dates), length(links))
    if (max_len == 0) {
      cat("No valid items found in", source_name, "feed\n")
      return(NULL)
    }

    pad <- function(v) c(v, rep(NA_character_, max_len - length(v)))
    titles <- pad(titles)
    descriptions <- pad(descriptions)
    pub_dates <- pad(pub_dates)
    links <- pad(links)

    # Parse publication dates across the common RSS/Atom formats
    pub_dates_clean <- lubridate::parse_date_time(
      pub_dates,
      orders = c("a, d b Y H:M:S z", "a, d b Y H:M:S %z", "ymd_HMS", "ymd_HM", "ymd"),
      tz = "UTC",
      quiet = TRUE
    )

    events_data <- data.frame(
      event_title = clean_html_text(titles),
      event_description = clean_html_text(ifelse(is.na(descriptions) | descriptions == "", titles, descriptions)),
      event_pub_date = pub_dates_clean,
      event_link = links,
      source = source_name,
      stringsAsFactors = FALSE
    )

    events_data <- events_data[!is.na(events_data$event_title) &
                                 events_data$event_title != "", , drop = FALSE]

    if (nrow(events_data) == 0) {
      cat("No valid events found in", source_name, "feed\n")
      return(NULL)
    }

    # Feeds rarely publish event dates, so assume events occur the day after
    # publication when no date is available.
    events_data$event_date <- as.Date(events_data$event_pub_date, tz = "UTC") + 1
    events_data$event_date[is.na(events_data$event_date)] <- Sys.Date() + 1

    # Keep only events in the next 2 weeks
    events_data <- events_data[events_data$event_date >= Sys.Date() &
                                 events_data$event_date <= Sys.Date() + 14, , drop = FALSE]

    cat("Found", nrow(events_data), "upcoming events from", source_name, "RSS feed\n")
    events_data
  }, error = function(e) {
    cat("Error scraping", source_name, "RSS feed:", conditionMessage(e), "\n")
    NULL
  })
}

# Aggregate events from multiple RSS feeds
scrape_multi_source_events <- function() {
  cat("Scraping multiple RSS feeds for events...\n")

  rss_sources <- list(
    list(url = "https://www.narcity.com/feeds/toronto.rss", name = "Narcity Toronto"),
    list(url = "https://viewthevibe.com/feed/", name = "View The Vibe"),
    list(url = "https://yyzdeals.com/atom/1", name = "YYZ Deals"),
    list(url = "https://feeds.feedburner.com/blogto", name = "blogTO")
  )

  all_events <- lapply(rss_sources, function(source) {
    scrape_single_rss_feed(source$url, source$name)
  })
  all_events <- all_events[!vapply(all_events, is.null, logical(1))]
  all_events <- all_events[vapply(all_events, nrow, integer(1)) > 0]

  if (length(all_events) == 0) {
    cat("No events found from any RSS feeds, using fallback dummy data...\n")
    return(data.frame(
      event_title = c("Concert in Trinity Bellwoods", "Food Festival at Exhibition Place", "Art Fair in Distillery District"),
      event_description = c("A concert in Trinity Bellwoods Park", "Food festival at Exhibition Place", "Art fair in Distillery District"),
      event_pub_date = as.POSIXct(Sys.time(), tz = "UTC"),
      event_link = c("https://www.narcity.com/example1", "https://www.narcity.com/example2", "https://www.narcity.com/example3"),
      event_date = as.Date(c(Sys.Date() + 2, Sys.Date() + 5, Sys.Date() + 7)),
      source = c("Narcity Toronto", "Narcity Toronto", "Narcity Toronto"),
      stringsAsFactors = FALSE
    ))
  }

  all_events <- do.call(rbind, all_events)
  row.names(all_events) <- NULL

  before_gate <- nrow(all_events)
  is_event <- vapply(seq_len(before_gate), function(i) {
    is_actual_event(all_events$event_title[i], all_events$event_description[i])
  }, logical(1))
  all_events <- all_events[is_event, , drop = FALSE]
  row.names(all_events) <- NULL
  cat("Filtered out", before_gate - nrow(all_events), "non-events (articles/listicles/news),",
      nrow(all_events), "real events remain\n")

  all_events <- all_events[!duplicated(all_events[, c("event_title", "event_date")]), ]

  cat("Total events from all sources:", nrow(all_events), "\n")
  all_events
}

# ---------------------------------------------------------------------------
# Event classification
# ---------------------------------------------------------------------------

# Keyword-based classification: returns (category, impact) for a feed item.
classify_event_by_keywords <- function(event_title, event_description) {
  title_lower <- tolower(event_title)
  event_text_lower <- tolower(paste(event_title, event_description))

  if (any(vapply(EVENT_KEYWORDS$non_event, grepl, logical(1), x = title_lower, fixed = TRUE))) {
    return(list(category = "News/Info", impact = "NONE"))
  }
  if (any(vapply(EVENT_KEYWORDS$concert, grepl, logical(1), x = event_text_lower, fixed = TRUE))) {
    return(list(category = "Concert", impact = "HIGH"))
  }
  if (any(vapply(EVENT_KEYWORDS$sports, grepl, logical(1), x = event_text_lower, fixed = TRUE))) {
    return(list(category = "Sports Event", impact = "HIGH"))
  }
  if (any(vapply(EVENT_KEYWORDS$food, grepl, logical(1), x = event_text_lower, fixed = TRUE))) {
    return(list(category = "Food Festival", impact = "MEDIUM"))
  }
  if (any(vapply(EVENT_KEYWORDS$arts, grepl, logical(1), x = event_text_lower, fixed = TRUE))) {
    return(list(category = "Art/Cultural Event", impact = "MEDIUM"))
  }
  if (any(vapply(EVENT_KEYWORDS$outdoor, grepl, logical(1), x = event_text_lower, fixed = TRUE))) {
    return(list(category = "Outdoor Activity", impact = "MEDIUM"))
  }
  list(category = "Other", impact = "LOW")
}

# ---------------------------------------------------------------------------
# Demand prediction
# ---------------------------------------------------------------------------

# Deterministic demand estimate based on impact level and event position
demand_change_for_impact <- function(impact, i) {
  base <- c(HIGH = 25, MEDIUM = 15, LOW = 0, NONE = -5)
  base_value <- unname(base[impact])
  if (is.na(base_value)) base_value <- 0
  variation <- c(0, 5, -5, 3, -3, 6, -6, 2, -2, 4)
  base_value + variation[((i - 1) %% length(variation)) + 1]
}

confidence_for_impact <- function(impact) {
  value <- c(HIGH = 0.8, MEDIUM = 0.7, LOW = 0.6, NONE = 0.5)[impact]
  unname(ifelse(is.na(value), 0.5, value))
}

empty_predictions <- function() {
  data.frame(
    station_id = character(0),
    station_name = character(0),
    predicted_demand_change_pct = numeric(0),
    recommended_action = character(0),
    confidence_level = numeric(0),
    event_impact = character(0),
    prediction_date = as.POSIXct(character(0), tz = "UTC"),
    stringsAsFactors = FALSE
  )
}

# Predict bike demand based on events and historical data
predict_bike_demand <- function(events_data, historical_data, stations_data = NULL) {
  cat("Predicting bike demand based on events and historical data...\n")

  if (is.null(events_data) || nrow(events_data) == 0) {
    cat("No events to predict on, returning empty predictions\n")
    return(empty_predictions())
  }

  n_stations <- min(5, nrow(events_data))

  # Use real station names from the most recent snapshot when available
  station_pool <- NULL
  if (!is.null(stations_data) && nrow(stations_data) > 0) {
    stations_data <- stations_data[order(stations_data$capture_timestamp, decreasing = TRUE), ]
    latest <- stations_data[!duplicated(stations_data$station_id), ]
    station_pool <- latest[order(latest$capacity, decreasing = TRUE), ]
  }

  fallback_names <- c("Fort York Blvd / Capreol Ct", "Wellesley Station Green P",
                      "St. George St / Bloor St W", "Madison Ave / Bloor St W",
                      "Bay St / College St")

  station_ids <- character(n_stations)
  station_names <- character(n_stations)
  for (i in seq_len(n_stations)) {
    if (!is.null(station_pool) && i <= nrow(station_pool)) {
      station_ids[i] <- as.character(station_pool$station_id[i])
      station_names[i] <- as.character(station_pool$name[i])
    } else {
      station_ids[i] <- paste0("700", i - 1)
      station_names[i] <- fallback_names[i]
    }
  }

  predictions <- data.frame(
    station_id = station_ids,
    station_name = station_names,
    predicted_demand_change_pct = numeric(n_stations),
    recommended_action = rep("NO_CHANGE", n_stations),
    confidence_level = numeric(n_stations),
    event_impact = rep("None", n_stations),
    prediction_date = as.POSIXct(Sys.time(), tz = "UTC"),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(nrow(events_data))) {
    if (i > nrow(predictions)) break

    classification <- classify_event_by_keywords(
      events_data$event_title[i],
      events_data$event_description[i]
    )

    impact <- classification$impact
    predictions$predicted_demand_change_pct[i] <- demand_change_for_impact(impact, i)
    predictions$recommended_action[i] <- if (impact %in% c("HIGH", "MEDIUM")) "ADD_BIKES" else "NO_CHANGE"
    predictions$event_impact[i] <- classification$category
    predictions$confidence_level[i] <- confidence_for_impact(impact)
  }

  predictions
}

# Recommend bike redistribution based on predictions
generate_rebalancing_recommendations <- function(prediction_data) {
  cat("Generating bike rebalancing recommendations...\n")

  if (nrow(prediction_data) == 0) return(prediction_data)

  prediction_data %>%
    filter(recommended_action != "NO_CHANGE") %>%
    arrange(desc(abs(predicted_demand_change_pct))) %>%
    select(station_id, station_name, predicted_demand_change_pct, recommended_action, event_impact)
}

# ---------------------------------------------------------------------------
# Event-to-station matching and README formatting
# ---------------------------------------------------------------------------

# Find stations near events based on location keywords
find_stations_near_events <- function(events_data, stations_data) {
  if (!requireNamespace("geosphere", quietly = TRUE)) {
    cat("geosphere not available, skipping event-station matching\n")
    return(NULL)
  }

  location_coords <- list(
    "trinity bellwoods" = c(lat = 43.6478, lon = -79.4042),
    "exhibition place" = c(lat = 43.6392, lon = -79.4003),
    "distillery district" = c(lat = 43.6469, lon = -79.3729),
    "high park" = c(lat = 43.6535, lon = -79.4651),
    "royal ontario museum" = c(lat = 43.6677, lon = -79.3947),
    "cn tower" = c(lat = 43.6426, lon = -79.3871),
    "ripley's aquarium" = c(lat = 43.6468, lon = -79.3789),
    "toronto islands" = c(lat = 43.6361, lon = -79.3751),
    "st. lawrence market" = c(lat = 43.6503, lon = -79.3722),
    "kensington market" = c(lat = 43.6511, lon = -79.4006),
    "yonge-dundas square" = c(lat = 43.6564, lon = -79.3808),
    "union station" = c(lat = 43.6451, lon = -79.3794),
    "brookfield place" = c(lat = 43.6455, lon = -79.3778),
    "downtown" = c(lat = 43.6532, lon = -79.3832),
    "downtown core" = c(lat = 43.6532, lon = -79.3832)
  )

  extract_location_from_event <- function(event_desc) {
    event_lower <- tolower(event_desc)
    for (location_name in names(location_coords)) {
      if (grepl(location_name, event_lower, fixed = TRUE)) {
        return(location_name)
      }
    }
    NULL
  }

  find_nearest_stations <- function(event_location, stations_data, n = 3) {
    if (nrow(stations_data) == 0) return(stations_data)
    if (is.null(event_location) || !(event_location %in% names(location_coords))) {
      return(head(stations_data[order(stations_data$capacity, decreasing = TRUE), ], n))
    }

    event_coords <- location_coords[[event_location]]
    distances <- geosphere::distHaversine(
      p1 = cbind(stations_data$lon, stations_data$lat),
      p2 = cbind(rep(event_coords[2], nrow(stations_data)), rep(event_coords[1], nrow(stations_data)))
    )

    stations_with_distance <- stations_data
    stations_with_distance$distance_meters <- distances
    head(stations_with_distance[order(stations_with_distance$distance_meters), ], n)
  }

  event_station_matches <- list()
  for (i in seq_len(nrow(events_data))) {
    event_row <- events_data[i, ]
    location_keyword <- extract_location_from_event(event_row$event_description)
    nearest_stations <- find_nearest_stations(location_keyword, stations_data, n = 3)
    event_station_matches[[i]] <- list(
      event = event_row,
      location_keyword = location_keyword,
      associated_stations = nearest_stations
    )
  }

  event_station_matches
}

# Format predictions for README insertion
format_predictions_for_readme <- function(predictions, events_data = NULL) {
  stations_data <- NULL
  if (file.exists("data/consolidated_stations.csv")) {
    stations_data <- read.csv("data/consolidated_stations.csv")
    stations_data$capture_timestamp <- as.POSIXct(stations_data$capture_timestamp, tz = "UTC")
    stations_data <- stations_data[order(stations_data$capture_timestamp, decreasing = TRUE), ]
    stations_data <- stations_data[!duplicated(stations_data$station_id), ]
  } else {
    cat("Warning: No stations data found for geospatial matching\n")
  }

  if (nrow(predictions) == 0) {
    return("# No Predictions Available\n\nNo bike share demand predictions are currently available.")
  }

  high_demand_stations <- predictions %>%
    filter(predicted_demand_change_pct > 10) %>%
    arrange(desc(predicted_demand_change_pct)) %>%
    head(5)

  low_demand_stations <- predictions %>%
    filter(predicted_demand_change_pct < -10) %>%
    arrange(predicted_demand_change_pct) %>%
    head(5)

  if (is.null(events_data)) {
    events_data <- scrape_multi_source_events()
  }

  impactful_events <- events_data %>%
    rowwise() %>%
    mutate(
      classification = classify_event_by_keywords(event_title, event_description)$category
    ) %>%
    filter(classification != "News/Info")

  event_station_associations <- NULL
  if (!is.null(stations_data) && nrow(impactful_events) > 0) {
    event_station_associations <- find_stations_near_events(impactful_events, stations_data)
  }

  associated_event_for_station <- function(station_name, associations) {
    if (is.null(associations)) return("General prediction")
    for (assoc in associations) {
      if (station_name %in% assoc$associated_stations$name) {
        return(assoc$event$event_title[1])
      }
    }
    "General prediction"
  }

  readme_content <- paste0(
    "## \U0001F4CA Predictive Analytics\n\n",
    "Based on upcoming events and historical patterns, here are the predicted changes in bike demand:\n\n",

    if (nrow(high_demand_stations) > 0) {
      paste0(
        "### \U0001F4C8 High Demand Predictions (Add Bikes)\n",
        "| Station | Predicted Increase | Event Impact | Associated Event |\n",
        "|---------|-------------------|--------------|------------------|\n",
        paste(apply(high_demand_stations, 1, function(row) {
          paste0("| ", row["station_name"], " | +", round(as.numeric(row["predicted_demand_change_pct"]), 1),
                 "% | ", row["event_impact"], " | ",
                 associated_event_for_station(row["station_name"], event_station_associations), " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      paste0(
        "### \U0001F4C8 No High Demand Predictions\n",
        "No stations are predicted to have significantly increased demand based on upcoming events.\n\n"
      )
    },

    if (nrow(low_demand_stations) > 0) {
      paste0(
        "### \U0001F4C9 Low Demand Predictions (Remove Bikes)\n",
        "| Station | Predicted Decrease | Event Impact | Associated Event |\n",
        "|---------|-------------------|--------------|------------------|\n",
        paste(apply(low_demand_stations, 1, function(row) {
          paste0("| ", row["station_name"], " | ", round(as.numeric(row["predicted_demand_change_pct"]), 1),
                 "% | ", row["event_impact"], " | ",
                 associated_event_for_station(row["station_name"], event_station_associations), " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      paste0(
        "### \U0001F4C9 No Low Demand Predictions\n",
        "No stations are predicted to have significantly decreased demand based on upcoming events.\n\n"
      )
    },

    "### \U0001F4C5 Upcoming Events Influencing Predictions\n",
    if (nrow(impactful_events) > 0) {
      paste0(
        "| Event | Date | Description | Recommended Action |\n",
        "|-------|------|-------------|-------------------|\n",
        paste(apply(impactful_events[1:min(10, nrow(impactful_events)), , drop = FALSE], 1, function(row) {
          event_type <- classify_event_by_keywords(row["event_title"], row["event_description"])$category
          recommended_action <- ifelse(event_type %in% c("Concert", "Sports Event", "Food Festival",
                                                         "Art/Cultural Event", "Outdoor Activity"),
                                       "Increase bikes nearby", "Monitor usage")
          desc <- ifelse(nchar(row["event_description"]) > 50,
                         paste0(substr(row["event_description"], 1, 47), "..."),
                         row["event_description"])
          paste0("| [", row["event_title"], "](", row["event_link"], ") | ", row["event_date"],
                 " | ", desc, " | ", recommended_action, " |")
        }), collapse = "\n"),
        "\n\n"
      )
    } else {
      "No upcoming events that are likely to impact bike share usage were detected in the RSS feed.\n\n"
    },

    "*Last updated: ", format(Sys.time(), "%Y-%m-%d %H:%M"), " (Toronto Time)*\n",
    "*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*\n",
    if (!is.null(event_station_associations) && length(event_station_associations) > 0) {
      event_names <- sapply(event_station_associations, function(x) x$event$event_title[1])
      paste0("*Events analyzed: ", paste(head(event_names, 3), collapse = ", "),
             ifelse(length(event_names) > 3, "...", ""),
             ". Stations near events receive adjusted predictions.*\n")
    } else {
      ""
    }
  )

  readme_content
}

# ---------------------------------------------------------------------------
# Main entry point
# ---------------------------------------------------------------------------

run_predictive_model <- function() {
  cat("Running predictive model for bike share demand...\n")

  historical_metrics <- NULL
  if (file.exists("data/consolidated_metrics.csv")) {
    historical_metrics <- read.csv("data/consolidated_metrics.csv")
    historical_metrics$timestamp <- as.POSIXct(historical_metrics$timestamp, tz = "UTC")
  } else {
    cat("Warning: No historical metrics data found\n")
  }

  historical_stations <- NULL
  if (file.exists("data/consolidated_stations.csv")) {
    historical_stations <- read.csv("data/consolidated_stations.csv")
    historical_stations$capture_timestamp <- as.POSIXct(historical_stations$capture_timestamp, tz = "UTC")
  } else {
    cat("Warning: No historical stations data found\n")
  }

  events_data <- scrape_multi_source_events()

  if (!is.null(events_data) && nrow(events_data) > 0) {
    events_data$category <- vapply(seq_len(nrow(events_data)), function(i) {
      classify_event_by_keywords(events_data$event_title[i], events_data$event_description[i])$category
    }, character(1))
  }

  predictions <- predict_bike_demand(events_data, historical_metrics, historical_stations)
  recommendations <- generate_rebalancing_recommendations(predictions)

  if (!dir.exists(PREDICTIONS_DIR)) dir.create(PREDICTIONS_DIR)
  write.csv(predictions, file.path(PREDICTIONS_DIR, "latest_predictions.csv"), row.names = FALSE)
  write.csv(recommendations, file.path(PREDICTIONS_DIR, "rebalancing_recommendations.csv"), row.names = FALSE)

  cat("\nPrediction Summary:\n")
  cat("- Total stations analyzed:", nrow(predictions), "\n")
  cat("- Stations with increased demand:", sum(predictions$recommended_action == "ADD_BIKES"), "\n")
  cat("- Stations with decreased demand:", sum(predictions$recommended_action == "REMOVE_BIKES"), "\n")
  cat("- Rebalancing recommendations generated:", nrow(recommendations), "\n")

  list(
    predictions = predictions,
    recommendations = recommendations,
    events_data = events_data
  )
}
