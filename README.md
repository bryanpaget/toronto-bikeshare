# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 03:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,865 | +111 |
| **Total docks available** | 9,732 | -53 |
| **System utilization rate** | 41.4% | +0.5% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 7.5 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 134 (14.5%) | -13 |
| **Full stations** | 67 (7.3%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Frederick St / King St E | 44 | 47 |
| 265 Armadale Ave | 40 | 44 |
| Fort York  Blvd / Capreol Ct | 36 | 47 |
| 144 Harrison St | 36 | 51 |
| 439 Sherbourne St | 36 | 47 |
| 800 Fleet St (North) | 36 | 43 |
| Lisgar Park | 35 | 35 |
| Berkeley St / Dundas St E - SMART | 34 | 40 |
| 800 Fleet St (South) | 33 | 43 |
| Centre Island Ferry Dock | 33 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 61 | 63 |
| Temperance St Station | 55 | 55 |
| Bay St / Dundas St W | 53 | 55 |
| Wellington St W / Bay St | 51 | 55 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Hanlan's Point Beach | 42 | 47 |
| 285 Victoria St | 39 | 39 |
| York St / Queens Quay W | 38 | 57 |
| Humber Bay Shores Park / Marine Parade Dr | 38 | 63 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 134 |
| Full       | 67 |
| Available  | 720 |

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
- The mean availability is 38% with a standard deviation of 31.2%
- The system is currently operating at 41% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
