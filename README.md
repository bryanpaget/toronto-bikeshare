# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 19:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,915 | +63 |
| **Total docks available** | 10,647 | -144 |
| **System utilization rate** | 35.7% | +0.6% |
| **Active stations** | 924/924 (100%) |  |
| **Average bikes per station** | 6.4 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 145 (15.7%) | +7 |
| **Full stations** | 56 (6.1%) | +16 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Dundas St W / Crawford St | 42 | 47 |
| Toronto Inukshuk Park | 42 | 47 |
| 800 Fleet St (South) | 40 | 43 |
| Niagara St / Richmond St W | 35 | 42 |
| 800 Fleet St (North) | 34 | 43 |
| 3220 Bloor St W | 31 | 38 |
| Bathurst St/Queens Quay(Billy Bishop Airport) | 30 | 34 |
| Cherry Beach | 30 | 49 |
| Hanna Ave / Liberty St | 29 | 32 |
| Martin Goodman Trail (Marilyn Bell Park) | 28 | 31 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 59 | 63 |
| Temperance St Station | 53 | 55 |
| Wellington St W / Bay St | 53 | 55 |
| York St / Queens Quay W | 53 | 57 |
| Simcoe St / Pullan Pl | 46 | 47 |
| Bay St / Dundas St W | 44 | 55 |
| Humber Bay Shores Park / Marine Parade Dr | 43 | 63 |
| 439 Sherbourne St | 37 | 47 |
| King St W / Bay St (West Side) | 36 | 38 |
| Bond St / Queen St E | 36 | 37 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 145 |
| Full       | 56 |
| Available  | 723 |

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
- The mean availability is 32.8% with a standard deviation of 30%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
