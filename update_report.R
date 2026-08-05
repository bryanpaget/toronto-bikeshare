library(httr)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(knitr)
library(viridis)
library(zoo)
library(plotly)
library(DT)
library(htmltools)
library(htmlwidgets)
library(leaflet)

# Create directories
dirs_to_create <- c("docs", "docs/plots", "docs/plots/time_series", "data")
for (dir in dirs_to_create) {
  if (!dir.exists(dir)) dir.create(dir)
}

# Clear existing plot and widget files
plot_files <- list.files("docs/plots", full.names = TRUE, pattern = "\\.png$")
if (length(plot_files) > 0) file.remove(plot_files)
  html_files <- list.files("docs/plots", full.names = TRUE, pattern = "\\.html$")
  if (length(html_files) > 0) file.remove(html_files)
  ts_html_files <- list.files("docs/plots/time_series", full.names = TRUE, pattern = "\\.html$")
  if (length(ts_html_files) > 0) file.remove(ts_html_files)
widget_dirs <- list.files("docs/plots", full.names = TRUE, pattern = "_files$")
if (length(widget_dirs) > 0) unlink(widget_dirs, recursive = TRUE)

# GBFS endpoints
endpoints <- list(
  system_regions = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_regions",
  system_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/system_information",
  station_information = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information",
  station_status = "https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status"
)

# HTML helpers for the interactive dashboard
metric_card <- function(label, value) {
  paste0(
    '    <div class="col-lg-3 col-md-6">\n',
    '      <div class="card metric-card">\n',
    '        <div class="card-body">\n',
    '          <div class="metric-value">', value, '</div>\n',
    '          <div class="metric-label">', label, '</div>\n',
    '        </div>\n',
    '      </div>\n',
    '    </div>\n'
  )
}

# ---------------------------------------------------------------------------
# Dashboard generation (Grafana-style dark theme, single self-contained page)
# ---------------------------------------------------------------------------

unclass_deep <- function(x) {
  if (inherits(x, "data.frame")) return(as.data.frame(x))
  if (is.list(x)) {
    x[] <- lapply(x, unclass_deep)
    class(x) <- NULL
  }
  x
}

json_embed <- function(x) {
  gsub("</", "<\\/", jsonlite::toJSON(unclass_deep(x), auto_unbox = TRUE, dataframe = "rows",
                                      null = "null", na = "null", digits = 8))
}

plotly_payload <- function(p) {
  suppressWarnings(plotly::plotly_build(p)$x[c("data", "layout", "config")])
}

apply_dark_layout <- function(p, x_title = "", y_title = "", extra = list()) {
  base <- list(
    title = "",
    paper_bgcolor = "rgba(0,0,0,0)",
    plot_bgcolor = "rgba(0,0,0,0)",
    font = list(color = "#cdd3de", size = 11),
    xaxis = list(title = x_title, gridcolor = "#262b38", zerolinecolor = "#262b38",
                 linecolor = "#262b38"),
    yaxis = list(title = y_title, gridcolor = "#262b38", zerolinecolor = "#262b38",
                 linecolor = "#262b38"),
    margin = list(l = 44, r = 10, t = 8, b = 26)
  )
  do.call(plotly::layout, c(list(p), base, extra))
}

fmt_num <- function(x) {
  n <- suppressWarnings(as.numeric(x))
  if (is.na(n)) return("–")
  format(round(n), big.mark = ",", scientific = FALSE)
}

fmt_pct1 <- function(x) {
  n <- suppressWarnings(as.numeric(x))
  if (is.na(n)) return("–")
  paste0(format(round(n, 1), big.mark = ",", scientific = FALSE), "%")
}

delta_class <- function(d) {
  if (is.na(d) || d %in% c("", "N/A")) "flat"
  else if (grepl("^\\+", d)) "up"
  else "down"
}

category_class <- function(cat) {
  if (is.na(cat)) return("other")
  switch(tolower(gsub("[- ]+", "", cat)),
    concert = "concert",
    sports = "sports",
    food = "food",
    foodfestival = "food",
    arts = "arts",
    outdoor = "outdoor",
    nonevent = "non-event",
    other = "other",
    "other")
}

status_class <- function(st) {
  switch(st,
    "Empty" = "st-empty",
    "Full" = "st-full",
    "st-available")
}

tbl <- function(id, headers, rows) {
  if (length(rows) == 0) rows <- paste0("<tr><td colspan=\"", length(headers),
                                        "\" class=\"chart-msg\">No data</td></tr>")
  paste0(
    '<table id="', id, '" class="display"><thead><tr>',
    paste0('<th>', headers, '</th>', collapse = ""),
    '</tr></thead><tbody>', paste0(rows, collapse = ""), '</tbody></table>'
  )
}

