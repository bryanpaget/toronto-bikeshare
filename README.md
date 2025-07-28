# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-28 13:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,818 | -135 |
| **Total docks available** | 10,877 | +109 |
| **System utilization rate** | 34.8% | -0.8% |
| **Active stations** | 936/936 (100%) | +2 |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 182 (19.4%) | +60 |
| **Full stations** | 42 (4.5%) | +7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Temperance St Station | 51 | 55 |
| Wellington St W / Bay St | 50 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 46 | 47 |
| Queens Quay / Yonge St | 44 | 47 |
| Bay St / Albert St | 42 | 63 |
| Bremner Blvd / Rees St | 39 | 49 |
| 265 Armadale Ave | 39 | 44 |
| York St / Queens Quay W | 37 | 57 |
| 2700 Eglinton Ave W | 36 | 43 |
| Frederick St / King St E | 34 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Cherry Beach | 44 | 49 |
| 439 Sherbourne St | 44 | 47 |
| 144 Harrison St | 43 | 51 |
| Humber Bay Shores Park / Marine Parade Dr | 42 | 63 |
| Toronto Inukshuk Park | 42 | 47 |
| Dundas St W / Crawford St | 41 | 47 |
| Fort York  Blvd / Capreol Ct | 40 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Hanlan's Point Beach | 40 | 47 |
| Niagara St / Richmond St W | 39 | 42 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 182 |
| Full       | 42 |
| Available  | 712 |

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
- The mean availability is 30.6% with a standard deviation of 30%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
