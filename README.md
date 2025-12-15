# 🚲 Toronto Bike Share Analytics

Updated: 2025-12-15 12:12 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,005 | +182 |
| **Total docks available** | 12,273 | +279 |
| **System utilization rate** | 32.9% | +0.2% |
| **Active stations** | 996/996 (100%) | +6 |
| **Average bikes per station** | 6 | +0 |
| **Median station capacity** | 17.5 | - |
| **Empty stations** | 262 (26.3%) | -30 |
| **Full stations** | 47 (4.7%) | -3 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 62 | 63 |
| Bay St / Albert St | 55 | 63 |
| York St / Queens Quay W | 54 | 57 |
| Queens Quay / Yonge St | 47 | 47 |
| Cherry Beach | 46 | 49 |
| Toronto Inukshuk Park | 46 | 47 |
| Bremner Blvd / Rees St | 42 | 49 |
| Temperance St Station | 36 | 55 |
| Queen St W / Ossington Ave | 36 | 43 |
| Bay St / Queens Quay W (Ferry Terminal) | 35 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| 144 Harrison St | 49 | 51 |
| Fort York  Blvd / Capreol Ct | 46 | 47 |
| Simcoe St / Pullan Pl | 44 | 79 |
| Bay St / Dundas St W | 41 | 55 |
| 800 Fleet St (North) | 39 | 43 |
| Jarvis St / Isabella St | 38 | 39 |
| 1 Shortt St | 38 | 38 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| 9 Willingdon Blvd | 37 | 39 |
| Mill St / Cherry St | 36 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 262 |
| Full       | 47 |
| Available  | 687 |

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
- The mean availability is 29.4% with a standard deviation of 32.3%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
