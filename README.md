# 🚲 Toronto Bike Share Analytics

Updated: 2026-08-05 15:40 (Toronto Time)

## 🖥️ Live Dashboard
View the interactive dashboard with the full history of bike availability: [https://bryanpaget.github.io/toronto-bikeshare/](https://bryanpaget.github.io/toronto-bikeshare/)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,790 | +329 |
| **Total docks available** | 12,863 | +344 |
| **System utilization rate** | 34.5% | +0.5% |
| **Active stations** | 1056/1056 (100%) | +27 |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 237 (22.4%) | -9 |
| **Full stations** | 29 (2.7%) | -2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Kewbeach Ave / Kenilworth Ave | 61 | 61 |
| Humber Bay Shores Park / Marine Parade Dr | 58 | 63 |
| York St / Queens Quay W | 54 | 57 |
| Temperance St Station | 51 | 55 |
| King St E / Church St | 51 | 55 |
| Simcoe St / Pullan Pl | 48 | 79 |
| Queens Quay / Yonge St | 44 | 47 |
| Frederick St / King St E | 44 | 47 |
| Union Station | 42 | 43 |
| Front St W / Yonge St (Hockey Hall of Fame) | 42 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 82 | 87 |
| Cherry Beach | 48 | 49 |
| Bathurst St / Dundas St W | 40 | 41 |
| Fort York  Blvd / Capreol Ct | 37 | 47 |
| Bloor St W / Manning Ave - SMART | 37 | 42 |
| 439 Sherbourne St | 35 | 47 |
| Lake Shore Blvd W / Ontario Dr | 34 | 35 |
| Northern Dancer Blvd / Lake Shore Blvd E | 34 | 41 |
| Lisgar Park | 34 | 35 |
| Spadina Ave / Harbord St - SMART | 33 | 36 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 237 |
| Full       | 29 |
| Available  | 790 |

## 📍 Bike Locations
![Bike Locations](docs/plots/location_plot.png)

## 📊 Station Status Distribution
![Status Distribution](docs/plots/status_distribution.png)

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
- The mean availability is 29.2% with a standard deviation of 31.1%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Simcoe St / Pullan Pl | +30% | Concert | How to find a good hotel deal in Toronto using Skyscanner |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [How to find a good hotel deal in Toronto using Skyscanner](https://viewthevibe.com/how-to-find-a-good-hotel-deal-in-toronto-using-skyscanner/) | 2026-08-06 | <p>Booking a hotel in Toronto isn’t difficult i... | Monitor usage |
| [Yes, another Toronto festival. But this one actually gets what people want.](https://viewthevibe.com/yes-another-toronto-festival-but-this-one-actually-gets-what-people-want/) | 2026-08-06 | <p>Discover the unique experience at the On the... | Increase bikes nearby |

*Last updated: 2026-08-05 15:42 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: How to find a good hotel deal in Toronto using Skyscanner, Yes, another Toronto festival. But this one actually gets what people want.. Stations near events receive adjusted predictions.*

