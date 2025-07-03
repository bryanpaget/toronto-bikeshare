# update_report.R

library(arrow)
library(dplyr)
library(readr)
library(ggplot2)
library(lubridate)

# Create folders if missing
dir.create("data", showWarnings = FALSE)
dir.create("plots", showWarnings = FALSE)

# Johns Hopkins CSSE COVID-19 daily data (confirmed cases)
url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

# Read data
covid_raw <- read_csv(url)

# Clean data
covid_long <- covid_raw %>%
  select(-Lat, -Long) %>%
  group_by(`Country/Region`) %>%
  summarise(across(where(is.numeric), sum)) %>%
  tidyr::pivot_longer(
    cols = -`Country/Region`,
    names_to = "date",
    values_to = "cases"
  ) %>%
  mutate(date = mdy(date)) %>%
  arrange(`Country/Region`, date)

# Save as parquet
write_parquet(covid_long, "data/covid_data.parquet")

# Summarize latest data (last 7 days)
latest_data <- covid_long %>%
  group_by(`Country/Region`) %>%
  filter(date == max(date)) %>%
  arrange(desc(cases)) %>%
  slice_head(n = 10)

# Make a plot
plot_data <- covid_long %>%
  filter(`Country/Region` %in% latest_data$`Country/Region`) %>%
  group_by(`Country/Region`, date) %>%
  summarise(cases = sum(cases), .groups = "drop")

p <- ggplot(plot_data, aes(x = date, y = cases, color = `Country/Region`)) +
  geom_line(size = 1) +
  labs(title = "Top 10 Countries - COVID-19 Confirmed Cases Over Time",
       x = "Date", y = "Cumulative Cases") +
  theme_minimal()

ggsave("plots/covid_plot.png", plot = p, width = 10, height = 6)

# Create README
readme_text <- paste0(
  "# 🦠 COVID-19 Daily Report\n\n",
  "Updated automatically every night.\n\n",
  "## 📊 Top 10 Countries by Total Cases\n\n",
  knitr::kable(latest_data, format = "markdown"),
  "\n\n## 📈 Trend Over Time\n\n",
  "![COVID-19 Trend](plots/covid_plot.png)\n"
)

writeLines(readme_text, "README.md")
