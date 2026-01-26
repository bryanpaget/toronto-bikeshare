# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-26 12:18 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,305 | +271 |
| **Total docks available** | 12,034 | -212 |
| **System utilization rate** | 34.4% | +1.4% |
| **Active stations** | 1007/1007 (100%) | +1 |
| **Average bikes per station** | 6.3 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 188 (18.7%) | -33 |
| **Full stations** | 53 (5.3%) | +9 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 65 | 79 |
| York St / Queens Quay W | 53 | 57 |
| Wellington St W / Bay St | 48 | 55 |
| Bay St / Albert St | 46 | 63 |
| Bremner Blvd / Rees St | 45 | 49 |
| Queens Quay / Yonge St | 45 | 47 |
| Frederick St / King St E | 45 | 47 |
| Bay St / Dundas St W | 45 | 55 |
| Mill St / Cherry St | 38 | 39 |
| 285 Victoria St | 38 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 52 | 63 |
| 144 Harrison St | 44 | 51 |
| 2700 Eglinton Ave W | 42 | 43 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| 800 Fleet St (South) | 41 | 43 |
| Queen St W / Ossington Ave | 40 | 43 |
| 365 Lippincott St | 39 | 41 |
| 1 Shortt St | 39 | 39 |
| Dundas St W / Crawford St | 38 | 47 |
| 91 Via Italia | 38 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 188 |
| Full       | 52 |
| Available  | 767 |

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
- The mean availability is 31.5% with a standard deviation of 31.9%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +31% | Concert | General prediction |
| Wellesley Station Green P | +26% | Concert | General prediction |
| St. George St / Bloor St W | +19% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-01-28 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-01-31 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-02-02 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-01-26 17:21 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

