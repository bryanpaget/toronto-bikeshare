# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-09 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,056 | +141 |
| **Total docks available** | 10,709 | +62 |
| **System utilization rate** | 36.1% | +0.4% |
| **Active stations** | 926/926 (100%) | +2 |
| **Average bikes per station** | 6.5 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 145 (15.7%) |  |
| **Full stations** | 23 (2.5%) | -33 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 50 | 55 |
| York St / Queens Quay W | 50 | 57 |
| Front St W / Yonge St (Hockey Hall of Fame) | 42 | 45 |
| Bay St / Albert St | 41 | 63 |
| Queens Quay / Yonge St | 41 | 46 |
| Cherry Beach | 39 | 48 |
| Temperance St Station | 35 | 55 |
| 3220 Bloor St W | 34 | 38 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |
| Bay St / Dundas St W | 33 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Dundas St W / Crawford St | 46 | 47 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Toronto Inukshuk Park | 40 | 47 |
| Hanlan's Point Beach | 39 | 47 |
| Brimley Rd / Lawrence Ave E  | 35 | 39 |
| Bloor St W / Shaw St - SMART | 34 | 34 |
| Berkeley St / Dundas St E - SMART | 34 | 40 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 145 |
| Full       | 23 |
| Available  | 758 |

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
- The mean availability is 32.3% with a standard deviation of 29.2%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
