# Runs the full test suite for Toronto Bike Share Analytics.
#
# Usage:  Rscript tests/run_all.R

args <- commandArgs()
script_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
root <- if (length(script_arg) && nzchar(script_arg)) {
  normalizePath(file.path(dirname(script_arg), ".."))
} else {
  getwd()
}

scripts <- c(
  file.path(root, "tests", "test_scrape.R"),
  file.path(root, "tests", "test_predictive.R"),
  file.path(root, "tests", "test_dashboard.R")
)

results <- lapply(scripts, function(script) {
  cat("\n=====", basename(script), "=====\n")
  ok <- FALSE
  msg <- tryCatch({
    source(script, local = new.env(parent = globalenv()))
    ok <- TRUE
    "PASSED"
  }, error = function(e) conditionMessage(e))
  cat("-----", basename(script), ":", if (ok) "PASSED" else paste("FAILED -", msg), "-----\n")
  list(file = basename(script), ok = ok, msg = msg)
})

failed <- Filter(function(r) !r$ok, results)
cat("\n========================================\n")
if (length(failed) == 0) {
  cat("Test suite: ALL TESTS PASSED\n")
} else {
  cat("Test suite:", length(failed), "test file(s) FAILED\n")
  for (f in failed) cat(" -", f$file, ":", f$msg, "\n")
  quit(status = 1)
}
