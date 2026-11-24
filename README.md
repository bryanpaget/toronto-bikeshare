# 🚲 Toronto Bike Share Analytics

Updated: 2026-11-23 22:08 (Toronto Time)

## 🖥️ Live Dashboard
View the interactive dashboard with the full history of bike availability: [https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 8,040 | +138 |
| **Total docks available** | 11,547 | -231 |
| **System utilization rate** | 41% | +0.9% |
| **Active stations** | 1074/1074 (100%) | +6 |
| **Average bikes per station** | 7.5 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 164 (15.3%) | +30 |
| **Full stations** | 59 (5.5%) | +7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Kewbeach Ave / Kenilworth Ave | 60 | 60 |
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| Atlantic Ave / Liberty St | 50 | 59 |
| Toronto Inukshuk Park | 48 | 87 |
| Woodbine Ave / Lake Shore Blvd E | 42 | 43 |
| 144 Harrison St | 41 | 50 |
| Queen St E / Woodward Ave | 41 | 43 |
| Alton Ave / Dundas St E (Greenwood Park) | 41 | 42 |
| Niagara St / Richmond St W | 40 | 42 |
| Northern Dancer Blvd / Lake Shore Blvd E | 40 | 41 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 69 | 79 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Bathurst St / Dundas St W | 39 | 41 |
| Wellington St W / Bay St | 39 | 55 |
| Toronto Inukshuk Park | 38 | 87 |
| Bremner Blvd / Rees St | 36 | 49 |
| Cherry Beach | 35 | 49 |
| 439 Sherbourne St | 35 | 47 |
| Huron St / Harbord St | 34 | 39 |
| Spadina Ave / Harbord St - SMART | 34 | 36 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 164 |
| Full       | 59 |
| Available  | 851 |

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
- The mean availability is 36% with a standard deviation of 32.2%
- The system is currently operating at 41% capacity

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
| Humber Bay Shores Park / Marine Parade Dr | +28% | Sports Event | General prediction |
| Toronto Inukshuk Park | +25% | Concert | Olivia Chow uses strong mayor powers to replace Toronto's city manager |
| Kewbeach Ave / Kenilworth Ave | +22% | Sports Event | General prediction |
| Simcoe St / Pullan Pl | +20% | Art/Cultural Event | Olivia Chow uses strong mayor powers to replace Toronto's city manager |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Burlington Lions Brighten Waterfront With Expanded Festival of Lights](https://www.narcity.com/toronto/burlington-lions-brighten-waterfront-with-expanded-festival-of-lights) | 2026-11-24 | The Burlington Lions Club will bring its Festiv... | Increase bikes nearby |
| [Olivia Chow uses strong mayor powers to replace Toronto's city manager](https://www.narcity.com/toronto/chow-uses-strong-mayor-powers-to-swap-city-manager) | 2026-11-24 | Toronto Mayor Olivia Chow is using her strong m... | Increase bikes nearby |
| [Police identify two teens killed in triple shooting at Toronto gas station](https://www.narcity.com/toronto/police-identify-teen-victims-of-toronto-shooting) | 2026-11-24 | Toronto police have identified two teenagers ki... | Monitor usage |
| [Here are all the classic Christmas movies perfect for a holiday marathon](https://viewthevibe.com/6-holiday-movies-to-binge-watch-on-netflix-this-christmas/) | 2026-11-24 | It’s time to get in the holiday spirit! Go get ... | Increase bikes nearby |
| [6 coaches the Maple Leafs could hire if Toronto makes a change](https://www.blogto.com/sports_play/2026/11/6-coaches-maple-leafs-could-hire-if-toronto-makes-change/) | 2026-11-24 | All is not well for the Toronto Maple Leafs, it... | Increase bikes nearby |
| [Former airplane hangar in Toronto transforms into free skating rink next month](https://www.blogto.com/radar/2026/11/hangar-skate-2026-toronto/) | 2026-11-24 | Toronto's YZD Hangar Skate returns next month f... | Increase bikes nearby |
| [North America's leading event for the built environment is taking place in Toronto](https://www.blogto.com/tech/2026/11/buildings-show-toronto/) | 2026-11-24 | The Buildings Show by Informa is taking place i... | Increase bikes nearby |
| [Toronto's oldest homes that are somehow still standing](https://www.blogto.com/real-estate-toronto/2026/11/torontos-oldest-homes-are-still-standing/) | 2026-11-24 | Toronto isn't exactly a city known for hanging ... | Increase bikes nearby |

*Last updated: 2026-11-24 03:10 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Burlington Lions Brighten Waterfront With Expanded Festival of Lights, Olivia Chow uses strong mayor powers to replace Toronto's city manager, Police identify two teens killed in triple shooting at Toronto gas station.... Stations near events receive adjusted predictions.*

