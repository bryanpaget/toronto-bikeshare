# 🚲 Toronto Bike Share Analytics

Updated: 2026-03-23 13:35 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,063 | +311 |
| **Total docks available** | 12,868 | +53 |
| **System utilization rate** | 32% | +1.0% |
| **Active stations** | 1022/1022 (100%) | +7 |
| **Average bikes per station** | 5.9 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 268 (26.2%) | -32 |
| **Full stations** | 38 (3.7%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| King St E / Church St | 49 | 55 |
| Simcoe St / Pullan Pl | 49 | 79 |
| Bay St / Albert St | 48 | 63 |
| Bay St / Dundas St W | 48 | 55 |
| Frederick St / King St E | 42 | 47 |
| Queen St W / Ossington Ave | 39 | 43 |
| Cherry Beach | 39 | 49 |
| 800 Fleet St (South) | 38 | 43 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| Toronto Inukshuk Park | 34 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 144 Harrison St | 49 | 51 |
| Dundas St W / Crawford St | 40 | 47 |
| 9 Willingdon Blvd | 39 | 39 |
| Jarvis St / Isabella St | 38 | 39 |
| 91 Via Italia | 38 | 39 |
| Humber Bay Shores Park / Marine Parade Dr | 38 | 63 |
| 365 Lippincott St | 38 | 41 |
| 1 Shortt St | 38 | 39 |
| 3220 Bloor St W | 37 | 38 |
| Niagara St / Richmond St W | 36 | 42 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 268 |
| Full       | 38 |
| Available  | 716 |

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
- The mean availability is 29% with a standard deviation of 32.1%
- The system is currently operating at 32% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +35% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +27% | Concert | General prediction |
| St. George St / Bloor St W | +19% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-03-25 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-03-28 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-03-30 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-03-23 17:36 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

