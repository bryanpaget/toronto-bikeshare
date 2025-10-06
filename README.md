# 🚲 Toronto Bike Share Analytics

Updated: 2025-10-06 13:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,702 | +121 |
| **Total docks available** | 11,684 | +210 |
| **System utilization rate** | 32.8% | +0.1% |
| **Active stations** | 990/990 (100%) | +6 |
| **Average bikes per station** | 5.8 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 248 (25.1%) | +56 |
| **Full stations** | 40 (4%) | +6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Temperance St Station | 52 | 55 |
| Wellington St W / Bay St | 50 | 55 |
| Queens Quay / Yonge St | 44 | 47 |
| Frederick St / King St E | 44 | 47 |
| Bremner Blvd / Rees St | 43 | 49 |
| King St W / Bay St (West Side) | 37 | 39 |
| Cherry Beach | 36 | 49 |
| Bay St / Albert St | 35 | 63 |
| 2700 Eglinton Ave W | 35 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 439 Sherbourne St | 45 | 47 |
| Dundas St W / Crawford St | 42 | 47 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Dundonald St / Church St | 39 | 39 |
| Berkeley St / Dundas St E - SMART | 38 | 40 |
| Humber Bay Shores Park / Marine Parade Dr | 38 | 63 |
| 1 Shortt St | 38 | 38 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| 365 Lippincott St | 35 | 41 |
| Church St / Alexander St | 34 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 248 |
| Full       | 40 |
| Available  | 702 |

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
- The mean availability is 28.2% with a standard deviation of 30.5%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