build_charts <- function(historical_metrics, availability_dist, status_summary) {
  charts <- list()

  if (!is.null(historical_metrics) && nrow(historical_metrics) > 1) {
    ts_main <- plotly::plot_ly(historical_metrics, x = ~timestamp) %>%
      plotly::add_lines(y = ~total_bikes, name = "Bikes", line = list(color = "#3d8bfd", width = 1.2)) %>%
      plotly::add_lines(y = ~total_docks, name = "Docks", line = list(color = "#00c49d", width = 1.2)) %>%
      plotly::add_lines(y = ~bikes_ma, name = "Bikes (7d MA)", line = list(color = "#f59e0b", width = 1, dash = "dot")) %>%
      apply_dark_layout(y_title = "Count",
        extra = list(xaxis = list(title = "", gridcolor = "#262b38", zerolinecolor = "#262b38",
                                  rangeslider = list(visible = TRUE, thickness = 0.06)),
                     legend = list(orientation = "h", x = 0, y = 1.12, bgcolor = "rgba(0,0,0,0)")))
    charts[["ts-main"]] <- plotly_payload(ts_main)

    ts_util <- plotly::plot_ly(historical_metrics, x = ~timestamp) %>%
      plotly::add_lines(y = ~utilization_rate, name = "Utilization", line = list(color = "#a78bfa", width = 1.2)) %>%
      plotly::add_lines(y = ~utilization_ma, name = "7d MA", line = list(color = "#f59e0b", width = 1, dash = "dot")) %>%
      apply_dark_layout(y_title = "Utilization (%)",
        extra = list(xaxis = list(title = "", gridcolor = "#262b38", zerolinecolor = "#262b38",
                                  rangeslider = list(visible = TRUE, thickness = 0.06)),
                     legend = list(orientation = "h", x = 0, y = 1.12, bgcolor = "rgba(0,0,0,0)")))
    charts[["ts-util"]] <- plotly_payload(ts_util)
  }

  if (!is.null(availability_dist) && nrow(availability_dist) > 0) {
    av <- availability_dist %>% filter(is.finite(availability_pct))
    if (nrow(av) > 0) {
      ha <- plotly::plot_ly(av, x = ~availability_pct, type = "histogram", nbinsx = 30,
                            marker = list(color = "#3d8bfd", line = list(color = "#161a24", width = 0.5))) %>%
        apply_dark_layout(x_title = "Availability (%)", y_title = "Stations",
                          extra = list(showlegend = FALSE))
      charts[["hist-avail"]] <- plotly_payload(ha)
    }
  }

  if (!is.null(status_summary) && nrow(status_summary) > 0) {
    cols <- c("Empty" = "#f44336", "Full" = "#f59e0b", "Available" = "#3d8bfd")
    st <- plotly::plot_ly(status_summary, x = ~status, y = ~n, type = "bar",
                          marker = list(color = unname(cols[status_summary$status]),
                                        line = list(color = "#161a24", width = 0.5)),
                          text = ~n, textposition = "outside",
                          hovertemplate = "%{y} stations") %>%
      apply_dark_layout(y_title = "Stations",
                        extra = list(showlegend = FALSE,
                                     xaxis = list(title = "", gridcolor = "#262b38",
                                                  zerolinecolor = "#262b38")))
    charts[["status"]] <- plotly_payload(st)
  }

  charts
}

build_correlations <- function(historical_metrics) {
  charts <- list()
  if (is.null(historical_metrics) || nrow(historical_metrics) < 3) return(charts)

  cor_cols <- c("total_bikes", "total_docks", "utilization_rate", "active_stations",
                "avg_bikes_per_station", "empty_pct", "full_pct")
  cor_labels <- c("Bikes", "Docks", "Util %", "Active", "Bikes/Stn", "Empty %", "Full %")
  cm <- suppressWarnings(cor(historical_metrics[, cor_cols], use = "pairwise.complete.obs"))
  cm[is.na(cm)] <- 0
  colnames(cm) <- rownames(cm) <- cor_labels

  corr <- plotly::plot_ly(x = cor_labels, y = cor_labels, z = cm, type = "heatmap",
                          zmid = 0,
                          colorscale = list(list(0, "#3d1d4f"), list(0.5, "#11141c"), list(1, "#00c49d")),
                          colorbar = list(thickness = 12, tickfont = list(size = 10)),
                          hovertemplate = "%{y} \u00d7 %{x}<br>r = %{z:.2f}") %>%
    apply_dark_layout(extra = list(showlegend = FALSE,
      xaxis = list(title = "", tickangle = -45, gridcolor = "#262b38", zerolinecolor = "#262b38"),
      yaxis = list(title = "", gridcolor = "#262b38", zerolinecolor = "#262b38"),
      font = list(color = "#cdd3de", size = 10),
      annotations = list(text = as.character(round(cm, 2)), showarrow = FALSE,
                         font = list(size = 8, color = "#cdd3de"))))
  charts[["corr"]] <- plotly_payload(corr)

  hist2 <- historical_metrics %>%
    mutate(dow = lubridate::wday(timestamp, label = TRUE, week_start = 1),
           hr = lubridate::hour(timestamp))
  wd_hr <- hist2 %>%
    group_by(dow, hr) %>%
    summarise(util = mean(utilization_rate, na.rm = TRUE), .groups = "drop")
  dows <- as.character(unique(wd_hr$dow))
  z <- matrix(NA_real_, nrow = length(dows), ncol = 24)
  for (i in seq_len(nrow(wd_hr))) {
    z[match(as.character(wd_hr$dow[i]), dows), wd_hr$hr[i] + 1] <- wd_hr$util[i]
  }
  wh <- plotly::plot_ly(x = 0:23, y = dows, z = z, type = "heatmap",
                        colorscale = list(list(0, "#11141c"), list(0.6, "#1f4f8f"), list(1, "#7cf5c8")),
                        colorbar = list(thickness = 12, tickfont = list(size = 10)),
                        hovertemplate = "%{y} %{x}:00<br>%{z:.1f}%") %>%
    apply_dark_layout(extra = list(showlegend = FALSE,
      xaxis = list(title = "Hour", dtick = 2, gridcolor = "#262b38", zerolinecolor = "#262b38"),
      yaxis = list(title = "", gridcolor = "#262b38", zerolinecolor = "#262b38")))
  charts[["wd-hour"]] <- plotly_payload(wh)

  scatter <- plotly::plot_ly(historical_metrics, x = ~active_stations, y = ~utilization_rate,
                             type = "scatter", mode = "markers",
                             marker = list(color = "#3d8bfd", opacity = 0.5, size = 5),
                             hovertemplate = "Active %{x}<br>Util %{y:.1f}%") %>%
    apply_dark_layout(x_title = "Active Stations", y_title = "Utilization (%)",
                      extra = list(showlegend = FALSE))
  charts[["scatter"]] <- plotly_payload(scatter)

  charts
}

