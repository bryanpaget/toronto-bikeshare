# 🚲 Toronto Bike Share Analytics

Updated: 2025-09-01 13:05 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,853 | -82 |
| **Total docks available** | 11,544 | +392 |
| **System utilization rate** | 33.6% | -1.1% |
| **Active stations** | 966/966 (100%) | +5 |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 134 (13.9%) | -38 |
| **Full stations** | 26 (2.7%) | -7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Niagara St / Richmond St W | 41 | 42 |
| Toronto Inukshuk Park | 41 | 47 |
| Queen St W / Ossington Ave | 38 | 43 |
| Dundas St W / Crawford St | 35 | 47 |
| York St / Queens Quay W | 34 | 57 |
| 365 Lippincott St | 33 | 41 |
| Queens Quay / Yonge St | 32 | 47 |
| Beverley St / Dundas St W | 29 | 31 |
| Lake Shore Blvd W / Ontario Dr | 29 | 35 |
| 800 Fleet St (South) | 29 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 56 | 63 |
| Temperance St Station | 43 | 55 |
| Bay St / Albert St | 43 | 63 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Cherry Beach | 39 | 48 |
| Bay St / Dundas St W | 39 | 55 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| Bond St / Queen St E | 35 | 37 |
| Wellington St W / Bay St | 35 | 55 |
| Hanlan's Point Ferry Dock | 33 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 134 |
| Full       | 26 |
| Available  | 806 |

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
- The mean availability is 30.5% with a standard deviation of 26.5%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
