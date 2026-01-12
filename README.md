# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-12 12:17 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,979 | -224 |
| **Total docks available** | 12,499 | +146 |
| **System utilization rate** | 32.4% | -1.1% |
| **Active stations** | 1006/1006 (100%) | -1 |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 17.5 | - |
| **Empty stations** | 215 (21.4%) | +100 |
| **Full stations** | 50 (5%) | +31 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 54 | 55 |
| York St / Queens Quay W | 52 | 57 |
| Bay St / Albert St | 51 | 63 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| Bremner Blvd / Rees St | 40 | 49 |
| 285 Victoria St | 38 | 39 |
| Bond St / Queen St E | 34 | 37 |
| Exhibition GO (Atlantic Ave) | 34 | 35 |
| St. George St / Willcocks St | 34 | 35 |
| Hanna Ave / Liberty St | 33 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 144 Harrison St | 50 | 51 |
| Fort York  Blvd / Capreol Ct | 44 | 47 |
| 800 Fleet St (North) | 43 | 43 |
| Dundas St W / Crawford St | 42 | 47 |
| 2700 Eglinton Ave W | 42 | 43 |
| 800 Fleet St (South) | 41 | 43 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| 91 Via Italia | 39 | 39 |
| 365 Lippincott St | 39 | 41 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 215 |
| Full       | 49 |
| Available  | 742 |

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
- The mean availability is 29.9% with a standard deviation of 31.6%
- The system is currently operating at 32% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +31% | Concert | General prediction |
| Wellesley Station Green P | +26% | Concert | General prediction |
| St. George St / Bloor St W | +17% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-01-14 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-01-17 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-01-19 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-01-12 17:20 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

