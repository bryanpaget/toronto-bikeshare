# 🚲 Toronto Bike Share Analytics

Updated: 2026-05-18 13:58 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,712 | -893 |
| **Total docks available** | 13,164 | +810 |
| **System utilization rate** | 30.3% | -4.6% |
| **Active stations** | 1033/1033 (100%) |  |
| **Average bikes per station** | 5.5 | -1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 259 (25.1%) | +26 |
| **Full stations** | 20 (1.9%) | -17 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 81 | 87 |
| King St E / Church St | 51 | 55 |
| Humber Bay Shores Park / Marine Parade Dr | 47 | 63 |
| Queens Quay E / Lower Jarvis St  | 45 | 48 |
| Hanlan's Point Beach | 45 | 47 |
| Queens Quay / Yonge St | 43 | 47 |
| Niagara St / Richmond St W | 41 | 42 |
| Cherry Beach | 41 | 49 |
| Queen St W / Ossington Ave | 40 | 43 |
| Bay St / Dundas St W | 40 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 76 | 79 |
| Temperance St Station | 51 | 55 |
| Bay St / Albert St | 49 | 63 |
| Bremner Blvd / Rees St | 48 | 49 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Kewbeach Ave / Kenilworth Ave | 39 | 61 |
| Hanlan's Point Ferry Dock | 38 | 39 |
| Jarvis St / Isabella St | 37 | 39 |
| 1 Shortt St | 37 | 39 |
| 100 Grangeway Ave  | 37 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 259 |
| Full       | 20 |
| Available  | 754 |

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
- The mean availability is 26.3% with a standard deviation of 28.8%
- The system is currently operating at 30% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +25% | Concert | General prediction |
| Wellesley Station Green P | +25% | Concert | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-05-20 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-05-23 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-05-25 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-05-18 18:00 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

