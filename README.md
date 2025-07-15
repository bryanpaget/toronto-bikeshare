# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-15 13:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,838 | -180 |
| **Total docks available** | 10,755 | +94 |
| **System utilization rate** | 35.2% | -0.9% |
| **Active stations** | 927/928 (99.9%) | -1 |
| **Average bikes per station** | 6.3 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 160 (17.2%) | +12 |
| **Full stations** | 33 (3.6%) |  |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 52 | 63 |
| York St / Queens Quay W | 51 | 57 |
| Wellington St W / Bay St | 48 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 40 | 47 |
| King St W / University Ave | 37 | 39 |
| Queens Quay / Yonge St | 36 | 46 |
| Simcoe St / Queen St W | 33 | 39 |
| Queen St W / Ossington Ave | 32 | 43 |
| Bay St / Queens Quay W (Ferry Terminal) | 31 | 35 |
| Bremner Blvd / Rees St | 31 | 49 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 49 | 63 |
| Dundas St W / Crawford St | 47 | 47 |
| 439 Sherbourne St | 43 | 47 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Cherry Beach | 40 | 48 |
| Berkeley St / Dundas St E - SMART | 37 | 40 |
| Hanlan's Point Ferry Dock | 37 | 39 |
| Dundonald St / Church St | 34 | 39 |
| Toronto Inukshuk Park | 34 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 160 |
| Full       | 32 |
| Available  | 736 |

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
- The mean availability is 31.3% with a standard deviation of 28.7%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
