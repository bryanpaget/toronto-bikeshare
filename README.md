# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 14:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,138 | +94 |
| **Total docks available** | 10,575 | -91 |
| **System utilization rate** | 36.7% | +0.6% |
| **Active stations** | 923/923 (100%) | +1 |
| **Average bikes per station** | 6.7 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 122 (13.2%) | -23 |
| **Full stations** | 31 (3.4%) | -2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Wellington St W / Bay St | 52 | 55 |
| Bay St / Albert St | 47 | 63 |
| Bremner Blvd / Rees St | 39 | 49 |
| Queens Quay / Yonge St | 39 | 46 |
| Simcoe St / Queen St W | 36 | 39 |
| Front St W / Yonge St (Hockey Hall of Fame) | 35 | 47 |
| 265 Armadale Ave | 35 | 44 |
| St. George St / Willcocks St | 31 | 35 |
| King St W / University Ave | 30 | 38 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 59 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Dundas St W / Crawford St | 38 | 47 |
| Fort York  Blvd / Capreol Ct | 37 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Bloor St W / Shaw St - SMART | 33 | 34 |
| Bathurst St / Front St W | 33 | 35 |
| Temperance St Station | 32 | 55 |
| Bay St / Wellesley St W | 31 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 122 |
| Full       | 31 |
| Available  | 770 |

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
- The mean availability is 32.7% with a standard deviation of 28.3%
- The system is currently operating at 37% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
