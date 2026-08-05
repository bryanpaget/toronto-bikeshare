# Toronto Bike Share Analytics - main pipeline.
#
# Usage:  Rscript update_report.R
#
# Orchestrates the data snapshot pipeline:
#   1. Fetch live station data from the GBFS API
#   2. Compute + persist metrics and station snapshots
#   3. Generate static README plots and the interactive dashboard
#   4. Run the predictive model and append its results to the README
#
# All logic lives in the R/ modules sourced below; this script only wires
# the steps together and handles top-level error reporting.

source("R/config.R")
source("R/utils.R")
source("R/data.R")
source("R/plots.R")
source("R/dashboard.R")
source("R/info_page.R")
source("R/neighbourhoods.R")
source("R/readme.R")
source("R/predictive_model.R")

main <- function() {
  tryCatch({
    # Make sure all output directories exist.
    for (dir in DIRS_TO_CREATE) {
      if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
    }

    # Fetch live data and compute the current snapshot.
    stations <- fetch_station_data()
    timestamp <- as.POSIXct(stations$last_reported[1], origin = "1970-01-01", tz = "UTC") %>%
      lubridate::with_tz(tzone = TIME_ZONE)
    current_metrics <- compute_metrics(stations, timestamp)
    summaries <- derive_summaries(stations)

    # Persist the snapshot and load full history for trend analysis.
    persist_snapshot(current_metrics, stations, timestamp)
    historical_metrics <- load_history()
    delta_formatted <- compute_deltas(current_metrics, historical_metrics)

    snapshot <- list(
      timestamp = timestamp,
      current_metrics = current_metrics,
      stations = stations,
      status_summary = summaries$status_summary,
      availability_dist = summaries$availability_dist,
      historical_metrics = historical_metrics,
      top_bike_stations = summaries$top_bike_stations,
      top_dock_stations = summaries$top_dock_stations
    )

    # Static plots + README (metrics sections).
    clean_stale_outputs()
    generate_static_plots(stations, summaries$status_summary, summaries$availability_dist,
                          historical_metrics, timestamp)
    readme_content <- generate_readme_content(snapshot, delta_formatted)

    # Predictive model + append its results to the README.
    prediction_results <- run_predictive_model()
    predictions_markdown <- format_predictions_for_readme(
      prediction_results$predictions, prediction_results$events_data)
    readme_content <- paste0(readme_content, "\n\n", predictions_markdown)
    writeLines(readme_content, README_OUTPUT)
    cat("Generated", README_OUTPUT, "\n")

    # Interactive dashboard.
    dashboard_html <- generate_dashboard_html(
      current_metrics, delta_formatted, timestamp,
      historical_metrics, stations, prediction_results,
      summaries$status_summary, summaries$availability_dist)
    writeLines(dashboard_html, DASHBOARD_OUTPUT)
    cat("Generated", DASHBOARD_OUTPUT, "\n")

  }, error = function(e) {
    message("Error processing data: ", conditionMessage(e))
    error_content <- paste(
      "# \U0001F6A8 Error in Bike Share Dashboard",
      "The automated update failed to process the bike share data.",
      "## Details:",
      paste("```", conditionMessage(e), "```", sep = "\n"),
      sep = "\n\n"
    )
    writeLines(error_content, README_OUTPUT)
    writeLines(
      paste0(
        '<!DOCTYPE html>\n<html lang="en"><head><meta charset="utf-8"/>\n',
        '<title>Toronto Bike Share Dashboard</title></head>\n',
        '<body style="font-family:sans-serif;text-align:center;padding-top:60px;">\n',
        '<h1>\U0001F6A8 Error in Bike Share Dashboard</h1>\n',
        '<p>The automated update failed to process the bike share data.</p>\n',
        '<pre>', htmltools::htmlEscape(conditionMessage(e)), '</pre>\n',
        '</body></html>\n'
      ),
      DASHBOARD_OUTPUT
    )
  })
}

main()
