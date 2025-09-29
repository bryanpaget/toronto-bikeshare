# 🚲 Toronto Bike Share Analytics

Updated: 2025-09-29 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,581 | -474 |
| **Total docks available** | 11,474 | +179 |
| **System utilization rate** | 32.7% | -2.2% |
| **Active stations** | 984/985 (99.9%) | +4 |
| **Average bikes per station** | 5.7 | -1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 192 (19.5%) | +5 |
| **Full stations** | 34 (3.5%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 54 | 63 |
| Wellington St W / Bay St | 49 | 55 |
| York St / Queens Quay W | 47 | 57 |
| Queens Quay / Yonge St | 46 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 44 | 47 |
| Frederick St / King St E | 44 | 47 |
| 2700 Eglinton Ave W | 41 | 43 |
| Simcoe St / Pullan Pl | 40 | 47 |
| Bremner Blvd / Rees St | 38 | 49 |
| Temperance St Station | 37 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 439 Sherbourne St | 46 | 47 |
| Dundas St W / Crawford St | 40 | 47 |
| Hanlan's Point Beach | 40 | 47 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |
| Berkeley St / Dundas St E - SMART | 37 | 40 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Lake Shore Blvd W / Ontario Dr | 34 | 35 |
| Lisgar Park | 34 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 192 |
| Full       | 34 |
| Available  | 759 |

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
- The mean availability is 27.9% with a standard deviation of 28.1%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
