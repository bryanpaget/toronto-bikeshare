# 🚲 Toronto Bike Share Analytics

Updated: 2026-08-17 13:21 (Toronto Time)

## 🖥️ Live Dashboard
View the interactive dashboard with the full history of bike availability: [https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,747 | -351 |
| **Total docks available** | 12,962 | +438 |
| **System utilization rate** | 34.2% | -1.9% |
| **Active stations** | 1058/1058 (100%) | +1 |
| **Average bikes per station** | 6.4 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 285 (26.9%) | +17 |
| **Full stations** | 49 (4.6%) | -2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 74 | 87 |
| Temperance St Station | 55 | 55 |
| Kewbeach Ave / Kenilworth Ave | 55 | 61 |
| Simcoe St / Pullan Pl | 55 | 79 |
| King St E / Church St | 53 | 55 |
| York St / Queens Quay W | 52 | 57 |
| Wellington St W / Bay St | 49 | 55 |
| Queens Quay E / Lower Jarvis St  | 46 | 47 |
| Bremner Blvd / Rees St | 45 | 48 |
| Queens Quay / Yonge St | 45 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Dundas St W / Crawford St | 43 | 47 |
| Niagara St / Richmond St W | 38 | 42 |
| Jarvis St / Isabella St | 37 | 39 |
| 439 Sherbourne St | 37 | 47 |
| Mill St / Tannery Rd | 36 | 39 |
| Huron St / Harbord St | 35 | 39 |
| Mill St / Cherry St | 35 | 39 |
| Bathurst St / Dundas St W | 34 | 41 |
| Balliol St / Yonge St - SMART | 34 | 36 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 285 |
| Full       | 49 |
| Available  | 724 |

## 📍 Bike Locations
![Bike Locations](docs/plots/location_plot.png)

## 📈 Bike Availability Distribution
![Availability Distribution](docs/plots/availability_dist.png)

## 📈 Historical Trends
### Bike and Dock Availability
![Bike and Dock Trend](docs/plots/time_series/bike_dock_trend.png)

### System Utilization Rate
![Utilization Trend](docs/plots/time_series/utilization_trend.png)

## 📊 Sampling Methodology
The data is collected from the Toronto Bike Share GBFS API at a single point in time. This provides a snapshot of the system but may not capture temporal variations.

### Key Metrics Explained
1. **Utilization Rate**: The proportion of total bike slots that are occupied by bikes:
   $$\text{Utilization Rate} = \frac{\text{Total Bikes}}{\text{Total Bikes} + \text{Total Docks}} \times 100\%$$

2. **Station Status Classification**:
   - **Empty**: $\text{bikes} = 0$
   - **Full**: $\text{docks} = 0$
   - **Available**: $\text{bikes} > 0$ and $\text{docks} > 0$

### Statistical Notes
- The distribution of bikes across stations follows a right-skewed distribution
- The mean availability is 29.2% with a standard deviation of 33.1%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 🚴 About Bike Share Toronto
Bike Share Toronto is the city's public bike share system, owned and operated by the Toronto Parking Authority. It launched in May 2011 as Bixi Toronto with about 1,000 bikes and 80 stations, and was rebranded as Bike Share Toronto when the Toronto Parking Authority took over operations in 2014. Today it has grown to more than 1,000 stations and 10,000+ bikes (including roughly 2,100 electric bikes) across the city.

The system has expanded rapidly alongside the city's cycling network. Annual ridership grew from about 2.9 million trips in 2020 to 5.7 million in 2023, 7.0 million in 2024, and a record 7.8 million trips in 2025 — with continued growth expected in 2026 as more e-bikes, charging docks, and stations are added.

The city's 2030 Growth Strategy (Ride More, Connect More) lays out a roadmap for roughly doubling the network, integrating bike share more closely with transit, and expanding into underserved neighbourhoods. Equity programs such as the Reduced Fare Pass make the system more affordable, and expansion priorities are informed by research on how to make bike share reach more residents in lower-income areas.

- Official site: [bikesharetoronto.com](https://bikesharetoronto.com/)
- Overview & history: [Wikipedia - Bike Share Toronto](https://en.wikipedia.org/wiki/Bike_Share_Toronto)
- City of Toronto: [Toronto Parking Authority - 2030 Growth Strategy (PDF)](https://www.toronto.ca/legdocs/mmis/2025/pa/bgrd/backgroundfile-260875.pdf)

## 🚲 Bike Share Across Canada and the World
Toronto is part of a growing network of public bike share systems. Montreal's BIXI (2009) was the first modern public bike share in North America, and other major Canadian systems include Vancouver's Mobi by Shaw Go (2016) and Hamilton's bike share (2015). Internationally, the well-known systems include Paris' Vélib', London's Santander Cycles, New York's Citi Bike, and Washington D.C.'s Capital Bikeshare. Hundreds of cities worldwide now operate docked or dockless bike share programs as part of their urban mobility toolkit.

## 🌍 Why Bike Share Matters for Cities
Bike share systems deliver a broad set of benefits for cities and their residents:
1. **First- and last-mile connections**: Bike share fills the gap between transit stops (GO, TTC,    and regional rail) and people's homes, workplaces, and errands, extending the reach of public    transit without large capital investment.
2. **Less congestion**: Short car trips can be replaced by bikes, easing road congestion. Research    on Washington D.C.'s Capital Bikeshare estimated it reduced neighbourhood-level traffic    congestion by up to 4% (Hamilton & Wichman, 2018).
3. **Health benefits**: Bike share encourages everyday physical activity. A study of European    bike share systems estimated that, if all bike share trips replaced car trips, up to 73    deaths could be prevented each year across those cities — and benefits outweigh risks in    every scenario considered (Otero, Nieuwenhuijsen & Rojas-Rueda, 2018).
4. **Lower emissions**: Replacing car trips reduces greenhouse gas emissions and local air    pollution, supporting municipal climate and Vision Zero goals.
5. **Equitable, affordable mobility**: At low cost, bike share provides flexible mobility to    residents who may not own a bike or a car, and targeted pricing and station placement can    address transportation inequity in lower-income neighbourhoods (see TMU research below).
6. **Efficient use of public space**: A single bike lane or docked station moves many more    people per hour than the equivalent car parking, making better use of valuable street space.

## 📚 Research & Further Reading
- **Health impacts of bike share** — Otero, I., Nieuwenhuijsen, M.J. & Rojas-Rueda, D. (2018).   *Health impacts of bike sharing systems in Europe*. Environment International, 115, 387-394.   [https://doi.org/10.1016/j.envint.2018.04.014](https://doi.org/10.1016/j.envint.2018.04.014)
- **Congestion reduction** — Hamilton, T.L. & Wichman, C.J. (2018). *Bicycle infrastructure and   traffic congestion: Evidence from DC's Capital Bikeshare*. Journal of Environmental Economics   and Management, 87, 72-93. [https://doi.org/10.1016/j.jeem.2017.03.007](https://doi.org/10.1016/j.jeem.2017.03.007)
- **Review of the bike share literature** — Fishman, E., Washington, S. & Haworth, N. (2013).   *Bike Share: A Synthesis of the Literature*. Transport Reviews, 33(2), 148-165.   [https://doi.org/10.1080/01441647.2013.775612](https://doi.org/10.1080/01441647.2013.775612)
- **Equity in Toronto's bike share** — Mekonnen, S. (2022). *A Plan for an Equitable Expansion of   Bike Share Toronto* (Toronto Metropolitan University).   [https://doi.org/10.32920/17329601](https://doi.org/10.32920/17329601)

## 🤝 Canadian Cycling & Urban Associations
- **Vélo Canada Bikes** — Canada's national cycling advocacy organization.   [https://velocanadabikes.org](https://velocanadabikes.org/)
- **Cycle Toronto** — Toronto's member-supported cycling advocacy charity, promotes safe cycling   across the city. [https://www.cycleto.ca](https://www.cycleto.ca/)
- **Share the Road Cycling Coalition** — Ontario-wide coalition working with municipalities on   cycling infrastructure and policy. [https://sharetheroad.ca](https://sharetheroad.ca/)
- **Transportation Association of Canada (TAC)** — National association producing guides and   standards for sustainable transportation and active mobility.   [https://www.tac-atc.ca](https://www.tac-atc.ca/en)
- **City of Toronto - Cycling** — City cycling network, maps, and programs.   [https://www.toronto.ca/cycling](https://www.toronto.ca/services-payments/streets-parking-transportation/cycling-in-toronto/)
- **Toronto Metropolitan University - School of Urban & Regional Planning / City Building** —   Research on urban mobility, transit, and city planning.   [https://www.torontomu.ca/city-building](https://www.torontomu.ca/city-building/)


## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Simcoe St / Pullan Pl | +30% | Concert | This breathtaking beach 2.5 hrs from Toronto has powdery white sand shores with Bahamas vibes |
| Humber Bay Shores Park / Marine Parade Dr | +28% | Sports Event | General prediction |
| Kewbeach Ave / Kenilworth Ave | +22% | Concert | General prediction |
| Bay St / Albert St | +20% | Concert | This breathtaking beach 2.5 hrs from Toronto has powdery white sand shores with Bahamas vibes |
| Toronto Inukshuk Park | +15% | Food Festival | This breathtaking beach 2.5 hrs from Toronto has powdery white sand shores with Bahamas vibes |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [This breathtaking beach 2.5 hrs from Toronto has powdery white sand shores with Bahamas vibes](https://www.narcity.com/toronto/sandbanks-provincial-park-road-trip-from-toronto-prince-edward-county-beaches) | 2026-08-17 | If a trip to the tropics isn't in the cards for... | Increase bikes nearby |
| [Major Toronto festival ending after 2026 amid swath of other cancellations](https://www.blogto.com/radar/2026/08/toronto-festival-ending-2026/) | 2026-08-18 | Yet another major Toronto festival is entering ... | Increase bikes nearby |
| [Win 2 general admission full festival passes to Rock The Runway in Ontario](https://www.blogto.com/music/2026/08/rock-the-runway-betty-giveaway/) | 2026-08-18 | Outdoor concerts hit different, especially in L... | Increase bikes nearby |
| [The best‑kept secret for saving money at Toronto Blue Jays games](https://www.blogto.com/sports_play/2026/08/secret-for-saving-money-toronto-blue-jays/) | 2026-08-18 | With the Toronto Blue Jays' season winding down... | Increase bikes nearby |
| [Mysterious $60M superyacht docks in Toronto and nobody knows who owns it](https://www.blogto.com/city/2026/08/superyacht-docks-toronto/) | 2026-08-18 | A lavish superyacht is turning heads on the Tor... | Increase bikes nearby |
| [Toronto Blue Jays are in the thick of MLB playoff race](https://www.blogto.com/sports_play/2026/08/toronto-blue-jays-thick-mlb-playoff-race/) | 2026-08-17 | The Toronto Blue Jays have bought themselves so... | Increase bikes nearby |

*Last updated: 2026-08-17 17:21 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: This breathtaking beach 2.5 hrs from Toronto has powdery white sand shores with Bahamas vibes, Major Toronto festival ending after 2026 amid swath of other cancellations, Win 2 general admission full festival passes to Rock The Runway in Ontario.... Stations near events receive adjusted predictions.*

