# Interactive dashboard generation (Grafana-style dark theme, self-contained page).
#
# Renders a single docs/index.html that embeds the plotly payloads, station
# data, and all table rows as JSON; the client-side logic in dashboard/app.js
# builds the charts, map, and tables. No external R widgets are saved.

suppressPackageStartupMessages({
  library(dplyr)
  library(lubridate)
  library(plotly)
  library(htmltools)
})

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

build_neighbourhood_chart <- function(nbhd_summary) {
  if (is.null(nbhd_summary) || nrow(nbhd_summary) == 0) return(NULL)
  top <- nbhd_summary %>% slice_head(n = 15) %>% arrange(bikes)
  p <- plotly::plot_ly(top, x = ~bikes, y = ~neighbourhood, type = "bar", orientation = "h",
                       marker = list(color = "#3d8bfd",
                                     line = list(color = "#161a24", width = 0.5)),
                       customdata = ~paste0(utilization, "%"),
                       text = ~bikes, textposition = "outside",
                       hovertemplate = "%{y}<br>%{x} bikes<br>%{customdata} utilization") %>%
    apply_dark_layout(extra = list(showlegend = FALSE,
      xaxis = list(title = "Bikes available", gridcolor = "#262b38", zerolinecolor = "#262b38"),
      yaxis = list(title = "", gridcolor = "#262b38", zerolinecolor = "#262b38", automargin = TRUE)))
  plotly_payload(p)
}

nbhd_tiles_html <- function(nbhd_summary) {
  if (is.null(nbhd_summary) || nrow(nbhd_summary) == 0) return("")
  paste0('<div class="nbhd-tiles">',
    paste0(vapply(seq_len(nrow(nbhd_summary)), function(i) {
      r <- nbhd_summary[i, ]
      av <- suppressWarnings(as.numeric(r$avg_availability))
      if (!is.finite(av)) av <- 0
      paste0('<div class="nbhd-card">',
        '<div class="nbhd-name">', htmltools::htmlEscape(r$neighbourhood), '</div>',
        '<div class="nbhd-meta">', fmt_num(r$stations), ' stations &middot; ',
        fmt_num(r$bikes), ' bikes &middot; ', fmt_num(r$docks), ' docks</div>',
        '<div class="nbhd-util"><div class="nbhd-util-bar" style="width:',
        min(100, av), '%"></div></div>',
        '<div class="nbhd-util-label">', fmt_pct1(r$utilization),
        ' utilization &middot; ', fmt_pct1(av), ' avg availability</div>',
        '</div>')
    }, character(1)), collapse = ""),
    '</div>')
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

build_tables <- function(stations, prediction_results, historical_metrics,
                         nbhd_summary = NULL) {
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

  nbhd_rows <- character(0)
  if (!is.null(nbhd_summary) && nrow(nbhd_summary) > 0) {
    nbhd_rows <- apply(nbhd_summary, 1, function(r) paste0(
      "<tr><td>", htmltools::htmlEscape(r[["neighbourhood"]]), '</td><td class="num">',
      fmt_num(r[["stations"]]), '</td><td class="num">', fmt_num(r[["bikes"]]),
      '</td><td class="num">', fmt_num(r[["docks"]]),
      '</td><td class="num">', fmt_num(r[["capacity"]]),
      '</td><td class="num">', fmt_pct1(r[["utilization"]]),
      '</td><td class="num">', fmt_num(r[["empty"]]),
      '</td><td class="num">', fmt_num(r[["full"]]),
      '</td><td class="num">', fmt_pct1(r[["avg_availability"]]), "</td></tr>"))
  }

  list(
    top_bikes = tbl("tbl-top-bikes", c("Station", "Bikes", "Capacity"), bikes_rows),
    top_docks = tbl("tbl-top-docks", c("Station", "Docks", "Capacity"), docks_rows),
    events = tbl("tbl-events", c("Event", "Source", "Date", "Type"), events_rows),
    predictions = tbl("tbl-predictions", c("Station", "Change", "Action", "Confidence", "Impact"), pred_rows),
    recommendations = tbl("tbl-recommendations", c("Station", "Change", "Action", "Impact"), rec_rows),
    stations_all = tbl("tbl-stations", c("Station", "Status", "Bikes", "Docks", "Capacity", "Lat", "Lon"), st_rows),
    history = tbl("tbl-history", c("Timestamp", "Bikes", "Docks", "Util", "Active", "Empty %", "Full %"), hist_rows),
    neighbourhoods = tbl("tbl-neighbourhoods",
                         c("Neighbourhood", "Stations", "Bikes", "Docks", "Capacity",
                           "Utilization", "Empty", "Full", "Avg Avail"),
                         nbhd_rows)
  )
}

generate_dashboard_html <- function(current_metrics, delta_formatted, timestamp,
                                    historical_metrics, stations, prediction_results,
                                    status_summary, availability_dist) {
  timestamp_str <- format(timestamp, "%Y-%m-%d %H:%M")

  about_tab <- generate_info_tab(current_metrics, timestamp)

  css <- paste0(readLines(file.path(DASHBOARD_DIR, "style.css"), warn = FALSE), collapse = "\n")
  js <- paste0(readLines(file.path(DASHBOARD_DIR, "app.js"), warn = FALSE), collapse = "\n")

  charts <- build_charts(historical_metrics, availability_dist, status_summary)
  charts <- c(charts, build_correlations(historical_metrics))

  nbhd_summary <- summarize_neighbourhoods(stations)
  charts[["nbhd"]] <- build_neighbourhood_chart(nbhd_summary)

  data_payload <- list(
    updated = timestamp_str,
    historyRange = if (!is.null(historical_metrics) && nrow(historical_metrics) > 1) {
      c(format(min(historical_metrics$timestamp), "%Y-%m-%d"),
        format(max(historical_metrics$timestamp), "%Y-%m-%d"))
    } else NULL,
    stats = build_stats(current_metrics, delta_formatted),
    stations = build_map_stations(stations),
    neighbourhoods = nbhd_summary,
    charts = charts
  )
  data_json <- json_embed(data_payload)

  tables <- build_tables(stations, prediction_results, historical_metrics, nbhd_summary)
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
    '<div id="tab-overview" class="tab-pane">',
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

  pane_neighbourhoods <- paste0(
    '<div id="tab-neighbourhoods" class="tab-pane">',
    '<div class="panel"><div class="panel-head"><h3 class="panel-title">How to read this</h3></div>',
    '<div class="panel-body"><p class="ev-src" style="margin:0">Stations are assigned to the ',
    'nearest well-known neighbourhood anchor point (approximate Voronoi partition). ',
    'Utilization is the share of dock capacity currently holding a bike.',
    '</p></div></div>',
    chart_panel("Bikes Available by Neighbourhood", "chart-nbhd", "chart-md"),
    '<div class="panel"><div class="panel-head"><h3 class="panel-title">Neighbourhood Cards</h3></div>',
    '<div class="panel-body">', nbhd_tiles_html(nbhd_summary), '</div></div>',
    table_panel("Neighbourhood Breakdown", tables$neighbourhoods),
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
    '<button class="active" data-tab="about">About</button>',
    '<button data-tab="overview">Overview</button>',
    '<button data-tab="history">History</button>',
    '<button data-tab="neighbourhoods">Neighbourhoods</button>',
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
    about_tab,
    pane_overview,
    pane_history,
    pane_neighbourhoods,
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
