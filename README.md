# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 17:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,717 | -306 |
| **Total docks available** | 10,977 | +256 |
| **System utilization rate** | 34.2% | -1.7% |
| **Active stations** | 924/924 (100%) |  |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 113 (12.2%) | +10 |
| **Full stations** | 10 (1.1%) | -8 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Temperance St Station | 51 | 55 |
| Queens Quay / Yonge St | 40 | 46 |
| Bay St / Albert St | 35 | 63 |
| Bremner Blvd / Rees St | 34 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 33 | 45 |
| Frederick St / King St E | 33 | 47 |
| 3220 Bloor St W | 33 | 38 |
| Wellington St W / Bay St | 31 | 55 |
| York St / Queens Quay W | 31 | 57 |
| 800 Fleet St (North) | 31 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 45 | 63 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| 439 Sherbourne St | 35 | 47 |
| Fort York  Blvd / Capreol Ct | 33 | 47 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |
| Bay St / Dundas St W | 33 | 55 |
| Simcoe St / Pullan Pl | 33 | 47 |
| Cherry Beach | 32 | 49 |
| 285 Victoria St | 32 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 113 |
| Full       | 10 |
| Available  | 801 |

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
- The mean availability is 30.7% with a standard deviation of 25.6%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