build_stats <- function(current_metrics, delta_formatted) {
  list(
    list(label = "Bikes Available",
         value = format(current_metrics$total_bikes, big.mark = ","),
         delta = delta_formatted$total_bikes, dclass = delta_class(delta_formatted$total_bikes),
         accent = "accent-blue"),
    list(label = "Docks Available",
         value = format(current_metrics$total_docks, big.mark = ","),
         delta = delta_formatted$total_docks, dclass = delta_class(delta_formatted$total_docks),
         accent = "accent-green"),
    list(label = "Utilization",
         value = paste0(round(current_metrics$utilization_rate, 1), "%"),
         delta = delta_formatted$utilization_rate, dclass = delta_class(delta_formatted$utilization_rate),
         accent = "accent-purple"),
    list(label = "Active Stations",
         value = paste0(current_metrics$active_stations, "/", current_metrics$total_stations),
         delta = delta_formatted$active_stations, dclass = delta_class(delta_formatted$active_stations),
         accent = "accent-amber")
  )
}

build_pred_stats <- function(prediction_results) {
  preds <- prediction_results$predictions
  ev <- prediction_results$events_data
  n_events <- if (is.null(ev)) 0 else nrow(ev)
  n_preds <- if (is.null(preds)) 0 else nrow(preds)
  n_add <- if (n_preds == 0) 0 else sum(preds$recommended_action == "ADD_BIKES", na.rm = TRUE)
  n_rem <- if (n_preds == 0) 0 else sum(preds$recommended_action == "REMOVE_BIKES", na.rm = TRUE)
  list(
    list(label = "Events Detected", value = format(n_events, big.mark = ","), delta = "",
         dclass = "flat", accent = "accent-blue"),
    list(label = "Stations Analyzed", value = format(n_preds, big.mark = ","), delta = "",
         dclass = "flat", accent = "accent-purple"),
    list(label = "Add Bikes", value = format(n_add, big.mark = ","), delta = "",
         dclass = "flat", accent = "accent-green"),
    list(label = "Remove Bikes", value = format(n_rem, big.mark = ","), delta = "",
         dclass = "flat", accent = "accent-amber")
  )
}

stat_cards_html <- function(stats) {
  paste0(vapply(stats, function(s) {
    delta_html <- if (is.null(s$delta) || s$delta == "") ""
    else paste0('<div class="stat-delta ', s$dclass, '">', s$delta, ' vs prev snapshot</div>')
    paste0('<div class="stat"><div class="accent-bar ', s$accent, '"></div>',
           '<div class="stat-label">', s$label, '</div>',
           '<div class="stat-value">', s$value, '</div>', delta_html, '</div>')
  }, character(1)), collapse = "")
}

build_map_stations <- function(stations) {
  stations %>%
    filter(!is.na(lat), !is.na(lon)) %>%
    mutate(status = case_when(num_bikes_available == 0 ~ "Empty",
                              num_docks_available == 0 ~ "Full",
                              TRUE ~ "Available")) %>%
    select(name, lat, lon, bikes = num_bikes_available, docks = num_docks_available,
           capacity, status)
}

