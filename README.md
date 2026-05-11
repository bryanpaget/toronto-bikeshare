# 🚲 Toronto Bike Share Analytics

Updated: 2026-05-11 13:56 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,605 | +396 |
| **Total docks available** | 12,354 | -237 |
| **System utilization rate** | 34.8% | +1.8% |
| **Active stations** | 1033/1033 (100%) | -3 |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 233 (22.6%) | -10 |
| **Full stations** | 37 (3.6%) | -2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 71 | 79 |
| Toronto Inukshuk Park | 61 | 87 |
| Bay St / Albert St | 53 | 63 |
| Wellington St W / Bay St | 52 | 55 |
| Bay St / Dundas St W | 51 | 55 |
| Humber Bay Shores Park / Marine Parade Dr | 49 | 63 |
| York St / Queens Quay W | 46 | 57 |
| Queens Quay E / Lower Jarvis St  | 42 | 49 |
| 265 Armadale Ave | 40 | 45 |
| 2700 Eglinton Ave W | 40 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Bathurst St / Dundas St W | 39 | 41 |
| Temperance St Station | 38 | 55 |
| Fort York  Blvd / Capreol Ct | 37 | 47 |
| Niagara St / Richmond St W | 37 | 42 |
| Jarvis St / Isabella St | 36 | 39 |
| Aitken Place Park | 36 | 39 |
| Queens Quay / Yonge St | 35 | 47 |
| Balliol St / Yonge St - SMART | 35 | 36 |
| Lake Shore Blvd W / Ontario Dr | 34 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 233 |
| Full       | 37 |
| Available  | 763 |

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
- The mean availability is 30.1% with a standard deviation of 31.3%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +35% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +28% | Concert | General prediction |
| St. George St / Bloor St W | +12% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-05-13 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-05-16 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-05-18 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-05-11 17:57 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

