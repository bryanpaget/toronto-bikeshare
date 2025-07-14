# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-14 13:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,018 | -375 |
| **Total docks available** | 10,661 | +446 |
| **System utilization rate** | 36.1% | -2.4% |
| **Active stations** | 928/928 (100%) | +3 |
| **Average bikes per station** | 6.5 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 148 (15.9%) | +41 |
| **Full stations** | 33 (3.6%) | +9 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 52 | 63 |
| York St / Queens Quay W | 51 | 57 |
| Frederick St / King St E | 45 | 47 |
| Wellington St W / Bay St | 44 | 55 |
| Queens Quay / Yonge St | 42 | 46 |
| Bremner Blvd / Rees St | 37 | 49 |
| King St W / Bay St (West Side) | 32 | 39 |
| 3220 Bloor St W | 32 | 38 |
| Bay St / Queens Quay W (Ferry Terminal) | 31 | 35 |
| Queen St W / Ossington Ave | 31 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 51 | 63 |
| 439 Sherbourne St | 46 | 47 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Dundas St W / Crawford St | 42 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Cherry Beach | 40 | 49 |
| Simcoe St / Pullan Pl | 39 | 47 |
| 91 Via Italia | 37 | 39 |
| Toronto Inukshuk Park | 36 | 47 |
| Niagara St / Richmond St W | 35 | 42 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 148 |
| Full       | 33 |
| Available  | 747 |

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
- The mean availability is 32.5% with a standard deviation of 28.3%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
