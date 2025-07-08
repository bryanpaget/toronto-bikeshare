# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 11:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,067 | -45 |
| **Total docks available** | 10,641 | +41 |
| **System utilization rate** | 36.3% | -0.3% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 6.6 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 162 (17.6%) | +8 |
| **Full stations** | 49 (5.3%) | -1 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 54 | 57 |
| Wellington St W / Bay St | 49 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Bremner Blvd / Rees St | 43 | 49 |
| Queens Quay / Yonge St | 41 | 46 |
| Bay St / Albert St | 40 | 63 |
| King St W / University Ave | 38 | 38 |
| Frederick St / King St E | 35 | 47 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| 265 Armadale Ave | 34 | 44 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Dundas St W / Crawford St | 44 | 47 |
| Hanlan's Point Beach | 43 | 47 |
| Fort York  Blvd / Capreol Ct | 40 | 47 |
| 144 Harrison St | 40 | 51 |
| Dundonald St / Church St | 38 | 39 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Church St / Alexander St | 34 | 35 |
| Cherry Beach | 34 | 49 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 162 |
| Full       | 49 |
| Available  | 710 |

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
- The mean availability is 32.6% with a standard deviation of 29.9%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
