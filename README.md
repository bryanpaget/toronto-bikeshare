# 🚲 Toronto Bike Share Analytics

Updated: 2026-02-02 12:26 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,231 | -74 |
| **Total docks available** | 12,047 | +13 |
| **System utilization rate** | 34.1% | -0.3% |
| **Active stations** | 1007/1007 (100%) |  |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 213 (21.2%) | +25 |
| **Full stations** | 46 (4.6%) | -7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 69 | 79 |
| Bay St / Albert St | 56 | 63 |
| York St / Queens Quay W | 53 | 57 |
| Bay St / Dundas St W | 51 | 54 |
| Temperance St Station | 50 | 55 |
| Queens Quay / Yonge St | 47 | 47 |
| Frederick St / King St E | 45 | 47 |
| Bremner Blvd / Rees St | 43 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| 285 Victoria St | 39 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| 144 Harrison St | 45 | 51 |
| 800 Fleet St (North) | 43 | 43 |
| 2700 Eglinton Ave W | 42 | 43 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Queen St W / Ossington Ave | 41 | 43 |
| 800 Fleet St (South) | 41 | 43 |
| 365 Lippincott St | 39 | 41 |
| 1 Shortt St | 39 | 39 |
| 91 Via Italia | 38 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 213 |
| Full       | 46 |
| Available  | 748 |

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
- The mean availability is 30.8% with a standard deviation of 32.2%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +33% | Concert | General prediction |
| Wellesley Station Green P | +27% | Concert | General prediction |
| St. George St / Bloor St W | +20% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-02-04 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-02-07 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-02-09 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-02-02 17:28 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

