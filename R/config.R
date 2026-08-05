# Global configuration: data sources, file paths, and constants.

GBFS_ENDPOINTS <- list(
  system_regions = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_regions",
  system_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_information",
  station_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information",
  station_status = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status"
)

TIME_ZONE <- "America/Toronto"

DATA_DIR <- "data"
METRICS_FILE <- file.path(DATA_DIR, "consolidated_metrics.csv")
STATIONS_FILE <- file.path(DATA_DIR, "consolidated_stations.csv")

DOCS_DIR <- "docs"
PLOTS_DIR <- file.path(DOCS_DIR, "plots")
TIME_SERIES_DIR <- file.path(PLOTS_DIR, "time_series")

DASHBOARD_DIR <- "dashboard"
DASHBOARD_OUTPUT <- file.path(DOCS_DIR, "index.html")
README_OUTPUT <- "README.md"
PREDICTIONS_DIR <- "predictions"

# Directories that must exist before the pipeline runs.
DIRS_TO_CREATE <- c(DOCS_DIR, PLOTS_DIR, TIME_SERIES_DIR, DATA_DIR, PREDICTIONS_DIR)