build_tables <- function(stations, prediction_results, historical_metrics) {
  top_bikes <- stations %>% arrange(desc(num_bikes_available)) %>% slice_head(n = 10)
  bikes_rows <- apply(top_bikes, 1, function(r) paste0(
    "<tr><td>", htmltools::htmlEscape(r[["name"]]), '</td><td class="num">',
    fmt_num(r[["num_bikes_available"]]), '</td><td class="num">', fmt_num(r[["capacity"]]), "</td></tr>"))

  top_docks <- stations %>% arrange(desc(num_docks_available)) %>% slice_head(n = 10)
  docks_rows <- apply(top_docks, 1, function(r) paste0(
    "<tr><td>", htmltools::htmlEscape(r[["name"]]), '</td><td class="num">',
    fmt_num(r[["num_docks_available"]]), '</td><td class="num">', fmt_num(r[["capacity"]]), "</td></tr>"))

  events_data <- prediction_results$events_data
  events_rows <- character(0)
  if (!is.null(events_data) && nrow(events_data) > 0) {
    events_rows <- apply(events_data, 1, function(r) {
      cat_badge <- paste0('<span class="badge ', category_class(r[["category"]]), '">',
                          htmltools::htmlEscape(r[["category"]]), "</span>")
      title <- if (!is.na(r[["event_link"]]) && r[["event_link"]] != "") {
        paste0('<a href="', htmltools::htmlEscape(r[["event_link"]]), '" target="_blank" rel="noopener">',
               htmltools::htmlEscape(r[["event_title"]]), "</a>")
      } else htmltools::htmlEscape(r[["event_title"]])
      paste0("<tr><td>", title, '</td><td class="ev-src">', htmltools::htmlEscape(r[["source"]]),
             '</td><td class="num">', format(as.Date(r[["event_date"]]), "%Y-%m-%d"),
             "</td><td>", cat_badge, "</td></tr>")
    })
  }

  predictions <- prediction_results$predictions
  pred_rows <- character(0)
  if (!is.null(predictions) && nrow(predictions) > 0) {
    pred_rows <- apply(predictions, 1, function(r) {
      action <- r[["recommended_action"]]
      action_class <- if (action == "NO_CHANGE") "no-change"
                      else if (action == "ADD_BIKES") "add-bikes" else "remove-bikes"
      paste0("<tr><td>", htmltools::htmlEscape(r[["station_name"]]),
             '</td><td class="num">', fmt_pct1(r[["predicted_demand_change_pct"]]),
             "</td><td>", paste0('<span class="badge ', action_class, '">',
                                 htmltools::htmlEscape(action), "</span>"),
             '</td><td class="num">', fmt_pct1(as.numeric(r[["confidence_level"]]) * 100),
             "</td><td>", paste0('<span class="badge ', category_class(r[["event_impact"]]), '">',
                                 htmltools::htmlEscape(r[["event_impact"]]), "</span>"),
             "</td></tr>")
    })
  }

  recs <- prediction_results$recommendations
  rec_rows <- character(0)
  if (!is.null(recs) && nrow(recs) > 0) {
    rec_rows <- apply(recs, 1, function(r) {
      action_class <- if (r[["recommended_action"]] == "ADD_BIKES") "add-bikes" else "remove-bikes"
      paste0("<tr><td>", htmltools::htmlEscape(r[["station_name"]]),
             '</td><td class="num">', fmt_pct1(r[["predicted_demand_change_pct"]]),
             "</td><td>", paste0('<span class="badge ', action_class, '">',
                                 htmltools::htmlEscape(r[["recommended_action"]]), "</span>"),
             "</td><td>", paste0('<span class="badge ', category_class(r[["event_impact"]]), '">',
                                 htmltools::htmlEscape(r[["event_impact"]]), "</span>"),
             "</td></tr>")
    })
  }

  stations_sorted <- stations %>% arrange(desc(num_bikes_available))
  st_rows <- apply(stations_sorted, 1, function(r) {
    st <- if (as.numeric(r[["num_bikes_available"]]) == 0) "Empty"
          else if (as.numeric(r[["num_docks_available"]]) == 0) "Full" else "Available"
    paste0("<tr><td>", htmltools::htmlEscape(r[["name"]]), "</td><td>",
           paste0('<span class="badge ', status_class(st), '">', st, "</span>"),
           '</td><td class="num">', fmt_num(r[["num_bikes_available"]]),
           '</td><td class="num">', fmt_num(r[["num_docks_available"]]),
           '</td><td class="num">', fmt_num(r[["capacity"]]),
           '</td><td class="num">', fmt_num(r[["lat"]]),
           '</td><td class="num">', fmt_num(r[["lon"]]), "</td></tr>")
  })

  hist_rows <- character(0)
  if (!is.null(historical_metrics) && nrow(historical_metrics) > 0) {
    hm <- historical_metrics %>% arrange(desc(timestamp))
    hist_rows <- apply(hm, 1, function(r) paste0(
      '<td class="num">', format(as.POSIXct(r[["timestamp"]], tz = "UTC"), "%Y-%m-%d %H:%M"),
      '</td><td class="num">', fmt_num(r[["total_bikes"]]),
      '</td><td class="num">', fmt_num(r[["total_docks"]]),
      '</td><td class="num">', fmt_pct1(r[["utilization_rate"]]),
      '</td><td class="num">', fmt_num(r[["active_stations"]]),
      '</td><td class="num">', fmt_pct1(r[["empty_pct"]]),
      '</td><td class="num">', fmt_pct1(r[["full_pct"]]), "</td></tr>"))
    hist_rows <- paste0("<tr>", hist_rows)
  }

  list(
    top_bikes = tbl("tbl-top-bikes", c("Station", "Bikes", "Capacity"), bikes_rows),
    top_docks = tbl("tbl-top-docks", c("Station", "Docks", "Capacity"), docks_rows),
    events = tbl("tbl-events", c("Event", "Source", "Date", "Type"), events_rows),
    predictions = tbl("tbl-predictions", c("Station", "Change", "Action", "Confidence", "Impact"), pred_rows),
    recommendations = tbl("tbl-recommendations", c("Station", "Change", "Action", "Impact"), rec_rows),
    stations_all = tbl("tbl-stations", c("Station", "Status", "Bikes", "Docks", "Capacity", "Lat", "Lon"), st_rows),
    history = tbl("tbl-history", c("Timestamp", "Bikes", "Docks", "Util", "Active", "Empty %", "Full %"), hist_rows)
  )
}

