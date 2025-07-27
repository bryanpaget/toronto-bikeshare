# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-27 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,953 | +87 |
| **Total docks available** | 10,768 | +9 |
| **System utilization rate** | 35.6% | +0.3% |
| **Active stations** | 934/934 (100%) | +2 |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 122 (13.1%) | -27 |
| **Full stations** | 35 (3.7%) | +1 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Queens Quay / Yonge St | 45 | 47 |
| Cherry Beach | 45 | 49 |
| Bay St / Queens Quay W (Ferry Terminal) | 32 | 35 |
| York St / Queens Quay W | 32 | 57 |
| King St W / Portland St - SMART | 30 | 32 |
| Hanlan's Point Beach | 30 | 47 |
| Martin Goodman Trail (Marilyn Bell Park) | 28 | 31 |
| Bathurst St / Front St W | 28 | 35 |
| 1 Shortt St | 28 | 38 |
| Dundonald St / Church St | 27 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 46 | 63 |
| 439 Sherbourne St | 45 | 47 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Wellington St W / Bay St | 44 | 55 |
| Dundas St W / Crawford St | 40 | 47 |
| Humber Bay Shores Park / Marine Parade Dr | 40 | 63 |
| Fort York  Blvd / Capreol Ct | 38 | 47 |
| Temperance St Station | 38 | 55 |
| Frederick St / King St E | 38 | 47 |
| Bay St / Dundas St W | 38 | 55 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 122 |
| Full       | 35 |
| Available  | 777 |

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
- The mean availability is 32.2% with a standard deviation of 27.8%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
