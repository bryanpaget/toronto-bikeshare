# 🚲 Toronto Bike Share Analytics

Updated: 2026-04-06 13:32 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,449 | +592 |
| **Total docks available** | 12,785 | -391 |
| **System utilization rate** | 33.5% | +2.8% |
| **Active stations** | 1031/1031 (100%) | +5 |
| **Average bikes per station** | 6.3 | +1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 192 (18.6%) | -108 |
| **Full stations** | 31 (3%) | -13 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 53 | 87 |
| Simcoe St / Pullan Pl | 52 | 79 |
| 144 Harrison St | 43 | 51 |
| Queens Quay E / Lower Jarvis St  | 43 | 49 |
| 800 Fleet St (South) | 41 | 43 |
| Wellington St W / Bay St | 37 | 55 |
| York St / Queens Quay W | 35 | 57 |
| King St E / Church St | 33 | 55 |
| Bay St / Queens Quay W (Ferry Terminal) | 32 | 35 |
| St. George St / Willcocks St | 32 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Fort York  Blvd / Capreol Ct | 40 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 40 | 47 |
| 439 Sherbourne St | 40 | 47 |
| 100 Grangeway Ave  | 39 | 39 |
| 9 Willingdon Blvd | 38 | 39 |
| Jarvis St / Isabella St | 37 | 38 |
| Bay St / Albert St | 35 | 63 |
| Bremner Blvd / Rees St | 34 | 49 |
| Spadina Ave / Sussex Ave  | 34 | 34 |
| Toronto Inukshuk Park | 33 | 87 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 192 |
| Full       | 30 |
| Available  | 809 |

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
- The mean availability is 30.6% with a standard deviation of 29.9%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +23% | Concert | General prediction |
| Wellesley Station Green P | +22% | Concert | General prediction |
| St. George St / Bloor St W | +14% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-04-08 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-04-11 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-04-13 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-04-06 17:34 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

