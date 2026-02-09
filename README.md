# 🚲 Toronto Bike Share Analytics

Updated: 2026-02-09 12:34 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,171 | -60 |
| **Total docks available** | 12,120 | +73 |
| **System utilization rate** | 33.7% | -0.4% |
| **Active stations** | 1009/1009 (100%) | +2 |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 193 (19.1%) | -20 |
| **Full stations** | 40 (4%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 68 | 79 |
| Bay St / Albert St | 55 | 63 |
| Bay St / Dundas St W | 54 | 54 |
| Queens Quay / Yonge St | 47 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| Bremner Blvd / Rees St | 40 | 49 |
| Mill St / Cherry St | 36 | 39 |
| Frederick St / King St E | 36 | 47 |
| King St W / University Ave | 36 | 39 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 56 | 63 |
| 439 Sherbourne St | 43 | 47 |
| 144 Harrison St | 42 | 51 |
| 800 Fleet St (South) | 42 | 43 |
| 2700 Eglinton Ave W | 42 | 43 |
| 800 Fleet St (North) | 42 | 43 |
| 1 Shortt St | 39 | 39 |
| Niagara St / Richmond St W | 38 | 42 |
| 365 Lippincott St | 38 | 41 |
| 9 Willingdon Blvd | 38 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 193 |
| Full       | 40 |
| Available  | 776 |

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
- The mean availability is 30.5% with a standard deviation of 31.1%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +25% | Concert | General prediction |
| Wellesley Station Green P | +23% | Concert | General prediction |
| St. George St / Bloor St W | +16% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-02-11 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-02-14 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-02-16 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-02-09 17:35 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

