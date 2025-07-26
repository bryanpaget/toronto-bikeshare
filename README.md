# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-26 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,866 | +32 |
| **Total docks available** | 10,759 | +101 |
| **System utilization rate** | 35.3% | -0.1% |
| **Active stations** | 932/932 (100%) | -1 |
| **Average bikes per station** | 6.3 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 149 (16%) | -3 |
| **Full stations** | 34 (3.6%) | +4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Queen St W / Ossington Ave | 39 | 43 |
| Niagara St / Richmond St W | 38 | 42 |
| 2700 Eglinton Ave W | 37 | 43 |
| Hanlan's Point Beach | 35 | 47 |
| Bremner Blvd / Rees St | 33 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 30 | 47 |
| Cherry Beach | 30 | 49 |
| Yonge St / Dundas Sq | 29 | 31 |
| 800 Fleet St (South) | 29 | 43 |
| 800 Fleet St (North) | 29 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 54 | 63 |
| York St / Queens Quay W | 50 | 57 |
| Temperance St Station | 46 | 55 |
| Bay St / Dundas St W | 46 | 55 |
| Simcoe St / Pullan Pl | 46 | 47 |
| 439 Sherbourne St | 44 | 47 |
| Wellington St W / Bay St | 41 | 55 |
| Dundonald St / Church St | 38 | 39 |
| King St W / Bay St (West Side) | 36 | 39 |
| Humber Bay Shores Park / Marine Parade Dr | 36 | 63 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 149 |
| Full       | 34 |
| Available  | 749 |

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
- The mean availability is 31.7% with a standard deviation of 28.5%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
