# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-08 20:20 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,225 | -17 |
| **Total docks available** | 12,310 | +135 |
| **System utilization rate** | 33.6% | -0.3% |
| **Active stations** | 1007/1007 (100%) | +3 |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 121 (12%) | +1 |
| **Full stations** | 20 (2%) | -11 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bremner Blvd / Rees St | 44 | 49 |
| Queens Quay / Yonge St | 44 | 47 |
| Bay St / Dundas St W | 42 | 55 |
| Temperance St Station | 38 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 37 | 47 |
| 285 Victoria St | 36 | 39 |
| Toronto Inukshuk Park | 34 | 47 |
| Bay St / Albert St | 33 | 62 |
| Balliol St / Yonge St - SMART | 32 | 36 |
| Exhibition GO (Atlantic Ave) | 31 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 52 | 79 |
| Humber Bay Shores Park / Marine Parade Dr | 51 | 63 |
| 144 Harrison St | 48 | 51 |
| 800 Fleet St (South) | 41 | 43 |
| 2700 Eglinton Ave W | 40 | 43 |
| 800 Fleet St (North) | 40 | 43 |
| Wellington St W / Bay St | 39 | 55 |
| Jarvis St / Isabella St | 38 | 39 |
| 91 Via Italia | 37 | 39 |
| 265 Armadale Ave | 37 | 45 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 121 |
| Full       | 20 |
| Available  | 866 |

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
- The mean availability is 31.2% with a standard deviation of 27.8%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
