# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 04:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,975 | +110 |
| **Total docks available** | 9,698 | -34 |
| **System utilization rate** | 41.8% | +0.5% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 7.6 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 126 (13.7%) | -8 |
| **Full stations** | 70 (7.6%) | +3 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Frederick St / King St E | 44 | 47 |
| Fort York  Blvd / Capreol Ct | 40 | 47 |
| 144 Harrison St | 39 | 51 |
| 265 Armadale Ave | 39 | 44 |
| 439 Sherbourne St | 36 | 47 |
| 800 Fleet St (South) | 36 | 43 |
| 800 Fleet St (North) | 36 | 43 |
| Lisgar Park | 35 | 35 |
| Berkeley St / Dundas St E - SMART | 34 | 40 |
| Bloor St W / Manning Ave - SMART | 33 | 42 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 61 | 63 |
| Temperance St Station | 55 | 55 |
| Bay St / Dundas St W | 53 | 55 |
| Wellington St W / Bay St | 52 | 55 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Hanlan's Point Beach | 42 | 47 |
| 285 Victoria St | 39 | 39 |
| York St / Queens Quay W | 38 | 57 |
| Humber Bay Shores Park / Marine Parade Dr | 38 | 63 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 126 |
| Full       | 70 |
| Available  | 725 |

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
- The mean availability is 38.6% with a standard deviation of 31.3%
- The system is currently operating at 42% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