generate_dashboard_html <- function(current_metrics, delta_formatted, timestamp,
                                    historical_metrics, stations, prediction_results,
                                    status_summary, availability_dist) {
  timestamp_str <- format(timestamp, "%Y-%m-%d %H:%M")

  css <- paste0(readLines("dashboard/style.css", warn = FALSE), collapse = "\n")
  js <- paste0(readLines("dashboard/app.js", warn = FALSE), collapse = "\n")

  charts <- build_charts(historical_metrics, availability_dist, status_summary)
  charts <- c(charts, build_correlations(historical_metrics))

  data_payload <- list(
    updated = timestamp_str,
    historyRange = if (!is.null(historical_metrics) && nrow(historical_metrics) > 1) {
      c(format(min(historical_metrics$timestamp), "%Y-%m-%d"),
        format(max(historical_metrics$timestamp), "%Y-%m-%d"))
    } else NULL,
    stats = build_stats(current_metrics, delta_formatted),
    stations = build_map_stations(stations),
    charts = charts
  )
  data_json <- json_embed(data_payload)

  tables <- build_tables(stations, prediction_results, historical_metrics)
  stats_html <- stat_cards_html(data_payload$stats)
  pred_stats_html <- stat_cards_html(build_pred_stats(prediction_results))

  panel <- function(title, inner, extra_head = "") {
    paste0('<div class="panel"><div class="panel-head"><h3 class="panel-title">', title,
           '</h3>', extra_head, '</div>', inner, '</div>')
  }
  table_panel <- function(title, table_html) {
    panel(title, paste0('<div class="panel-body no-pad"><div class="table-wrap">', table_html, "</div></div>"))
  }
  chart_panel <- function(title, div_id, cls) {
    panel(title, paste0('<div class="panel-body no-pad"><div id="', div_id,
                        '" class="chart ', cls, '"></div></div>'))
  }

  pane_overview <- paste0(
    '<div id="tab-overview" class="tab-pane active">',
    '<div class="metric-row">', stats_html, "</div>",
    '<div class="panel"><div class="panel-head"><h3 class="panel-title">Station Map</h3>',
    '<span id="map-count" class="ev-src"></span></div>',
    '<div class="slicer-bar">',
    '<label>Station</label><input id="map-search" class="input" type="text" placeholder="Filter by name..."/>',
    '<label>Status</label><select id="map-status" class="select">',
    '<option value="all">All</option><option value="Available">Available</option>',
    '<option value="Empty">Empty</option><option value="Full">Full</option></select>',
    '<span class="map-legend">',
    '<span><span class="dot" style="background:#3d8bfd"></span>Available</span>',
    '<span><span class="dot" style="background:#f59e0b"></span>Full</span>',
    '<span><span class="dot" style="background:#f44336"></span>Empty</span></span>',
    "</div>", '<div id="map"></div>', "</div>",
    '<div class="grid-2">',
    chart_panel("Availability Distribution", "chart-hist-avail", "chart-sm"),
    chart_panel("Station Status", "chart-status", "chart-sm"),
    "</div>",
    '<div class="grid-2">',
    table_panel("Top Stations \u2014 Bikes", tables$top_bikes),
    table_panel("Top Stations \u2014 Docks", tables$top_docks),
    "</div>",
    "</div>"
  )

  pane_history <- paste0(
    '<div id="tab-history" class="tab-pane">',
    '<div class="panel"><div class="panel-head"><h3 class="panel-title">Time Range Slicer</h3></div>',
    '<div class="slicer-bar">',
    '<button class="btn btn-preset" data-days="0">All</button>',
    '<button class="btn btn-preset" data-days="7">7D</button>',
    '<button class="btn btn-preset" data-days="30">30D</button>',
    '<button class="btn btn-preset" data-days="90">90D</button>',
    '<button class="btn btn-preset" data-days="180">6M</button>',
    '<label>From</label><input id="slicer-start" class="input" type="date"/>',
    '<label>To</label><input id="slicer-end" class="input" type="date"/>',
    '<span class="ev-src">Brush the charts or set a range</span>',
    "</div></div>",
    chart_panel("Bikes & Docks", "chart-ts-main", "chart-lg"),
    chart_panel("Utilization", "chart-ts-util", "chart-md"),
    "</div>"
  )

  pane_predictions <- paste0(
    '<div id="tab-predictions" class="tab-pane">',
    '<div class="metric-row">', pred_stats_html, "</div>",
    table_panel("Upcoming Events", tables$events),
    table_panel("Demand Predictions", tables$predictions),
    table_panel("Rebalancing Recommendations", tables$recommendations),
    "</div>"
  )

  pane_correlations <- paste0(
    '<div id="tab-correlations" class="tab-pane">',
    chart_panel("Metric Correlation Matrix", "chart-corr", "chart-md"),
    '<div class="grid-2">',
    chart_panel("Utilization by Weekday / Hour", "chart-wd-hour", "chart-md"),
    chart_panel("Utilization vs Active Stations", "chart-scatter", "chart-md"),
    "</div></div>"
  )

  pane_data <- paste0(
    '<div id="tab-data" class="tab-pane">',
    table_panel("All Stations", tables$stations_all),
    table_panel("System History", tables$history),
    "</div>"
  )

  tabs <- paste0(
    '<div class="nav-tabs">',
    '<button class="active" data-tab="overview">Overview</button>',
    '<button data-tab="history">History</button>',
    '<button data-tab="predictions">Predictions</button>',
    '<button data-tab="correlations">Correlations</button>',
    '<button data-tab="data">Data</button>',
    "</div>"
  )

  footer <- paste0(
    '<div class="footer">',
    '<span>Data source: <a href="https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status">Toronto Bike Share GBFS API</a>',
    ' &middot; Events: blogTO / Narcity / View The Vibe / YYZ Deals</span>',
    '<span class="mono">Generated ', timestamp_str, ' &middot; Toronto time</span>',
    "</div>"
  )

  paste0(
    '<!DOCTYPE html>\n',
    '<html lang="en">\n',
    '<head>\n',
    '<meta charset="utf-8"/>\n',
    '<meta name="viewport" content="width=device-width, initial-scale=1"/>\n',
    '<title>Toronto Bike Share Dashboard</title>\n',
    '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css"/>\n',
    '<link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css"/>\n',
    '<style>\n', css, '\n</style>\n',
    '</head>\n',
    '<body>\n',
    '<div class="topbar"><div class="brand">',
    '<h1>Toronto Bike Share</h1><span class="sub">GBFS station telemetry</span></div>',
    '<div class="topbar-right"><span class="pulse"></span>',
    '<span>Last updated <span class="updated-at">', timestamp_str, '</span></span></div></div>\n',
    tabs, '\n',
    pane_overview,
    pane_history,
    pane_predictions,
    pane_correlations,
    pane_data,
    footer, '\n',
    '<script>window.DASHBOARD_DATA = ', data_json, ';</script>\n',
    '<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>\n',
    '<script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>\n',
    '<script src="https://cdn.plot.ly/plotly-2.30.1.min.js"></script>\n',
    '<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js"></script>\n',
    '<script>\n', js, '\n</script>\n',
    '</body>\n',
    '</html>\n'
  )
}

