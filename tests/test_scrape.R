# Unit tests for RSS/Atom scraping in R/predictive_model.R.

args <- commandArgs()
script_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
root <- if (length(script_arg) && nzchar(script_arg)) {
  normalizePath(file.path(dirname(script_arg), ".."))
} else {
  getwd()
}
source(file.path(root, "R", "predictive_model.R"))

suppressPackageStartupMessages({library(dplyr); library(lubridate)})

# Build a valid RFC-822 pubDate relative to today so the 14-day event window
# check stays deterministic regardless of when the suite is run.
rss_date <- function(days_from_today) {
  x <- as.POSIXct(paste(Sys.Date() + days_from_today, "12:00:00"), tz = "UTC")
  format(x, "%a, %d %b %Y %H:%M:%S +0000")
}

rss_feed <- paste0(
'<rss><channel>',
'<item><title>Concert in Trinity Bellwoods</title><description>A big concert</description><pubDate>', rss_date(1), '</pubDate><link>https://ex.com/1</link></item>',
'<item><title>Food Festival at Exhibition Place</title><description>Food and beer</description><pubDate>', rss_date(0), '</pubDate><link>https://ex.com/2</link></item>',
'<item><title>Old news story</title><description>Ancient</description><pubDate>', rss_date(-60), '</pubDate><link>https://ex.com/3</link></item>',
'<item><title>Mystery Event With No Date</title><description></description></item>',
'</channel></rss>')

atom_feed <- paste0(
'<feed>',
'<entry><title>Art Fair in Distillery</title><summary>Gallery show</summary><published>', rss_date(2), '</published><link href="https://ex.com/a1"/></entry>',
'<entry><title>Sports Game</title><summary>Match tonight</summary><published>', rss_date(1), '</published><link>https://ex.com/a2</link></entry>',
'</feed>')

cat("=== RSS feed ===\n")
r <- scrape_single_rss_feed(rss_feed, "TestRSS")
print(r[, c("event_title", "event_description", "event_link", "event_date")])
stopifnot(nrow(r) == 3)  # old June story is filtered out by the 14-day window
stopifnot(all(c("event_title", "event_description", "event_link", "event_date") %in% names(r)))

cat("\n=== Atom feed ===\n")
a <- scrape_single_rss_feed(atom_feed, "TestAtom")
print(a[, c("event_title", "event_link", "event_date")])
stopifnot(nrow(a) == 2)
stopifnot("https://ex.com/a1" %in% a$event_link)  # href attribute parsed

cat("\n=== invalid feed (graceful) ===\n")
bad <- scrape_single_rss_feed("not a url", "Broken")
stopifnot(is.null(bad))
cat("invalid feed handled (NULL) OK\n")

cat("\n=== clean_html_text + event gate ===\n")
d1 <- clean_html_text("<img src='x.jpg'>Concert &amp; more")
stopifnot(!grepl("<img", d1, fixed = TRUE), grepl("&", d1, fixed = TRUE), !grepl("  ", d1, fixed = TRUE))
stopifnot(is_actual_event("Concert in Trinity Bellwoods", "live music") == TRUE)
stopifnot(is_actual_event("How to find a good hotel deal", "tips and deals") == FALSE)
cat("ALL SCRAPE TESTS PASSED\n")
