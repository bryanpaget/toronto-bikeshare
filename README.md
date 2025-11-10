# 🚲 Toronto Bike Share Analytics

Updated: 2025-11-10 12:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 7,231 | +610 |
| **Total docks available** | 10,573 | -562 |
| **System utilization rate** | 40.6% | +3.3% |
| **Active stations** | 986/986 (100%) | +4 |
| **Average bikes per station** | 7.3 | +1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 171 (17.3%) | -55 |
| **Full stations** | 44 (4.5%) | -17 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 61 | 63 |
| York St / Queens Quay W | 52 | 57 |
| Bay St / Albert St | 49 | 63 |
| Bremner Blvd / Rees St | 46 | 49 |
| Frederick St / King St E | 46 | 47 |
| Simcoe St / Pullan Pl | 43 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Cherry Beach | 39 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 36 | 47 |
| Mill St / Cherry St | 36 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| Wellington St W / Bay St | 36 | 55 |
| Toronto Inukshuk Park | 34 | 47 |
| 9 Willingdon Blvd | 34 | 39 |
| Yonge St / Orchard View Blvd | 32 | 35 |
| Lillian St / Soudan Ave - SMART | 32 | 32 |
| Dundas St W / Crawford St | 30 | 47 |
| Bond St / Queen St E | 28 | 37 |
| Western Battery Rd / Pirandello St | 27 | 31 |
| Jarvis St / Dundas St E | 26 | 27 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 171 |
| Full       | 44 |
| Available  | 771 |

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
- The mean availability is 35.5% with a standard deviation of 32.2%
- The system is currently operating at 41% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
