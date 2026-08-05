/* Toronto Bike Share dashboard - client logic.
 * Consumes window.DASHBOARD_DATA (embedded JSON) and renders into DOM ids:
 * charts: #chart-ts-main #chart-ts-util #chart-hist-avail #chart-corr #chart-wd-hour #chart-scatter
 * map: #map (+ #map-search, #map-status, #map-count)
 * tables: #tbl-top-bikes #tbl-top-docks #tbl-events #tbl-predictions #tbl-recommendations #tbl-stations #tbl-history
 */
(function () {
  "use strict";
  var D = window.DASHBOARD_DATA || {};
  var $ = function (id) { return document.getElementById(id); };

  function esc(s) {
    return String(s == null ? "" : s).replace(/&/g, "&amp;").replace(/</g, "&lt;")
      .replace(/>/g, "&gt;").replace(/"/g, "&quot;");
  }
  function fmt(n) { return Number(n).toLocaleString("en-US"); }
  function pct(n) { return (Number(n) > 0 ? "+" : "") + Number(n).toFixed(1) + "%"; }

  /* ---------------- charts ---------------- */
  var CHART_IDS = {
    "ts-main": "chart-ts-main",
    "ts-util": "chart-ts-util",
    "hist-avail": "chart-hist-avail",
    "status": "chart-status",
    "corr": "chart-corr",
    "wd-hour": "chart-wd-hour",
    "scatter": "chart-scatter"
  };
  var chartEls = {};

  function renderCharts() {
    if (typeof Plotly === "undefined") return;
    Object.keys(CHART_IDS).forEach(function (key) {
      var cfg = (D.charts || {})[key];
      var el = $(CHART_IDS[key]);
      if (!cfg || !el) return;
      var opts = {
        responsive: true,
        displaylogo: false,
        modeBarButtonsToRemove: ["lasso2d", "select2d", "autoScale2d", "toggleSpikelines"]
      };
      if (cfg.config) opts = Object.assign({}, opts, cfg.config, {displaylogo: false});
      Plotly.newPlot(el, cfg.data, cfg.layout || {}, opts);
      chartEls[key] = el;
    });
  }

  /* ---------------- date-range slicer ---------------- */
  function applyRange() {
    var s = $("slicer-start").value, e = $("slicer-end").value;
    ["ts-main", "ts-util"].forEach(function (key) {
      var el = chartEls[key];
      if (!el) return;
      if (!s && !e) { Plotly.relayout(el, {"xaxis.autorange": true}); return; }
      Plotly.relayout(el, {"xaxis.range": [s || undefined, e || undefined]});
    });
  }
  function setRange(days) {
    var end = D.historyRange && D.historyRange[1] ? D.historyRange[1] : new Date().toISOString().slice(0, 10);
    var start = D.historyRange && D.historyRange[0] ? D.historyRange[0] : "2020-01-01";
    if (days) {
      var d = new Date(end + "T00:00:00");
      d.setDate(d.getDate() - (days - 1));
      start = d.toISOString().slice(0, 10);
    }
    $("slicer-start").value = start;
    $("slicer-end").value = days ? end : "";
    applyRange();
    document.querySelectorAll(".btn-preset").forEach(function (b) {
      b.classList.toggle("active", Number(b.dataset.days) === (days || 0));
    });
  }
  function initSlicers() {
    if (!$("slicer-start")) return;
    $("slicer-start").value = D.historyRange ? D.historyRange[0] : "";
    $("slicer-end").value = D.historyRange ? D.historyRange[1] : "";
    $("slicer-start").addEventListener("change", applyRange);
    $("slicer-end").addEventListener("change", applyRange);
    document.querySelectorAll(".btn-preset").forEach(function (b) {
      b.addEventListener("click", function () { setRange(Number(b.dataset.days)); });
    });
    var all = document.querySelector(".btn-preset[data-days='0']");
    if (all) all.classList.add("active");
  }

  /* ---------------- map ---------------- */
  var map = null, markers = [], layer = null;
  function initMap() {
    if (!$("map")) return;
    map = L.map("map", { scrollWheelZoom: false }).setView([43.655, -79.385], 12);
    L.tileLayer("https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png", {
      attribution: "&copy; OpenStreetMap &copy; CARTO", maxZoom: 19
    }).addTo(map);
    (D.stations || []).forEach(function (s) {
      var color = s.status === "Empty" ? "#f44336" : (s.status === "Full" ? "#f59e0b" : "#3d8bfd");
      var m = L.circleMarker([s.lat, s.lon], {
        radius: Math.max(4, Math.sqrt(s.bikes + 1) * 1.6),
        color: color, fillColor: color, fillOpacity: 0.75, stroke: false
      });
      m.bindPopup("<b>" + esc(s.name) + "</b><br>Bikes: " + s.bikes +
        "<br>Docks: " + s.docks + "<br>Capacity: " + s.capacity);
      m.s = s;
      markers.push(m);
    });
    layer = L.layerGroup();
    layer.addTo(map);
    updateMap();
  }
  function updateMap() {
    layer.clearLayers();
    var st = $("map-status").value;
    var q = ($("map-search").value || "").toLowerCase();
    var count = 0;
    markers.forEach(function (m) {
      if (st !== "all" && m.s.status !== st) return;
      if (q && m.s.name.toLowerCase().indexOf(q) === -1) return;
      layer.addLayer(m);
      count++;
    });
    if ($("map-count")) $("map-count").textContent = count.toLocaleString("en-US") + " / " + markers.length.toLocaleString("en-US") + " stations";
  }
  function initMapSlicers() {
    if (!$("map-status")) return;
    $("map-status").addEventListener("change", updateMap);
    $("map-search").addEventListener("input", updateMap);
  }

  /* ---------------- tables ---------------- */
  function initTables() {
    if (typeof $ === "undefined" || typeof window.jQuery === "undefined") return;
    var base = {
      pageLength: 10,
      lengthMenu: [10, 25, 50, 100],
      ordering: true,
      dom: "<'dt-toolbar'lf>rtip"
    };
    var ids = ["tbl-top-bikes", "tbl-top-docks", "tbl-events", "tbl-predictions",
               "tbl-recommendations", "tbl-stations", "tbl-history"];
    ids.forEach(function (id) {
      var el = $(id);
      if (!el) return;
      var cfg = Object.assign({}, base, { pageLength: id === "tbl-stations" || id === "tbl-history" ? 25 : 10 });
      if (id === "tbl-events") cfg.order = [[2, "asc"]];
      if (id === "tbl-history") cfg.order = [[0, "desc"]];
      window.jQuery(el).DataTable(cfg);
    });
  }

  /* ---------------- tabs ---------------- */
  function initTabs() {
    var buttons = document.querySelectorAll(".nav-tabs button[data-tab]");
    if (!buttons.length) return;
    function activate(btn) {
      buttons.forEach(function (b) { b.classList.remove("active"); });
      document.querySelectorAll(".tab-pane").forEach(function (p) { p.classList.remove("active"); });
      btn.classList.add("active");
      var pane = $("tab-" + btn.dataset.tab);
      if (pane) pane.classList.add("active");
      if (typeof Plotly !== "undefined") {
        pane.querySelectorAll(".js-plotly-plot").forEach(function (node) { Plotly.Plots.resize(node); });
      }
    }
    buttons.forEach(function (btn) {
      btn.addEventListener("click", function () { activate(btn); });
    });
    document.querySelectorAll("[data-goto-tab]").forEach(function (el) {
      el.addEventListener("click", function () {
        var btn = document.querySelector(".nav-tabs button[data-tab='" + el.dataset.gotoTab + "']");
        if (btn) activate(btn);
      });
    });
  }

  /* ---------------- init ---------------- */
  function init() {
    renderCharts();
    initSlicers();
    initMap();
    initMapSlicers();
    initTables();
    initTabs();
  }
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
