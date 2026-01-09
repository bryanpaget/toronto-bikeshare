# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-09 08:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,220 | -120 |
| **Total docks available** | 12,338 | +136 |
| **System utilization rate** | 33.5% | -0.7% |
| **Active stations** | 1007/1007 (100%) |  |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 113 (11.2%) | -4 |
| **Full stations** | 20 (2%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Queens Quay / Yonge St | 46 | 47 |
| Bremner Blvd / Rees St | 45 | 49 |
| Bay St / Dundas St W | 40 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 37 | 47 |
| Bay St / Albert St | 35 | 62 |
| Balliol St / Yonge St - SMART | 33 | 36 |
| Toronto Inukshuk Park | 33 | 47 |
| Frederick St / King St E | 32 | 47 |
| 285 Victoria St | 32 | 39 |
| Exhibition GO (Atlantic Ave) | 29 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 52 | 79 |
| Humber Bay Shores Park / Marine Parade Dr | 51 | 63 |
| 144 Harrison St | 48 | 51 |
| 800 Fleet St (North) | 42 | 43 |
| 800 Fleet St (South) | 41 | 43 |
| 2700 Eglinton Ave W | 40 | 43 |
| Niagara St / Richmond St W | 39 | 42 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |
| 91 Via Italia | 39 | 39 |
| 365 Lippincott St | 39 | 41 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 113 |
| Full       | 20 |
| Available  | 874 |

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
- The mean availability is 31.2% with a standard deviation of 27.6%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +35% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +29% | Concert | General prediction |
| St. George St / Bloor St W | +15% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-01-11 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-01-14 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-01-16 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-01-09 08:13 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

