# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-19 13:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,695 | -213 |
| **Total docks available** | 10,752 | +276 |
| **System utilization rate** | 34.6% | -1.4% |
| **Active stations** | 933/934 (99.9%) |  |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 141 (15.1%) | -12 |
| **Full stations** | 30 (3.2%) | -3 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Queen St W / Ossington Ave | 43 | 43 |
| 2700 Eglinton Ave W | 39 | 43 |
| Queens Quay / Yonge St | 37 | 46 |
| Cherry Beach | 37 | 49 |
| 144 Harrison St | 34 | 51 |
| 1 Shortt St | 32 | 38 |
| Bremner Blvd / Rees St | 31 | 49 |
| 265 Armadale Ave | 31 | 44 |
| 800 Fleet St (South) | 31 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 58 | 63 |
| Bay St / Albert St | 51 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Temperance St Station | 46 | 55 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Bay St / Dundas St W | 44 | 55 |
| Frederick St / King St E | 43 | 47 |
| Wellington St W / Bay St | 40 | 55 |
| King St W / Bay St (West Side) | 37 | 39 |
| Dundonald St / Church St | 37 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 141 |
| Full       | 30 |
| Available  | 763 |

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
- The mean availability is 30.6% with a standard deviation of 27.5%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
