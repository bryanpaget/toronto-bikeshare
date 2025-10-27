# 🚲 Toronto Bike Share Analytics

Updated: 2025-10-27 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,287 | +107 |
| **Total docks available** | 11,301 | +37 |
| **System utilization rate** | 35.7% | +0.3% |
| **Active stations** | 980/981 (99.9%) | -2 |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 262 (26.7%) | +35 |
| **Full stations** | 58 (5.9%) | -3 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 58 | 63 |
| Bay St / Dundas St W | 53 | 55 |
| Wellington St W / Bay St | 51 | 55 |
| York St / Queens Quay W | 48 | 57 |
| Bremner Blvd / Rees St | 47 | 49 |
| Queens Quay / Yonge St | 46 | 47 |
| Queen St W / Ossington Ave | 42 | 43 |
| Front St W / Yonge St (Hockey Hall of Fame) | 40 | 47 |
| Frederick St / King St E | 40 | 47 |
| Bay St / Albert St | 38 | 63 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Dundas St W / Crawford St | 47 | 47 |
| 439 Sherbourne St | 47 | 47 |
| Fort York  Blvd / Capreol Ct | 43 | 47 |
| Bloor St W / Manning Ave - SMART | 36 | 42 |
| Berkeley St / Dundas St E - SMART | 35 | 40 |
| 9 Willingdon Blvd | 35 | 38 |
| Brimley Rd / Lawrence Ave E  | 34 | 39 |
| Bloor St W / Shaw St - SMART | 32 | 34 |
| Lillian St / Soudan Ave - SMART | 32 | 32 |
| Spadina Ave / Harbord St - SMART | 31 | 36 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 262 |
| Full       | 57 |
| Available  | 662 |

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
- The mean availability is 30.7% with a standard deviation of 33.4%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
