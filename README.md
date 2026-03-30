# 🚲 Toronto Bike Share Analytics

Updated: 2026-03-30 13:34 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,857 | -206 |
| **Total docks available** | 13,176 | +308 |
| **System utilization rate** | 30.8% | -1.3% |
| **Active stations** | 1026/1026 (100%) | +4 |
| **Average bikes per station** | 5.7 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 300 (29.2%) | +32 |
| **Full stations** | 44 (4.3%) | +6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 74 | 79 |
| Bay St / Albert St | 63 | 63 |
| King St E / Church St | 55 | 55 |
| Bay St / Dundas St W | 55 | 55 |
| Queens Quay E / Lower Jarvis St  | 48 | 49 |
| Bremner Blvd / Rees St | 47 | 49 |
| York St / Queens Quay W | 47 | 57 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Queens Quay / Yonge St | 44 | 47 |
| Humber Bay Shores Park / Marine Parade Dr | 44 | 63 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 54 | 87 |
| Dundas St W / Crawford St | 43 | 47 |
| Niagara St / Richmond St W | 40 | 42 |
| 265 Armadale Ave | 39 | 45 |
| Jarvis St / Isabella St | 38 | 39 |
| 365 Lippincott St | 38 | 41 |
| 3220 Bloor St W | 37 | 38 |
| 9 Willingdon Blvd | 37 | 39 |
| Spadina Ave / Harbord St - SMART | 35 | 36 |
| Lisgar Park | 35 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 300 |
| Full       | 44 |
| Available  | 682 |

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
- The mean availability is 27.2% with a standard deviation of 32.7%
- The system is currently operating at 31% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +34% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +23% | Concert | General prediction |
| St. George St / Bloor St W | +14% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-04-01 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-04-04 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-04-06 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-03-30 17:36 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

