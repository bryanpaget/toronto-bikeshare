# 🚲 Toronto Bike Share Analytics

Updated: 2025-11-17 12:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,359 | -872 |
| **Total docks available** | 11,530 | +957 |
| **System utilization rate** | 35.5% | -5.1% |
| **Active stations** | 988/988 (100%) | +2 |
| **Average bikes per station** | 6.4 | -1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 246 (24.9%) | +75 |
| **Full stations** | 58 (5.9%) | +14 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 59 | 63 |
| Humber Bay Shores Park / Marine Parade Dr | 56 | 63 |
| York St / Queens Quay W | 52 | 57 |
| Bay St / Dundas St W | 50 | 55 |
| Temperance St Station | 47 | 55 |
| Bremner Blvd / Rees St | 46 | 49 |
| Queens Quay / Yonge St | 46 | 47 |
| Simcoe St / Pullan Pl | 41 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 39 | 47 |
| Cherry Beach | 39 | 49 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 439 Sherbourne St | 46 | 47 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Dundas St W / Crawford St | 45 | 47 |
| Brimley Rd / Lawrence Ave E  | 38 | 39 |
| Jarvis St / Isabella St | 36 | 39 |
| Balliol St / Yonge St - SMART | 36 | 36 |
| 9 Willingdon Blvd | 36 | 39 |
| Lisgar Park | 35 | 35 |
| Bloor St W / Shaw St - SMART | 34 | 34 |
| Yonge St / Orchard View Blvd | 32 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 246 |
| Full       | 58 |
| Available  | 684 |

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
- The mean availability is 30.8% with a standard deviation of 32.9%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
