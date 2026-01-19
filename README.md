# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-19 12:19 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,034 | +55 |
| **Total docks available** | 12,246 | -253 |
| **System utilization rate** | 33% | +0.7% |
| **Active stations** | 1006/1006 (100%) |  |
| **Average bikes per station** | 6 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 221 (22%) | +6 |
| **Full stations** | 44 (4.4%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 61 | 63 |
| Temperance St Station | 52 | 55 |
| Wellington St W / Bay St | 51 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Bremner Blvd / Rees St | 43 | 49 |
| Simcoe St / Pullan Pl | 43 | 79 |
| Frederick St / King St E | 42 | 47 |
| Bay St / Dundas St W | 40 | 55 |
| York St / Queens Quay W | 39 | 57 |
| 285 Victoria St | 39 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 56 | 63 |
| 144 Harrison St | 44 | 51 |
| 800 Fleet St (North) | 43 | 43 |
| Queen St W / Ossington Ave | 42 | 43 |
| 439 Sherbourne St | 42 | 47 |
| 800 Fleet St (South) | 42 | 43 |
| 2700 Eglinton Ave W | 42 | 43 |
| 365 Lippincott St | 40 | 41 |
| Dundonald St / Church St | 39 | 39 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 221 |
| Full       | 42 |
| Available  | 743 |

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
- The mean availability is 30.2% with a standard deviation of 32.1%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +30% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +25% | Concert | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-01-21 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-01-24 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-01-26 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-01-19 17:20 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

