# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 09:17 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,018 | -346 |
| **Total docks available** | 10,681 | +315 |
| **System utilization rate** | 36% | -2.0% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 6.5 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 160 (17.4%) | +49 |
| **Full stations** | 41 (4.5%) | +22 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 51 | 57 |
| Wellington St W / Bay St | 50 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 45 | 47 |
| Bremner Blvd / Rees St | 44 | 49 |
| Queens Quay / Yonge St | 39 | 46 |
| King St W / University Ave | 38 | 38 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| 265 Armadale Ave | 34 | 44 |
| King St W / Bay St (West Side) | 33 | 38 |
| Bay St / Albert St | 32 | 63 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| Hanlan's Point Beach | 42 | 47 |
| Bay St / Dundas St W | 41 | 55 |
| Fort York  Blvd / Capreol Ct | 40 | 47 |
| Temperance St Station | 40 | 55 |
| Dundas St W / Crawford St | 39 | 47 |
| 144 Harrison St | 39 | 51 |
| 439 Sherbourne St | 39 | 47 |
| Dundonald St / Church St | 36 | 39 |
| 365 Lippincott St | 36 | 41 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 160 |
| Full       | 41 |
| Available  | 720 |

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
- The mean availability is 32.4% with a standard deviation of 29%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
