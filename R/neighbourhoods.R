# Toronto neighbourhood breakdown.
#
# Each station is assigned to a well-known Toronto neighbourhood by nearest
# anchor point (an approximate Voronoi partition). Distances use the haversine
# formula in base R, so this module has no extra package dependencies and works
# offline on the snapshot data.

suppressPackageStartupMessages({library(dplyr)})

# Approximate centres of well-known Toronto neighbourhoods covering the full
# Bike Share service area (Etobicoke in the west, Scarborough in the east,
# York University in the north, Lake Shore in the south).
NEIGHBOURHOOD_ANCHORS <- data.frame(
  neighbourhood = c(
    "Harbourfront / St. Lawrence",
    "Downtown Core",
    "Entertainment District",
    "Kensington / Chinatown",
    "Queen West / Trinity Bellwoods",
    "Dundas West / Little Portugal",
    "Corktown / Distillery",
    "St. James Town / Regent Park",
    "The Annex",
    "Yorkville / Rosedale",
    "Davisville / Mount Pleasant",
    "Yonge-Eglinton (Midtown)",
    "Little Italy / Christie Pits",
    "Bloor West / Junction",
    "High Park / Roncesvalles",
    "Riverdale",
    "Leslieville / South Riverdale",
    "The Danforth",
    "East York (Pape / Coxwell)",
    "The Beaches",
    "Thorncliffe / Flemingdon Park",
    "North York Centre",
    "Downsview / Wilson Heights",
    "York University / Black Creek",
    "Scarborough Centre",
    "South Scarborough",
    "Etobicoke Centre (Islington)",
    "Mimico / Lakeshore West",
    "Mount Dennis / Weston"
  ),
  lat = c(
    43.6410, 43.6505, 43.6420, 43.6545, 43.6465, 43.6500, 43.6510, 43.6600,
    43.6660, 43.6740, 43.6950, 43.7060, 43.6610, 43.6630, 43.6470,
    43.6680, 43.6600, 43.6770, 43.6820, 43.6740, 43.7120,
    43.7610, 43.7280, 43.7740, 43.7760, 43.7490, 43.6460, 43.6270, 43.6840
  ),
  lon = c(
    -79.3720, -79.3850, -79.3930, -79.4010, -79.4120, -79.4240, -79.3530, -79.3650,
    -79.4060, -79.3890, -79.3960, -79.4000, -79.4190, -79.4500, -79.4580,
    -79.3590, -79.3310, -79.3440, -79.3260, -79.3040, -79.3490,
    -79.4120, -79.4730, -79.5000, -79.2590, -79.2070, -79.5310, -79.5050, -79.4830
  )
)

# Great-circle distance in km (haversine, base R).
haversine_km <- function(lat1, lon1, lat2, lon2) {
  r <- 6371
  rad <- pi / 180
  p1 <- lat1 * rad
  p2 <- lat2 * rad
  dp <- p2 - p1
  dl <- (lon2 - lon1) * rad
  a <- sin(dp / 2)^2 + cos(p1) * cos(p2) * sin(dl / 2)^2
  2 * r * asin(pmin(1, sqrt(a)))
}

# Assign each station to the nearest neighbourhood anchor point.
assign_neighbourhoods <- function(stations) {
  s <- stations
  idx <- vapply(seq_len(nrow(s)), function(i) {
    d <- haversine_km(s$lat[i], s$lon[i],
                      NEIGHBOURHOOD_ANCHORS$lat, NEIGHBOURHOOD_ANCHORS$lon)
    which.min(d)
  }, integer(1))
  s$neighbourhood <- NEIGHBOURHOOD_ANCHORS$neighbourhood[idx]
  s
}

# Per-neighbourhood summary: station counts, fleet, utilization, and empty/full
# hotspots, sorted by number of stations (largest neighbourhoods first).
summarize_neighbourhoods <- function(stations) {
  s <- stations %>%
    filter(!is.na(lat), !is.na(lon), !is.na(capacity), capacity > 0)
  if (nrow(s) == 0) return(data.frame())

  assign_neighbourhoods(s) %>%
    group_by(neighbourhood) %>%
    summarise(
      stations = n(),
      capacity = sum(capacity, na.rm = TRUE),
      bikes = sum(num_bikes_available, na.rm = TRUE),
      docks = sum(num_docks_available, na.rm = TRUE),
      utilization = ifelse(sum(capacity, na.rm = TRUE) > 0,
                           round(sum(num_bikes_available, na.rm = TRUE) /
                                   sum(capacity, na.rm = TRUE) * 100, 1),
                           NA_real_),
      avg_availability = round(mean(num_bikes_available / capacity, na.rm = TRUE) * 100, 1),
      empty = sum(num_bikes_available == 0, na.rm = TRUE),
      full = sum(num_docks_available == 0, na.rm = TRUE),
      .groups = "drop"
    ) %>%
    arrange(desc(stations))
}
