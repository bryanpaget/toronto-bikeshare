# Generic helpers shared across the pipeline and dashboard generation.

# Recursively strip S3 classes so data frames and plotly payloads serialize
# as plain lists / row-oriented data frames in embedded JSON.
unclass_deep <- function(x) {
  if (inherits(x, "data.frame")) return(as.data.frame(x))
  if (is.list(x)) {
    x[] <- lapply(x, unclass_deep)
    class(x) <- NULL
  }
  x
}

# Serialize an R object to JSON safe to embed in an HTML <script> block
# (escapes "</" so it can never close the script tag early).
json_embed <- function(x) {
  gsub("</", "<\\/",
       jsonlite::toJSON(unclass_deep(x), auto_unbox = TRUE, dataframe = "rows",
                        null = "null", na = "null", digits = 8))
}

# Format a number with thousands separators (or an en-dash when NA).
fmt_num <- function(x) {
  n <- suppressWarnings(as.numeric(x))
  if (is.na(n)) return("\u2013")
  format(round(n), big.mark = ",", scientific = FALSE)
}

# Format a number as a percentage with one decimal place (or an en-dash when NA).
fmt_pct1 <- function(x) {
  n <- suppressWarnings(as.numeric(x))
  if (is.na(n)) return("\u2013")
  paste0(format(round(n, 1), big.mark = ",", scientific = FALSE), "%")
}

# CSS class for a delta value shown on the stat cards (up / down / flat).
delta_class <- function(d) {
  if (is.na(d) || d %in% c("", "N/A")) "flat"
  else if (grepl("^\\+", d)) "up"
  else "down"
}
