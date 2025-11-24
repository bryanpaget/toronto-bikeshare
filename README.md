# 🚲 Toronto Bike Share Analytics

Updated: 2025-11-24 12:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,990 | -369 |
| **Total docks available** | 12,111 | +581 |
| **System utilization rate** | 33.1% | -2.5% |
| **Active stations** | 987/987 (100%) | -1 |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 312 (31.6%) | +66 |
| **Full stations** | 44 (4.5%) | -14 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 59 | 63 |
| Bay St / Albert St | 54 | 63 |
| York St / Queens Quay W | 54 | 57 |
| Wellington St W / Bay St | 52 | 55 |
| Temperance St Station | 48 | 55 |
| Bremner Blvd / Rees St | 47 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 46 | 47 |
| Queen St W / Ossington Ave | 39 | 43 |
| Bay St / Dundas St W | 36 | 55 |
| King St W / University Ave | 36 | 38 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 52 | 79 |
| Fort York  Blvd / Capreol Ct | 46 | 47 |
| 439 Sherbourne St | 46 | 47 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Jarvis St / Isabella St | 39 | 39 |
| Dundas St W / Crawford St | 38 | 47 |
| Brimley Rd / Lawrence Ave E  | 38 | 39 |
| 9 Willingdon Blvd | 37 | 39 |
| Balliol St / Yonge St - SMART | 36 | 36 |
| Yonge St / Orchard View Blvd | 35 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 312 |
| Full       | 44 |
| Available  | 631 |

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
- The mean availability is 28.8% with a standard deviation of 32.7%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
