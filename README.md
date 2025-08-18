# 🚲 Toronto Bike Share Analytics

Updated: 2025-08-18 13:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,170 | +295 |
| **Total docks available** | 10,998 | -38 |
| **System utilization rate** | 35.9% | +1.2% |
| **Active stations** | 953/953 (100%) | +12 |
| **Average bikes per station** | 6.5 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 149 (15.6%) | +2 |
| **Full stations** | 38 (4%) | +1 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 49 | 57 |
| Temperance St Station | 48 | 55 |
| Bay St / Albert St | 43 | 63 |
| Wellington St W / Bay St | 41 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 40 | 47 |
| Cherry Beach | 40 | 48 |
| 2700 Eglinton Ave W | 40 | 43 |
| King St W / Bay St (West Side) | 39 | 39 |
| Queens Quay / Yonge St | 38 | 47 |
| 144 Harrison St | 36 | 51 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 59 | 63 |
| Bay St / Dundas St W | 50 | 55 |
| 439 Sherbourne St | 43 | 47 |
| Berkeley St / Dundas St E - SMART | 39 | 40 |
| Fort York  Blvd / Capreol Ct | 37 | 47 |
| Bloor St W / Manning Ave - SMART | 36 | 42 |
| Dundas St W / Crawford St | 34 | 47 |
| Spadina Ave / Harbord St - SMART | 34 | 36 |
| Toronto Inukshuk Park | 33 | 47 |
| Bloor St W / Shaw St - SMART | 31 | 34 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 149 |
| Full       | 37 |
| Available  | 767 |

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
- The mean availability is 31.8% with a standard deviation of 29%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
