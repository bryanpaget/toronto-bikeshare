# 🚲 Toronto Bike Share Analytics

Updated: 2025-12-08 12:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,823 | -198 |
| **Total docks available** | 11,994 | +26 |
| **System utilization rate** | 32.7% | -0.8% |
| **Active stations** | 990/990 (100%) | +1 |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 292 (29.5%) | -20 |
| **Full stations** | 50 (5.1%) | -7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 61 | 63 |
| York St / Queens Quay W | 52 | 57 |
| Wellington St W / Bay St | 51 | 55 |
| Bremner Blvd / Rees St | 45 | 49 |
| Toronto Inukshuk Park | 45 | 47 |
| Simcoe St / Pullan Pl | 45 | 79 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| Queens Quay / Yonge St | 43 | 47 |
| Cherry Beach | 43 | 49 |
| Temperance St Station | 40 | 55 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Niagara St / Richmond St W | 41 | 42 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Jarvis St / Isabella St | 38 | 39 |
| Brimley Rd / Lawrence Ave E  | 38 | 39 |
| Dundonald St / Church St | 37 | 39 |
| 439 Sherbourne St | 37 | 47 |
| 9 Willingdon Blvd | 37 | 39 |
| Balliol St / Yonge St - SMART | 36 | 36 |
| Church St / Alexander St | 35 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 292 |
| Full       | 49 |
| Available  | 649 |

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
- The mean availability is 28.4% with a standard deviation of 32.7%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
