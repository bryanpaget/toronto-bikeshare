# 🚲 Toronto Bike Share Analytics

Updated: 2026-04-13 13:40 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,558 | +109 |
| **Total docks available** | 12,775 | -10 |
| **System utilization rate** | 33.9% | +0.4% |
| **Active stations** | 1031/1031 (100%) |  |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 174 (16.9%) | -18 |
| **Full stations** | 27 (2.6%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 73 | 87 |
| York St / Queens Quay W | 50 | 57 |
| Humber Bay Shores Park / Marine Parade Dr | 50 | 63 |
| Wellington St W / Bay St | 42 | 55 |
| 265 Armadale Ave | 41 | 45 |
| Bay St / Dundas St W | 38 | 55 |
| 144 Harrison St | 36 | 51 |
| King St W / University Ave | 36 | 39 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |
| King St E / Church St | 33 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 52 | 79 |
| 100 Grangeway Ave  | 39 | 39 |
| Mill St / Cherry St | 38 | 39 |
| Jarvis St / Isabella St | 37 | 38 |
| Cherry Beach | 36 | 49 |
| Bathurst St / Dundas St W | 35 | 41 |
| Spadina Ave / Harbord St - SMART | 35 | 36 |
| Bay St / Albert St | 33 | 63 |
| Temperance St Station | 32 | 55 |
| Yonge St / Orchard View Blvd | 32 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 174 |
| Full       | 26 |
| Available  | 831 |

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
- The mean availability is 30.6% with a standard deviation of 29.5%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Wellesley Station Green P | +25% | Concert | General prediction |
| Fort York Blvd / Capreol Ct | +20% | Concert | General prediction |
| St. George St / Bloor St W | +18% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-04-15 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-04-18 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-04-20 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-04-13 17:41 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

