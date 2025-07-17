# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-17 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,959 | +159 |
| **Total docks available** | 10,464 | -282 |
| **System utilization rate** | 36.3% | +1.2% |
| **Active stations** | 932/933 (99.9%) | +3 |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 163 (17.5%) | +3 |
| **Full stations** | 29 (3.1%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 58 | 63 |
| Temperance St Station | 53 | 55 |
| York St / Queens Quay W | 50 | 57 |
| Front St W / Yonge St (Hockey Hall of Fame) | 47 | 47 |
| Wellington St W / Bay St | 46 | 55 |
| Queen St W / Ossington Ave | 40 | 43 |
| Humber Bay Shores Park / Marine Parade Dr | 36 | 63 |
| King St W / University Ave | 33 | 36 |
| Cherry Beach | 32 | 49 |
| St. George St / Willcocks St | 32 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Hanlan's Point Beach | 46 | 47 |
| Bay St / Dundas St W | 43 | 55 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| 144 Harrison St | 41 | 51 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Dundas St W / Crawford St | 39 | 47 |
| 439 Sherbourne St | 39 | 47 |
| Dundonald St / Church St | 38 | 39 |
| 91 Via Italia | 37 | 39 |
| Frederick St / King St E | 35 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 163 |
| Full       | 29 |
| Available  | 741 |

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
- The mean availability is 31.4% with a standard deviation of 28.4%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
