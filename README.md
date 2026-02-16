# 🚲 Toronto Bike Share Analytics

Updated: 2026-02-16 12:31 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,150 | -21 |
| **Total docks available** | 12,195 | +75 |
| **System utilization rate** | 33.5% | -0.2% |
| **Active stations** | 1009/1009 (100%) |  |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 180 (17.8%) | -13 |
| **Full stations** | 35 (3.5%) | -5 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 65 | 79 |
| Bay St / Dundas St W | 52 | 55 |
| Bay St / Albert St | 50 | 62 |
| York St / Queens Quay W | 43 | 57 |
| 285 Victoria St | 39 | 39 |
| Queens Quay / Yonge St | 37 | 47 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| King St E / Church St | 31 | 35 |
| Cherry St / Commissioners St | 31 | 31 |
| Wellington St W / Bay St | 30 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Temperance St Station | 53 | 55 |
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| Niagara St / Richmond St W | 42 | 42 |
| 800 Fleet St (South) | 42 | 43 |
| 2700 Eglinton Ave W | 42 | 43 |
| 144 Harrison St | 41 | 51 |
| 439 Sherbourne St | 40 | 47 |
| 800 Fleet St (North) | 39 | 43 |
| 1 Shortt St | 39 | 39 |
| 9 Willingdon Blvd | 39 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 180 |
| Full       | 35 |
| Available  | 794 |

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
- The mean availability is 30.9% with a standard deviation of 30.4%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)

## 📊 Predictive Analytics

Based on upcoming events and historical patterns, here are the predicted changes in bike demand:

### 📈 High Demand Predictions (Add Bikes)
| Station | Predicted Increase | Event Impact | Associated Event |
|---------|-------------------|--------------|------------------|
| Fort York Blvd / Capreol Ct | +34% | Concert | General prediction |
| Wellesley Station Green P | +22% | Concert | General prediction |
| St. George St / Bloor St W | +19% | Art/Cultural Event | General prediction |

### 📉 No Low Demand Predictions
No stations are predicted to have significantly decreased demand based on upcoming events.

### 📅 Upcoming Events Influencing Predictions
| Event | Date | Description | Recommended Action |
|-------|------|-------------|-------------------|
| [Concert in Trinity Bellwoods](https://www.narcity.com/example1) | 2026-02-18 | A concert in Trinity Bellwoods Park | Increase bikes nearby |
| [Food Festival at Exhibition Place](https://www.narcity.com/example2) | 2026-02-21 | Food festival at Exhibition Place | Increase bikes nearby |
| [Art Fair in Distillery District](https://www.narcity.com/example3) | 2026-02-23 | Art fair in Distillery District | Increase bikes nearby |

*Last updated: 2026-02-16 17:32 (Toronto Time)*
*Model confidence: Based on historical patterns and upcoming events from multiple RSS feeds (Narcity Toronto, View The Vibe, YYZ Deals).*
*Events analyzed: Concert in Trinity Bellwoods, Food Festival at Exhibition Place, Art Fair in Distillery District. Stations near events receive adjusted predictions.*

