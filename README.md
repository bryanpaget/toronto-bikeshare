# 🚲 Toronto Bike Share Analytics

Updated: 2025-12-22 12:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,921 | -84 |
| **Total docks available** | 12,472 | +199 |
| **System utilization rate** | 32.2% | -0.7% |
| **Active stations** | 1001/1001 (100%) | +5 |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 224 (22.4%) | -38 |
| **Full stations** | 43 (4.3%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 63 | 63 |
| Humber Bay Shores Park / Marine Parade Dr | 61 | 63 |
| Wellington St W / Bay St | 51 | 55 |
| Cherry Beach | 46 | 49 |
| Frederick St / King St E | 43 | 47 |
| Toronto Inukshuk Park | 42 | 47 |
| Bay St / Dundas St W | 41 | 55 |
| Queens Quay / Yonge St | 40 | 47 |
| King St W / University Ave | 37 | 39 |
| Queen St W / Ossington Ave | 35 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 62 | 79 |
| 144 Harrison St | 50 | 51 |
| 265 Armadale Ave | 43 | 45 |
| Dundas St W / Crawford St | 40 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| 800 Fleet St (South) | 40 | 43 |
| 2700 Eglinton Ave W | 40 | 43 |
| 365 Lippincott St | 40 | 41 |
| 91 Via Italia | 38 | 39 |
| 1 Shortt St | 38 | 38 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 224 |
| Full       | 43 |
| Available  | 734 |

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
- The mean availability is 29% with a standard deviation of 30.6%
- The system is currently operating at 32% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
