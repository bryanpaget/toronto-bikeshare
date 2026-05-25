# 🚲 Toronto Bike Share Analytics

Updated: 2026-05-25 13:49 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,461 | +749 |
| **Total docks available** | 12,519 | -645 |
| **System utilization rate** | 34% | +3.8% |
| **Active stations** | 1029/1029 (100%) | -4 |
| **Average bikes per station** | 6.3 | +1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 246 (23.9%) | -13 |
| **Full stations** | 31 (3%) | +11 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 58 | 63 |
| King St E / Church St | 53 | 55 |
| Bay St / Albert St | 51 | 63 |
| Bay St / Dundas St W | 49 | 55 |
| Queens Quay E / Lower Jarvis St  | 45 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| York St / Queens Quay W | 42 | 57 |
| Aitken Place Park | 39 | 39 |
| King St W / Bay St (West Side) | 37 | 39 |
| 144 Harrison St | 37 | 51 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 79 | 87 |
| Simcoe St / Pullan Pl | 46 | 79 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Dundas St W / Crawford St | 41 | 47 |
| Bathurst St / Dundas St W | 37 | 41 |
| Bloor St W / Manning Ave - SMART | 37 | 42 |
| Niagara St / Richmond St W | 36 | 42 |
| Balliol St / Yonge St - SMART | 36 | 36 |
| Spadina Ave / Harbord St - SMART | 34 | 36 |
| Lisgar Park | 34 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 246 |
| Full       | 31 |
| Available  | 752 |

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
- The mean availability is 29.3% with a standard deviation of 31.1%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +30% | Concert | General prediction |
| Wellesley Station Green P | +29% | Concert | General prediction |
| St. George St / Bloor St W | +18% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-05-27 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-05-30 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-06-01 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-05-25 17:50 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

