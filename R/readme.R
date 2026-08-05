# README generation.
#
# The README is fully regenerated on every run: live metrics and charts first,
# followed by narrative background about bike share systems, and finally the
# predictive analytics section (appended by the orchestrator).

generate_readme_content <- function(snapshot, delta_formatted) {
  timestamp <- snapshot$timestamp
  cm <- snapshot$current_metrics
  status_summary <- snapshot$status_summary
  availability_dist <- snapshot$availability_dist
  historical_metrics <- snapshot$historical_metrics
  top_bike_stations <- snapshot$top_bike_stations
  top_dock_stations <- snapshot$top_dock_stations

  total_bikes <- cm$total_bikes
  total_docks <- cm$total_docks
  utilization_rate <- cm$utilization_rate
  total_stations <- cm$total_stations
  active_stations <- cm$active_stations
  avg_bikes_per_station <- cm$avg_bikes_per_station
  median_capacity <- cm$median_capacity
  empty_stations <- cm$empty_stations
  full_stations <- cm$full_stations

  paste0(
    "# \U0001F6B2 Toronto Bike Share Analytics\n\n",
    "Updated: ", format(timestamp, "%Y-%m-%d %H:%M"), " (Toronto Time)\n\n",

    "## \U0001F5A5\uFE0F Live Dashboard\n",
    "View the interactive dashboard with the full history of bike availability: ",
    "[https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)\n\n",

    "## \U0001F4CA System Overview\n",
    "| Metric | Value | Change |\n",
    "|--------|-------|--------|\n",
    "| **Total bikes available** | ", format(total_bikes, big.mark = ","), " | ", delta_formatted$total_bikes, " |\n",
    "| **Total docks available** | ", format(total_docks, big.mark = ","), " | ", delta_formatted$total_docks, " |\n",
    "| **System utilization rate** | ", round(utilization_rate, 1), "% | ", delta_formatted$utilization_rate, " |\n",
    "| **Active stations** | ", active_stations, "/", total_stations, " (",
    round(active_stations / total_stations * 100, 1), "%) | ", delta_formatted$active_stations, " |\n",
    "| **Average bikes per station** | ", round(avg_bikes_per_station, 1), " | ", delta_formatted$avg_bikes_per_station, " |\n",
    "| **Median station capacity** | ", median_capacity, " | - |\n",
    "| **Empty stations** | ", empty_stations, " (", round(empty_stations / total_stations * 100, 1),
    "%) | ", delta_formatted$empty_stations, " |\n",
    "| **Full stations** | ", full_stations, " (", round(full_stations / total_stations * 100, 1),
    "%) | ", delta_formatted$full_stations, " |\n\n",

    "## \U0001F3C6 Top 10 Stations by Bike Availability\n",
    "| Station | Bikes Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_bike_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## \U0001F3C6 Top 10 Stations by Dock Availability\n",
    "| Station | Docks Available | Capacity |\n",
    "|---------|-----------------|----------|\n",
    paste(apply(top_dock_stations, 1, function(row) {
      paste0("| ", row[1], " | ", row[2], " | ", row[3], " |")
    }), collapse = "\n"),
    "\n\n",

    "## \U0001F4CA Station Status Distribution\n",
    "| Status     | Number of Stations |\n",
    "|------------|-------------------:|\n",
    "| Empty      | ", status_summary$n[status_summary$status == "Empty"], " |\n",
    "| Full       | ", status_summary$n[status_summary$status == "Full"], " |\n",
    "| Available  | ", status_summary$n[status_summary$status == "Available"], " |\n\n",

    "## \U0001F4CD Bike Locations\n",
    "![Bike Locations](docs/plots/location_plot.png)\n\n",

    "## \U0001F4C8 Bike Availability Distribution\n",
    "![Availability Distribution](docs/plots/availability_dist.png)\n\n",

    if (!is.null(historical_metrics) && nrow(historical_metrics) > 1) {
      paste0(
        "## \U0001F4C8 Historical Trends\n",
        "### Bike and Dock Availability\n",
        "![Bike and Dock Trend](docs/plots/time_series/bike_dock_trend.png)\n\n",
        "### System Utilization Rate\n",
        "![Utilization Trend](docs/plots/time_series/utilization_trend.png)\n\n"
      )
    } else "",

    "## \U0001F4CA Sampling Methodology\n",
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

    "## \u2139\uFE0F Data Source\n",
    "Data is sourced from the [Toronto Bike Share GBFS API]",
    "(https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)\n\n",

    "## \U0001F6B4 About Bike Share Toronto\n",
    "Bike Share Toronto is the city's public bike share system, owned and operated by the ",
    "Toronto Parking Authority. It launched in May 2011 as Bixi Toronto with about 1,000 bikes and ",
    "80 stations, and was rebranded as Bike Share Toronto when the Toronto Parking Authority took ",
    "over operations in 2014. Today it has grown to more than 1,000 stations and 10,000+ bikes ",
    "(including roughly 2,100 electric bikes) across the city.\n\n",
    "The system has expanded rapidly alongside the city's cycling network. Annual ridership grew from ",
    "about 2.9 million trips in 2020 to 5.7 million in 2023, 7.0 million in 2024, and a record ",
    "7.8 million trips in 2025 \u2014 with continued growth expected in 2026 as more e-bikes, charging ",
    "docks, and stations are added.\n\n",
    "The city's 2030 Growth Strategy (Ride More, Connect More) lays out a roadmap for roughly doubling ",
    "the network, integrating bike share more closely with transit, and expanding into underserved ",
    "neighbourhoods. Equity programs such as the Reduced Fare Pass make the system more affordable, ",
    "and expansion priorities are informed by research on how to make bike share reach more residents ",
    "in lower-income areas.\n\n",
    "- Official site: [bikesharetoronto.com](https://bikesharetoronto.com/)\n",
    "- Overview & history: [Wikipedia - Bike Share Toronto](https://en.wikipedia.org/wiki/Bike_Share_Toronto)\n",
    "- City of Toronto: [Toronto Parking Authority - 2030 Growth Strategy (PDF)](https://www.toronto.ca/legdocs/mmis/2025/pa/bgrd/backgroundfile-260875.pdf)\n\n",

    "## \U0001F6B2 Bike Share Across Canada and the World\n",
    "Toronto is part of a growing network of public bike share systems. Montreal's BIXI (2009) was ",
    "the first modern public bike share in North America, and other major Canadian systems include ",
    "Vancouver's Mobi by Shaw Go (2016) and Hamilton's bike share (2015). Internationally, the ",
    "well-known systems include Paris' V\u00E9lib', London's Santander Cycles, New York's Citi Bike, and ",
    "Washington D.C.'s Capital Bikeshare. Hundreds of cities worldwide now operate docked or ",
    "dockless bike share programs as part of their urban mobility toolkit.\n\n",

    "## \U0001F30D Why Bike Share Matters for Cities\n",
    "Bike share systems deliver a broad set of benefits for cities and their residents:\n",
    "1. **First- and last-mile connections**: Bike share fills the gap between transit stops (GO, TTC, ",
    "   and regional rail) and people's homes, workplaces, and errands, extending the reach of public ",
    "   transit without large capital investment.\n",
    "2. **Less congestion**: Short car trips can be replaced by bikes, easing road congestion. Research ",
    "   on Washington D.C.'s Capital Bikeshare estimated it reduced neighbourhood-level traffic ",
    "   congestion by up to 4% (Hamilton & Wichman, 2018).\n",
    "3. **Health benefits**: Bike share encourages everyday physical activity. A study of European ",
    "   bike share systems estimated that, if all bike share trips replaced car trips, up to 73 ",
    "   deaths could be prevented each year across those cities \u2014 and benefits outweigh risks in ",
    "   every scenario considered (Otero, Nieuwenhuijsen & Rojas-Rueda, 2018).\n",
    "4. **Lower emissions**: Replacing car trips reduces greenhouse gas emissions and local air ",
    "   pollution, supporting municipal climate and Vision Zero goals.\n",
    "5. **Equitable, affordable mobility**: At low cost, bike share provides flexible mobility to ",
    "   residents who may not own a bike or a car, and targeted pricing and station placement can ",
    "   address transportation inequity in lower-income neighbourhoods (see TMU research below).\n",
    "6. **Efficient use of public space**: A single bike lane or docked station moves many more ",
    "   people per hour than the equivalent car parking, making better use of valuable street space.\n\n",

    "## \U0001F4DA Research & Further Reading\n",
    "- **Health impacts of bike share** \u2014 Otero, I., Nieuwenhuijsen, M.J. & Rojas-Rueda, D. (2018). ",
    "  *Health impacts of bike sharing systems in Europe*. Environment International, 115, 387-394. ",
    "  [https://doi.org/10.1016/j.envint.2018.04.014](https://doi.org/10.1016/j.envint.2018.04.014)\n",
    "- **Congestion reduction** \u2014 Hamilton, T.L. & Wichman, C.J. (2018). *Bicycle infrastructure and ",
    "  traffic congestion: Evidence from DC's Capital Bikeshare*. Journal of Environmental Economics ",
    "  and Management, 87, 72-93. [https://doi.org/10.1016/j.jeem.2017.03.007](https://doi.org/10.1016/j.jeem.2017.03.007)\n",
    "- **Review of the bike share literature** \u2014 Fishman, E., Washington, S. & Haworth, N. (2013). ",
    "  *Bike Share: A Synthesis of the Literature*. Transport Reviews, 33(2), 148-165. ",
    "  [https://doi.org/10.1080/01441647.2013.775612](https://doi.org/10.1080/01441647.2013.775612)\n",
    "- **Equity in Toronto's bike share** \u2014 Mekonnen, S. (2022). *A Plan for an Equitable Expansion of ",
    "  Bike Share Toronto* (Toronto Metropolitan University). ",
    "  [https://doi.org/10.32920/17329601](https://doi.org/10.32920/17329601)\n\n",

    "## \U0001F91D Canadian Cycling & Urban Associations\n",
    "- **V\u00E9lo Canada Bikes** \u2014 Canada's national cycling advocacy organization. ",
    "  [https://velocanadabikes.org](https://velocanadabikes.org/)\n",
    "- **Cycle Toronto** \u2014 Toronto's member-supported cycling advocacy charity, promotes safe cycling ",
    "  across the city. [https://www.cycleto.ca](https://www.cycleto.ca/)\n",
    "- **Share the Road Cycling Coalition** \u2014 Ontario-wide coalition working with municipalities on ",
    "  cycling infrastructure and policy. [https://sharetheroad.ca](https://sharetheroad.ca/)\n",
    "- **Transportation Association of Canada (TAC)** \u2014 National association producing guides and ",
    "  standards for sustainable transportation and active mobility. ",
    "  [https://www.tac-atc.ca](https://www.tac-atc.ca/en)\n",
    "- **City of Toronto - Cycling** \u2014 City cycling network, maps, and programs. ",
    "  [https://www.toronto.ca/cycling](https://www.toronto.ca/services-payments/streets-parking-transportation/cycling-in-toronto/)\n",
    "- **Toronto Metropolitan University - School of Urban & Regional Planning / City Building** \u2014 ",
    "  Research on urban mobility, transit, and city planning. ",
    "  [https://www.torontomu.ca/city-building](https://www.torontomu.ca/city-building/)\n"
  )
}
