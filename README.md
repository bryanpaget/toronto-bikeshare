# 🚲 Toronto Bike Share Analytics

Updated: 2025-11-03 12:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,621 | +334 |
| **Total docks available** | 11,135 | -166 |
| **System utilization rate** | 37.3% | +1.5% |
| **Active stations** | 982/982 (100%) | +2 |
| **Average bikes per station** | 6.7 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 226 (23%) | -36 |
| **Full stations** | 61 (6.2%) | +3 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 60 | 63 |
| Wellington St W / Bay St | 52 | 55 |
| Bay St / Albert St | 50 | 63 |
| York St / Queens Quay W | 48 | 57 |
| Queens Quay / Yonge St | 47 | 47 |
| Cherry Beach | 45 | 49 |
| Bremner Blvd / Rees St | 44 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| King St W / University Ave | 37 | 39 |
| Huron St / Harbord St | 36 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 439 Sherbourne St | 47 | 47 |
| Dundas St W / Crawford St | 45 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Simcoe St / Pullan Pl | 39 | 47 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| Jarvis St / Isabella St | 35 | 39 |
| Bloor St W / Shaw St - SMART | 34 | 34 |
| Bathurst St / Front St W | 34 | 35 |
| Lisgar Park | 33 | 35 |
| Church St / Alexander St | 32 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 226 |
| Full       | 61 |
| Available  | 695 |

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
- The mean availability is 32.5% with a standard deviation of 33.3%
- The system is currently operating at 37% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
