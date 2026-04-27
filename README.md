# 🚲 Toronto Bike Share Analytics

Updated: 2026-04-27 13:46 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,493 | -312 |
| **Total docks available** | 12,471 | +42 |
| **System utilization rate** | 34.2% | -1.1% |
| **Active stations** | 1031/1031 (100%) |  |
| **Average bikes per station** | 6.3 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 194 (18.8%) | +9 |
| **Full stations** | 32 (3.1%) | -1 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 73 | 87 |
| York St / Queens Quay W | 55 | 57 |
| Temperance St Station | 53 | 55 |
| King St E / Church St | 53 | 55 |
| Bay St / Dundas St W | 49 | 55 |
| 265 Armadale Ave | 44 | 45 |
| Queens Quay E / Lower Jarvis St  | 43 | 47 |
| Humber Bay Shores Park / Marine Parade Dr | 35 | 63 |
| Bond St / Queen St E | 34 | 37 |
| Front St W / Yonge St (Hockey Hall of Fame) | 34 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 60 | 79 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Wellington St W / Bay St | 44 | 55 |
| Jarvis St / Isabella St | 39 | 39 |
| Bathurst St / Dundas St W | 39 | 41 |
| Dundas St W / Crawford St | 39 | 47 |
| Cherry Beach | 36 | 49 |
| Yonge St / Orchard View Blvd | 35 | 35 |
| Bay St / Albert St | 34 | 63 |
| Dundonald St / Church St | 34 | 38 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 194 |
| Full       | 31 |
| Available  | 806 |

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
- The mean availability is 30.5% with a standard deviation of 30.8%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +31% | Concert | General prediction |
| Wellesley Station Green P | +24% | Concert | General prediction |
| St. George St / Bloor St W | +12% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-04-29 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-05-02 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-05-04 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-04-27 17:47 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