tryCatch({
  # Fetch station data
  station_info <- fromJSON(endpoints$station_information)$data$stations
  station_status <- fromJSON(endpoints$station_status)$data$stations

  # Merge station data and convert numeric columns
  stations <- station_info %>%
    left_join(station_status, by = "station_id") %>%
    select(station_id, name, capacity, num_bikes_available, num_docks_available,
           last_reported, lat, lon, is_installed, is_renting, is_returning) %>%
    mutate(
      capacity = as.numeric(capacity),
      num_bikes_available = as.numeric(num_bikes_available),
      num_docks_available = as.numeric(num_docks_available)
    )

  # Calculate metrics with Toronto timezone
  timestamp <- as.POSIXct(stations$last_reported[1], origin = "1970-01-01", tz = "UTC") %>%
    with_tz(tzone = "America/Toronto")
  timestamp_str <- format(timestamp, "%Y%m%d_%H%M%S")

  total_bikes <- sum(stations$num_bikes_available, na.rm = TRUE)
  total_docks <- sum(stations$num_docks_available, na.rm = TRUE)
  utilization_rate <- total_bikes / (total_bikes + total_docks) * 100
  total_stations <- nrow(stations)
  active_stations <- sum(stations$is_installed == 1 & stations$is_renting == 1 & stations$is_returning == 1)

  # Calculate additional statistics
  avg_bikes_per_station <- mean(stations$num_bikes_available, na.rm = TRUE)
  median_capacity <- median(stations$capacity, na.rm = TRUE)
  empty_stations <- sum(stations$num_bikes_available == 0)
  full_stations <- sum(stations$num_docks_available == 0)

  # Create metrics dataframe
  current_metrics <- data.frame(
    timestamp = timestamp,
    total_bikes = total_bikes,
    total_docks = total_docks,
    utilization_rate = utilization_rate,
    active_stations = active_stations,
    total_stations = total_stations,
    active_pct = active_stations / total_stations * 100,
    avg_bikes_per_station = avg_bikes_per_station,
    median_capacity = median_capacity,
    empty_stations = empty_stations,
    empty_pct = empty_stations / total_stations * 100,
    full_stations = full_stations,
    full_pct = full_stations / total_stations * 100
  )

  # Define consolidated file paths
  consolidated_metrics_path <- "data/consolidated_metrics.csv"
  consolidated_stations_path <- "data/consolidated_stations.csv"

  # Check if consolidated files exist, if not create them
  if (!file.exists(consolidated_metrics_path)) {
    write.csv(current_metrics, consolidated_metrics_path, row.names = FALSE)
    cat("Created new consolidated metrics file\n")
  } else {
    # Append current metrics to consolidated file
    write.table(current_metrics, consolidated_metrics_path,
                sep = ",", append = TRUE, col.names = FALSE, row.names = FALSE)
    cat("Appended metrics to consolidated file\n")
  }

  # Add timestamp to stations data to identify when it was captured
  stations$capture_timestamp <- timestamp

  if (!file.exists(consolidated_stations_path)) {
    write.csv(stations, consolidated_stations_path, row.names = FALSE)
    cat("Created new consolidated stations file\n")
  } else {
    # Append current stations to consolidated file
    write.table(stations, consolidated_stations_path,
                sep = ",", append = TRUE, col.names = FALSE, row.names = FALSE)
    cat("Appended stations to consolidated file\n")
  }

  # Load historical metrics from consolidated file
  if (file.exists(consolidated_metrics_path)) {
    historical_metrics <- read.csv(consolidated_metrics_path) %>%
      mutate(timestamp = as.POSIXct(timestamp))
  } else {
    historical_metrics <- current_metrics
  }

  # Process historical data
  historical_metrics <- historical_metrics %>%
    arrange(timestamp) %>%
    distinct(timestamp, .keep_all = TRUE) %>%
    mutate(
      date = as.Date(timestamp),
      bikes_ma = rollmean(total_bikes, k = 7, fill = NA, align = "right"),
      utilization_ma = rollmean(utilization_rate, k = 7, fill = NA, align = "right")
    )

  # Calculate deltas if we have previous data
  if (nrow(historical_metrics) > 1) {
    prev_metrics <- tail(historical_metrics, 2)[1, ]

    deltas <- list(
      total_bikes = current_metrics$total_bikes - prev_metrics$total_bikes,
      total_docks = current_metrics$total_docks - prev_metrics$total_docks,
      utilization_rate = current_metrics$utilization_rate - prev_metrics$utilization_rate,
      active_stations = current_metrics$active_stations - prev_metrics$active_stations,
      active_pct = current_metrics$active_pct - prev_metrics$active_pct,
      avg_bikes_per_station = current_metrics$avg_bikes_per_station - prev_metrics$avg_bikes_per_station,
      empty_stations = current_metrics$empty_stations - prev_metrics$empty_stations,
      empty_pct = current_metrics$empty_pct - prev_metrics$empty_pct,
      full_stations = current_metrics$full_stations - prev_metrics$full_stations,
      full_pct = current_metrics$full_pct - prev_metrics$full_pct
    )

    # Format deltas for display
    format_delta <- function(x, is_pct = FALSE) {
      if (is.na(x)) return("N/A")
      if (x > 0) {
        prefix <- "+"
      } else if (x < 0) {
        prefix <- "-"
      } else {
        return("")
      }

      abs_val <- abs(if (is_pct) x else round(x))

      if (is_pct) {
        paste0(prefix, sprintf("%.1f%%", abs_val))
      } else {
        paste0(prefix, format(abs_val, big.mark = ","))
      }
    }

    delta_formatted <- list(
      total_bikes = format_delta(deltas$total_bikes),
      total_docks = format_delta(deltas$total_docks),
      utilization_rate = format_delta(deltas$utilization_rate, TRUE),
      active_stations = format_delta(deltas$active_stations),
      active_pct = format_delta(deltas$active_pct, TRUE),
      avg_bikes_per_station = format_delta(deltas$avg_bikes_per_station),
      empty_stations = format_delta(deltas$empty_stations),
      empty_pct = format_delta(deltas$empty_pct, TRUE),
      full_stations = format_delta(deltas$full_stations),
      full_pct = format_delta(deltas$full_pct, TRUE)
    )
  } else {
    delta_formatted <- lapply(current_metrics[-1], function(x) "N/A")
  }

  # Top stations by bike availability
  top_bike_stations <- stations %>%
    arrange(desc(num_bikes_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_bikes_available, capacity)

  # Top stations by dock availability
  top_dock_stations <- stations %>%
    arrange(desc(num_docks_available)) %>%
    slice_head(n = 10) %>%
    select(name, num_docks_available, capacity)

  # Station status summary
  status_summary <- stations %>%
    mutate(status = case_when(
      num_bikes_available == 0 ~ "Empty",
      num_docks_available == 0 ~ "Full",
      TRUE ~ "Available"
    )) %>%
    count(status)

  # Bike availability distribution
  availability_dist <- stations %>%
    mutate(availability_pct = num_bikes_available / capacity * 100) %>%
    filter(!is.na(availability_pct))

  # Save static map for README
  static_map <- ggplot(stations, aes(x = lon, y = lat, size = num_bikes_available, color = num_bikes_available)) +
    geom_point(alpha = 0.7) +
    scale_color_viridis_c(option = "plasma") +
    labs(title = "Bike Availability Across Toronto",
         subtitle = paste("Last updated:", format(timestamp, "%Y-%m-%d %H:%M")),
         x = "Longitude", y = "Latitude") +
    theme_minimal() +
    theme(legend.position = "bottom")

  ggsave("docs/plots/location_plot.png", static_map, width = 10, height = 8)

  # Station status distribution plot
  status_plot <- ggplot(status_summary, aes(x = status, y = n, fill = status)) +
    geom_col() +
    geom_text(aes(label = n), vjust = -0.3) +
    labs(title = "Station Status Distribution",
         x = "Status", y = "Number of Stations") +
    scale_fill_viridis_d(option = "D", end = 0.8) +
    theme_minimal()

  ggsave("docs/plots/status_distribution.png", status_plot, width = 10, height = 6)

  # Bike availability distribution plot
  dist_plot <- ggplot(availability_dist, aes(x = availability_pct)) +
    geom_histogram(fill = "#1E88E5", bins = 20, color = "white") +
    labs(title = "Station Bike Availability Distribution",
         x = "Percentage of Bikes Available", y = "Number of Stations") +
    theme_minimal()

  ggsave("docs/plots/availability_dist.png", dist_plot, width = 10, height = 6)

  # Time series plots with linewidth instead of size
  if (nrow(historical_metrics) > 1) {
    # Bike and dock trends (static)
    bike_trend <- ggplot(historical_metrics, aes(x = timestamp)) +
      geom_line(aes(y = total_bikes, color = "Bikes"), linewidth = 1) +
      geom_line(aes(y = total_docks, color = "Docks"), linewidth = 1) +
      geom_line(aes(y = bikes_ma, color = "Bikes (7d MA)"), linetype = "dashed") +
      scale_color_manual(values = c("Bikes" = "#E41A1C", "Docks" = "#377EB8", "Bikes (7d MA)" = "#4DAF4A")) +
      labs(title = "Bike and Dock Availability Trend",
           x = "Date", y = "Count", color = "Metric") +
      theme_minimal() +
      theme(legend.position = "bottom")

    ggsave("docs/plots/time_series/bike_dock_trend.png", bike_trend, width = 10, height = 6)

    # Utilization trend (static)
    util_trend <- ggplot(historical_metrics, aes(x = timestamp, y = utilization_rate)) +
      geom_line(color = "#984EA3", linewidth = 1) +
      geom_line(aes(y = utilization_ma), color = "#FF7F00", linetype = "dashed") +
      labs(title = "System Utilization Rate Trend",
           x = "Date", y = "Utilization Rate (%)") +
      theme_minimal()

    ggsave("docs/plots/time_series/utilization_trend.png", util_trend, width = 10, height = 6)
  }

  # Generate README with enhanced content
  readme_content <- paste0(
    "# 🚲 Toronto Bike Share Analytics\n\n",
    "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), " (Toronto Time)\n\n",

    "## 🖥️ Live Dashboard\n",
    "View the interactive dashboard with the full history of bike availability: ",
    "[https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)\n\n",

    "## 📊 System Overview\n",
    "| Metric | Value | Change |\n",
    "|--------|-------|--------|\n",
    "| **Total bikes available** | ", format(total_bikes, big.mark = ","), " | ", delta_formatted$total_bikes, " |\n",
    "| **Total docks available** | ", format(total_docks, big.mark = ","), " | ", delta_formatted$total_docks, " |\n",
    "| **System utilization rate** | ", round(utilization_rate, 1), "% | ", delta_formatted$utilization_rate, " |\n",
    "| **Active stations** | ", active_stations, "/", total_stations, " (",
    round(active_stations/total_stations*100, 1), "%) | ", delta_formatted$active_stations, " |\n",
    "| **Average bikes per station** | ", round(avg_bikes_per_station, 1), " | ", delta_formatted$avg_bikes_per_station, " |\n",
    "| **Median station capacity** | ", median_capacity, " | - |\n",
    "| **Empty stations** | ", empty_stations, " (", round(empty_stations/total_stations*100, 1), "%) | ", delta_formatted$empty_stations, " |\n",
    "| **Full stations** | ", full_stations, " (", round(full_stations/total_stations*100, 1), "%) | ", delta_formatted$full_stations, " |\n\n",

    "## 🏆 Top 10 Stations by Bike Availability\n",
    "| Station | Bikes Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_bike_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## 🏆 Top 10 Stations by Dock Availability\n",
    "| Station | Docks Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_dock_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## 📊 Station Status Distribution\n",
    "| Status     | Number of Stations |\n",
    "|------------|-------------------:|\n",
    "| Empty      | ", status_summary$n[status_summary$status == "Empty"], " |\n",
    "| Full       | ", status_summary$n[status_summary$status == "Full"], " |\n",
    "| Available  | ", status_summary$n[status_summary$status == "Available"], " |\n\n",

    "## 📍 Bike Locations\n",
    "![Bike Locations](docs/plots/location_plot.png)\n\n",

    "## 📊 Station Status Distribution\n",
    "![Status Distribution](docs/plots/status_distribution.png)\n\n",

    "## 📈 Bike Availability Distribution\n",
    "![Availability Distribution](docs/plots/availability_dist.png)\n\n",

    if (nrow(historical_metrics) > 1) {
      paste0(
        "## 📈 Historical Trends\n",
        "### Bike and Dock Availability\n",
        "![Bike and Dock Trend](docs/plots/time_series/bike_dock_trend.png)\n\n",
        "### System Utilization Rate\n",
        "![Utilization Trend](docs/plots/time_series/utilization_trend.png)\n\n"
      )
    } else "",

    "## 📊 Sampling Methodology\n",
    "The data is collected from the Toronto Bike Share GBFS API at a single point in time. ",
    "This provides a snapshot of the system but may not capture temporal variations.\n\n",

    "### Key Metrics Explained\n",
    "1. **Utilization Rate**: The proportion of total bike slots that are occupied by bikes:\n",
    "   $$\\text{Utilization Rate} = \\frac{\\text{Total Bikes}}{\\text{Total Bikes} + \\text{Total Docks}} \\times 100\\%$$\n\n",
    "2. **Station Status Classification**:\n",
    "   - **Empty**: $\\text{bikes} = 0$\n",
    "   - **Full**: $\\text{docks} = 0$\n",
    "   - **Available**: $\\text{bikes} > 0$ and $\\text{docks} > 0$\n\n",

    "### Statistical Notes\n",
    "- The distribution of bikes across stations follows a ",
    ifelse(mean(availability_dist$availability_pct) > median(availability_dist$availability_pct),
           "right-skewed", "left-skewed"), " distribution\n",
    "- The mean availability is ", round(mean(availability_dist$availability_pct), 1), "% ",
    "with a standard deviation of ", round(sd(availability_dist$availability_pct), 1), "%\n",
    "- The system is currently operating at ", round(utilization_rate), "% capacity\n\n",

    "## ℹ️ Data Source\n",
    "Data is sourced from the [Toronto Bike Share GBFS API]",
    "(https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)"
  )

  # Run predictive model and append predictions to README
  source("predictive_model.R")
  prediction_results <- run_predictive_model()
  predictions_markdown <- format_predictions_for_readme(prediction_results$predictions, prediction_results$events_data)

  readme_content <- paste0(readme_content, "\n\n", predictions_markdown)

  writeLines(readme_content, "README.md")

  # Generate interactive dashboard
  dashboard_html <- generate_dashboard_html(current_metrics, delta_formatted, timestamp,
                                            historical_metrics, stations, prediction_results,
                                            status_summary, availability_dist)
  writeLines(dashboard_html, "docs/index.html")
  cat("Generated docs/index.html dashboard\n")

}, error = function(e) {
  message("Error processing data: ", conditionMessage(e))
  # Create error placeholder
  error_content <- paste(
    "# 🚨 Error in Bike Share Dashboard",
    "The automated update failed to process the bike share data.",
    "## Details:",
    paste("```", conditionMessage(e), "```", sep = "\n"),
    sep = "\n\n"
  )
  writeLines(error_content, "README.md")
  writeLines(
    paste0(
      '<!DOCTYPE html>\n<html lang="en"><head><meta charset="utf-8"/>\n',
      '<title>Toronto Bike Share Dashboard</title></head>\n',
      '<body style="font-family:sans-serif;text-align:center;padding-top:60px;">\n',
      '<h1>🚨 Error in Bike Share Dashboard</h1>\n',
      '<p>The automated update failed to process the bike share data.</p>\n',
      '<pre>', htmltools::htmlEscape(conditionMessage(e)), '</pre>\n',
      '</body></html>\n'
    ),
    "docs/index.html"
  )
})
