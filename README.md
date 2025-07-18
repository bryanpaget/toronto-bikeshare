# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-18 13:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,908 | -51 |
| **Total docks available** | 10,476 | +12 |
| **System utilization rate** | 36.1% | -0.2% |
| **Active stations** | 933/934 (99.9%) | +1 |
| **Average bikes per station** | 6.3 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 153 (16.4%) | -10 |
| **Full stations** | 33 (3.5%) | +4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Temperance St Station | 47 | 55 |
| Cherry Beach | 44 | 49 |
| King St W / Bay St (West Side) | 36 | 39 |
| Dundas St W / Crawford St | 36 | 47 |
| 800 Fleet St (South) | 34 | 43 |
| 3220 Bloor St W | 31 | 38 |
| 1 Shortt St | 31 | 38 |
| Bay St / Queens Quay W (Ferry Terminal) | 30 | 35 |
| Hanna Ave / Liberty St | 29 | 31 |
| Queens Quay / Yonge St | 29 | 46 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Bay St / Dundas St W | 41 | 55 |
| 144 Harrison St | 40 | 51 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| 2700 Eglinton Ave W | 39 | 43 |
| Bremner Blvd / Rees St | 37 | 49 |
| Dundonald St / Church St | 36 | 39 |
| Bay St / Albert St | 34 | 63 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 153 |
| Full       | 33 |
| Available  | 748 |

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
- The mean availability is 31.7% with a standard deviation of 27.9%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
