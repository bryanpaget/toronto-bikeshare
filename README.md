# 🚲 Toronto Bike Share Analytics

Updated: 2026-03-02 12:33 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,130 | -109 |
| **Total docks available** | 12,386 | +178 |
| **System utilization rate** | 33.1% | -0.7% |
| **Active stations** | 1013/1013 (100%) | +3 |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 169 (16.7%) | +12 |
| **Full stations** | 34 (3.4%) | +16 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 64 | 79 |
| Temperance St Station | 44 | 55 |
| Queens Quay / Yonge St | 38 | 47 |
| King St W / Bay St (West Side) | 34 | 38 |
| Hanna Ave / Liberty St | 34 | 35 |
| King St W / Portland St - SMART | 29 | 32 |
| Bay St / Albert St | 28 | 63 |
| Queen St W / Ossington Ave | 28 | 43 |
| HTO Park West | 28 | 31 |
| York St / Queen St W (City Hall) | 26 | 27 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 2700 Eglinton Ave W | 42 | 43 |
| 800 Fleet St (South) | 41 | 43 |
| Humber Bay Shores Park / Marine Parade Dr | 40 | 63 |
| 144 Harrison St | 39 | 51 |
| 800 Fleet St (North) | 39 | 43 |
| 365 Lippincott St | 39 | 41 |
| 1 Shortt St | 39 | 39 |
| 9 Willingdon Blvd | 39 | 39 |
| 265 Armadale Ave | 38 | 44 |
| 3220 Bloor St W | 38 | 38 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 169 |
| Full       | 34 |
| Available  | 810 |

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
- The mean availability is 30.7% with a standard deviation of 28.9%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +27% | Concert | General prediction |
| Wellesley Station Green P | +27% | Concert | General prediction |
| St. George St / Bloor St W | +13% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-03-04 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-03-07 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-03-09 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-03-02 17:34 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

