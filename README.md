# 🚲 Toronto Bike Share Analytics

Updated: 2026-03-09 13:32 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,752 | -378 |
| **Total docks available** | 12,815 | +429 |
| **System utilization rate** | 31% | -2.1% |
| **Active stations** | 1015/1015 (100%) | +2 |
| **Average bikes per station** | 5.7 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 300 (29.6%) | +131 |
| **Full stations** | 44 (4.3%) | +10 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 71 | 79 |
| Bay St / Albert St | 61 | 63 |
| Wellington St W / Bay St | 53 | 55 |
| York St / Queens Quay W | 51 | 57 |
| Temperance St Station | 45 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 45 | 47 |
| Queens Quay / Yonge St | 45 | 47 |
| Bremner Blvd / Rees St | 44 | 49 |
| Bay St / Dundas St W | 39 | 55 |
| 285 Victoria St | 37 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 144 Harrison St | 49 | 51 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Dundas St W / Crawford St | 43 | 47 |
| 800 Fleet St (North) | 43 | 43 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| 265 Armadale Ave | 42 | 44 |
| 800 Fleet St (South) | 41 | 43 |
| Niagara St / Richmond St W | 40 | 42 |
| 2700 Eglinton Ave W | 40 | 43 |
| 365 Lippincott St | 40 | 41 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 300 |
| Full       | 44 |
| Available  | 671 |

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
- The mean availability is 27.6% with a standard deviation of 32.1%
- The system is currently operating at 31% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +31% | Concert | General prediction |
| Wellesley Station Green P | +23% | Concert | General prediction |
| St. George St / Bloor St W | +16% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-03-11 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-03-14 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-03-16 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-03-09 17:34 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

