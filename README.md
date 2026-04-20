# 🚲 Toronto Bike Share Analytics

Updated: 2026-04-20 13:39 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,805 | +247 |
| **Total docks available** | 12,429 | -346 |
| **System utilization rate** | 35.4% | +1.5% |
| **Active stations** | 1031/1031 (100%) |  |
| **Average bikes per station** | 6.6 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 185 (17.9%) | +11 |
| **Full stations** | 33 (3.2%) | +6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 73 | 87 |
| Humber Bay Shores Park / Marine Parade Dr | 52 | 63 |
| 2700 Eglinton Ave W | 41 | 43 |
| St. George St / Willcocks St | 35 | 35 |
| Bay St / Albert St | 34 | 63 |
| King St W / University Ave | 34 | 39 |
| 265 Armadale Ave | 33 | 45 |
| Temperance St Station | 32 | 55 |
| Wellington St W / Bay St | 32 | 55 |
| Huron St / Harbord St | 32 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 66 | 79 |
| 439 Sherbourne St | 47 | 47 |
| Bay St / Dundas St W | 41 | 55 |
| 800 Fleet St (North) | 40 | 43 |
| 100 Grangeway Ave  | 38 | 39 |
| Niagara St / Richmond St W | 37 | 42 |
| York St / Queens Quay W | 37 | 57 |
| Dundas St W / Crawford St | 36 | 47 |
| Frederick St / King St E | 36 | 47 |
| Bathurst St / Dundas St W | 35 | 41 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 185 |
| Full       | 32 |
| Available  | 814 |

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
- The mean availability is 32.2% with a standard deviation of 31.2%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +27% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +22% | Concert | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-04-22 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-04-25 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-04-27 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-04-20 17:40 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

