# 🚲 Toronto Bike Share Analytics

Updated: 2025-08-11 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,875 | -278 |
| **Total docks available** | 11,036 | -34 |
| **System utilization rate** | 34.7% | -1.0% |
| **Active stations** | 941/941 (100%) | -5 |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 147 (15.6%) | +31 |
| **Full stations** | 37 (3.9%) | +12 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 51 | 63 |
| Wellington St W / Bay St | 51 | 55 |
| York St / Queens Quay W | 47 | 57 |
| Front St W / Yonge St (Hockey Hall of Fame) | 38 | 47 |
| Queens Quay / Yonge St | 38 | 47 |
| Bremner Blvd / Rees St | 37 | 49 |
| St. George St / Willcocks St | 34 | 35 |
| King St W / University Ave | 33 | 36 |
| Temperance St Station | 32 | 55 |
| King St W / Bay St (West Side) | 29 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 51 | 63 |
| 144 Harrison St | 45 | 51 |
| Toronto Inukshuk Park | 45 | 47 |
| Frederick St / King St E | 44 | 47 |
| 439 Sherbourne St | 44 | 47 |
| Queen St W / Ossington Ave | 43 | 43 |
| Dundas St W / Crawford St | 43 | 47 |
| Fort York  Blvd / Capreol Ct | 42 | 47 |
| Cherry Beach | 42 | 49 |
| Bay St / Dundas St W | 38 | 55 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 147 |
| Full       | 37 |
| Available  | 757 |

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
- The mean availability is 31.3% with a standard deviation of 29.4%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
