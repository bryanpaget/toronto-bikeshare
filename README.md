# 🚲 Toronto Bike Share Analytics

Updated: 2025-09-22 13:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,055 | +205 |
| **Total docks available** | 11,295 | -209 |
| **System utilization rate** | 34.9% | +1.2% |
| **Active stations** | 980/980 (100%) | +5 |
| **Average bikes per station** | 6.2 | +0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 187 (19.1%) | -11 |
| **Full stations** | 38 (3.9%) | -9 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 53 | 55 |
| York St / Queens Quay W | 52 | 57 |
| Bay St / Albert St | 50 | 63 |
| Bremner Blvd / Rees St | 46 | 49 |
| Queens Quay / Yonge St | 45 | 47 |
| Toronto Inukshuk Park | 44 | 47 |
| Bay St / Dundas St W | 42 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 40 | 47 |
| King St W / University Ave | 37 | 37 |
| 2700 Eglinton Ave W | 35 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| 439 Sherbourne St | 46 | 47 |
| Fort York  Blvd / Capreol Ct | 43 | 47 |
| Dundas St W / Crawford St | 42 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Berkeley St / Dundas St E - SMART | 39 | 40 |
| Temperance St Station | 38 | 55 |
| 365 Lippincott St | 35 | 41 |
| Hanlan's Point Beach | 35 | 47 |
| Spadina Ave / Sussex Ave  | 34 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 187 |
| Full       | 38 |
| Available  | 755 |

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
- The mean availability is 30.2% with a standard deviation of 29.8%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
