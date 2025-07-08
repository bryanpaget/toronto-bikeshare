# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 15:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,115 | -23 |
| **Total docks available** | 10,595 | +20 |
| **System utilization rate** | 36.6% | -0.1% |
| **Active stations** | 923/923 (100%) |  |
| **Average bikes per station** | 6.6 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 108 (11.7%) | -14 |
| **Full stations** | 20 (2.2%) | -11 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Wellington St W / Bay St | 48 | 55 |
| Bay St / Albert St | 44 | 63 |
| Queens Quay / Yonge St | 41 | 46 |
| Bremner Blvd / Rees St | 37 | 49 |
| Simcoe St / Queen St W | 35 | 39 |
| Front St W / Yonge St (Hockey Hall of Fame) | 35 | 45 |
| 265 Armadale Ave | 33 | 44 |
| Bay St / Queens Quay W (Ferry Terminal) | 28 | 35 |
| Frederick St / King St E | 28 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 59 | 63 |
| Dundas St W / Crawford St | 39 | 47 |
| Bloor St W / Manning Ave - SMART | 38 | 42 |
| Fort York  Blvd / Capreol Ct | 37 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Bloor St W / Shaw St - SMART | 34 | 34 |
| Bathurst St / Front St W | 34 | 35 |
| Temperance St Station | 33 | 55 |
| Bay St / Wellesley St W | 33 | 35 |
| 439 Sherbourne St | 32 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 108 |
| Full       | 20 |
| Available  | 795 |

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
- The mean availability is 32.6% with a standard deviation of 27.4%
- The system is currently operating at 37% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
