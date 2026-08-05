# Unit tests for the predictive model (classification, demand, README output).
# Requires R/predictive_model.R sourced into the environment first.

if (!exists("classify_event_by_keywords")) {
  args <- commandArgs()
  script_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
  root <- if (length(script_arg) && nzchar(script_arg)) {
    normalizePath(file.path(dirname(script_arg), ".."))
  } else {
    getwd()
  }
  source(file.path(root, "R", "predictive_model.R"))
}

# 1. Keyword classification
cases <- list(
  c("Concert in Trinity Bellwoods Park", "Live music and food vendors"),
  c("MLS soccer game", "Toronto FC match tonight"),
  c("Food festival at Exhibition Place", "Restaurant week tasting"),
  c("Art fair in Distillery District", "Gallery exhibition and paintings"),
  c("Hiring event", "Career fair for jobs"),
  c("Summer outdoor market", "Patio and food trucks in park"),
  c("Weather forecast update", "Cold front moving in")
)
for (c in cases) {
  r <- classify_event_by_keywords(c[1], c[2])
  cat(sprintf("[%s] %s | %s\n", c[1], r$category, r$impact))
}

# 2. Determinism check
d1 <- demand_change_for_impact("HIGH", 1); d2 <- demand_change_for_impact("HIGH", 1)
stopifnot(identical(d1, d2))
cat(sprintf("deterministic HIGH i=1: %d (identical=%s)\n", d1, identical(d1, d2)))
cat("demand values:", demand_change_for_impact("HIGH", 1), demand_change_for_impact("HIGH", 2),
    demand_change_for_impact("NONE", 1), "\n")
cat("conf:", confidence_for_impact("HIGH"), confidence_for_impact("LOW"), "\n")

# 3. predict_bike_demand with sample events
events <- data.frame(
  event_title = c("Concert in Trinity Bellwoods", "Food Festival at Exhibition Place",
                  "Art Fair in Distillery District"),
  event_description = c("A concert in Trinity Bellwoods Park",
                        "Food festival at Exhibition Place",
                        "Art fair in Distillery District"),
  event_pub_date = as.POSIXct(c("2026-08-06 10:00:00", "2026-08-07 10:00:00", "2026-08-08 10:00:00"), tz = "UTC"),
  event_link = c("a", "b", "c"),
  event_date = as.Date(c("2026-08-07", "2026-08-08", "2026-08-09")),
  source = "test",
  stringsAsFactors = FALSE
)
preds <- predict_bike_demand(events, NULL, NULL)
print(preds[, c("station_name", "predicted_demand_change_pct", "recommended_action",
                "event_impact", "confidence_level")])
stopifnot(nrow(preds) == 3)

# empty events
empty <- predict_bike_demand(NULL, NULL)
stopifnot(nrow(empty) == 0)
cat("empty predictions OK\n")

# 4. format_predictions_for_readme
md <- format_predictions_for_readme(preds, events)
cat("--- readme snippet ---\n")
cat(substr(md, 1, 600), "\n")
stopifnot(grepl("Predictive Analytics", md))

# 5. find_stations_near_events with empty stations -> empty result (no error)
assoc <- find_stations_near_events(events, data.frame(name = character(0)))
if (is.null(assoc)) {
  cat("find_stations_near_events without geosphere returned NULL (OK)\n")
} else {
  stopifnot(length(assoc) == nrow(events))
  all_empty <- all(vapply(assoc, function(m) nrow(m$associated_stations) == 0, logical(1)))
  stopifnot(all_empty)
  cat("find_stations_near_events with empty stations returned empty matches (OK)\n")
}

# 6. known-location matching works with geosphere present
small_stations <- data.frame(
  name = c("Union Station", "Harbourfront", "Maple Leaf Square"),
  lat = c(43.6451, 43.6394, 43.6436),
  lon = c(-79.3794, -79.3864, -79.3792),
  capacity = c(40, 30, 35),
  stringsAsFactors = FALSE
)
ev1 <- events[1, , drop = FALSE]
assoc1 <- find_stations_near_events(ev1, small_stations)
if (!is.null(assoc1)) {
  near <- assoc1[[1]]$associated_stations
  stopifnot(nrow(near) == 3)
  stopifnot(all(c("distance_meters") %in% names(near)))
  stopifnot(near$distance_meters[1] <= near$distance_meters[2])
  cat("geosphere location matching OK, nearest:", near$name[1], "\n")
} else {
  cat("geosphere not available; location matching skipped (OK)\n")
}

# 7. clean_html_text strips tags/entities
d1 <- clean_html_text("<img class=\"webfeedsFeaturedVisual\" src=\"https://x/img.jpg\">Concert &amp; more")
stopifnot(!grepl("<img", d1, fixed = TRUE))
stopifnot(grepl("&", d1, fixed = TRUE))
stopifnot(!grepl("  ", d1, fixed = TRUE))
cat("clean_html_text OK:", d1, "\n")

# 8. is_actual_event gate
gate_cases <- list(
  list("How to find a good hotel deal in Toronto using Skyscanner", "hotel deals and tips", FALSE),
  list("15 things to do in Toronto this weekend", "listicle", FALSE),
  list("Pasteo bar after her concert", "the singer hit up this bar after her concert", FALSE),
  list("New Blue Jays pitcher has wholesome family connection to Toronto", "the pitcher and his family", FALSE),
  list("People are lining up forever for Canada's Wonderland ride", "the new ride is popular", FALSE),
  list("10 can't miss festivals happening in Toronto this August", "roundup of festivals", FALSE),
  list("Award-winning Toronto home finally sells after two years at $4 million loss", "the home sale", FALSE),
  list("Concert in Trinity Bellwoods Park", "live music and food vendors in the park", TRUE),
  list("MLS soccer game", "toronto fc match tonight", TRUE),
  list("Food Festival at Exhibition Place", "food festival at exhibition place", TRUE),
  list("Art Fair in Distillery District", "gallery exhibition and paintings", TRUE),
  list("Raptors game at Scotiabank Arena", "nba playoff game tonight", TRUE),
  list("Dusty Turtles live at the Music Hall", "the band plays old favourites", TRUE)
)
for (g in gate_cases) {
  got <- is_actual_event(g[[1]], g[[2]])
  stopifnot(identical(got, g[[3]]))
}
cat("is_actual_event gate OK (", length(gate_cases), "cases )\n")

cat("\nALL PREDICTIVE TESTS PASSED\n")
