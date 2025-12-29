# 🚲 Toronto Bike Share Analytics

Updated: 2025-12-29 12:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,154 | +233 |
| **Total docks available** | 12,196 | -276 |
| **System utilization rate** | 33.5% | +1.3% |
| **Active stations** | 1001/1001 (100%) |  |
| **Average bikes per station** | 6.1 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 156 (15.6%) | -68 |
| **Full stations** | 38 (3.8%) | -5 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 61 | 63 |
| Bay St / Albert St | 59 | 63 |
| Wellington St W / Bay St | 51 | 55 |
| Frederick St / King St E | 46 | 47 |
| Toronto Inukshuk Park | 46 | 47 |
| Queen St W / Ossington Ave | 43 | 43 |
| York St / Queens Quay W | 42 | 57 |
| 285 Victoria St | 39 | 39 |
| Bremner Blvd / Rees St | 37 | 49 |
| Cherry Beach | 37 | 49 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 60 | 79 |
| 144 Harrison St | 47 | 51 |
| Dundas St W / Crawford St | 44 | 47 |
| 265 Armadale Ave | 42 | 45 |
| 2700 Eglinton Ave W | 40 | 43 |
| 365 Lippincott St | 40 | 41 |
| 800 Fleet St (North) | 39 | 43 |
| 91 Via Italia | 38 | 39 |
| 1 Shortt St | 38 | 38 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 156 |
| Full       | 36 |
| Available  | 809 |

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
- The mean availability is 30.6% with a standard deviation of 29.6%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
