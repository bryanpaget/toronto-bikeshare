# 🚲 Toronto Bike Share Analytics

Updated: 2026-08-24 13:24 (Toronto Time)

## 🖥️ Live Dashboard
View the interactive dashboard with the full history of bike availability: [https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 7,304 | +206 |
| **Total docks available** | 12,592 | +68 |
| **System utilization rate** | 36.7% | +0.5% |
| **Active stations** | 1063/1063 (100%) | +6 |
| **Average bikes per station** | 6.9 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 214 (20.1%) | -54 |
| **Full stations** | 44 (4.1%) | -7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| King St E / Church St | 55 | 55 |
| York St / Queens Quay W | 53 | 57 |
| Toronto Inukshuk Park | 49 | 87 |
| Queens Quay E / Lower Jarvis St  | 47 | 47 |
| Bremner Blvd / Rees St | 43 | 48 |
| Queens Quay / Yonge St | 41 | 47 |
| 265 Armadale Ave | 41 | 45 |
| Northern Dancer Blvd / Lake Shore Blvd E | 40 | 41 |
| Front St W / Yonge St (Hockey Hall of Fame) | 39 | 47 |
| Union Station | 38 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 66 | 79 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Temperance St Station | 42 | 55 |
| Bay St / Dundas St W | 42 | 55 |
| Kewbeach Ave / Kenilworth Ave | 41 | 61 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Humber Bay Shores Park / Marine Parade Dr | 39 | 63 |
| Jarvis St / Isabella St | 38 | 39 |
| Bay St / Albert St | 36 | 63 |
| Bond St / Queen St E | 36 | 37 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 214 |
| Full       | 44 |
| Available  | 805 |

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
- The mean availability is 32.5% with a standard deviation of 32%
- The system is currently operating at 37% capacity

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
| Simcoe St / Pullan Pl | +30% | Sports Event | This riverside village 1.5 hrs from Toronto is dotted with storybook shops and charming cafes |
| Humber Bay Shores Park / Marine Parade Dr | +28% | Sports Event | General prediction |
| Toronto Inukshuk Park | +25% | Concert | This riverside village 1.5 hrs from Toronto is dotted with storybook shops and charming cafes |
| Bay St / Albert St | +20% | Sports Event | I moved to a dreamy small town in Ontario to escape city life — the reality was unexpected |
| Kewbeach Ave / Kenilworth Ave | +12% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [I moved to a dreamy small town in Ontario to escape city life — the reality was unexpected](https://www.narcity.com/toronto/dreamy-small-town-in-ontario-to-escape-city-life) | 2026-08-25 | For most of my life, I lived in Toronto , but I... | Increase bikes nearby |
| [This riverside village 1.5 hrs from Toronto is dotted with storybook shops and charming cafes](https://www.narcity.com/toronto/st-jacobs-village-small-town-near-toronto-things-to-do) | 2026-08-25 | You don't need to travel far from Toronto to fi... | Increase bikes nearby |
| [How much are people in Toronto willing to spend at the CNE?](https://www.blogto.com/city/2026/08/cne-2026-prices-toronto/) | 2026-08-25 | Crowds have flocked to the return of the Canadi... | Increase bikes nearby |
| [Grab a free coffee and discover how easy investing can be at this Toronto Investly event](https://www.blogto.com/sponsored/2026/08/investly-irl-event-toronto/) | 2026-08-25 | Toronto is about to get a free crash course in ... | Increase bikes nearby |
| [New laws and rules coming to Ontario next month](https://www.blogto.com/city/2026/08/new-laws-rules-ontario-september-2026/) | 2026-08-24 | Multiple new laws and rules are coming into eff... | Increase bikes nearby |
| [3 Toronto BBQ pop-ups you need to visit before the summer ends](https://www.blogto.com/eat_drink/2026/08/toronto-barbecue/) | 2026-08-24 | Toronto summers and steaming, saucy barbecue go... | Increase bikes nearby |
| [Massive kite festival set to take place in Ontario this coming weekend](https://www.blogto.com/radar/2026/08/hopeville-kite-festival-2026/) | 2026-08-24 | Ontario's largest kite festival, the Hopeville ... | Increase bikes nearby |

*Last updated: 2026-08-24 17:27 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: I moved to a dreamy small town in Ontario to escape city life — the reality was unexpected, This riverside village 1.5 hrs from Toronto is dotted with storybook shops and charming cafes, How much are people in Toronto willing to spend at the CNE?.... Stations near events receive adjusted predictions.*

