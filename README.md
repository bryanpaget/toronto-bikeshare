# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 18:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,852 | +135 |
| **Total docks available** | 10,791 | -186 |
| **System utilization rate** | 35.2% | +0.9% |
| **Active stations** | 924/924 (100%) |  |
| **Average bikes per station** | 6.3 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 138 (14.9%) | +25 |
| **Full stations** | 40 (4.3%) | +30 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Niagara St / Richmond St W | 36 | 42 |
| Dundas St W / Crawford St | 34 | 47 |
| 800 Fleet St (North) | 33 | 43 |
| Temperance St Station | 32 | 55 |
| 800 Fleet St (South) | 32 | 43 |
| 3220 Bloor St W | 32 | 38 |
| Bathurst St/Queens Quay(Billy Bishop Airport) | 30 | 34 |
| Queens Quay / Yonge St | 28 | 46 |
| 265 Armadale Ave | 28 | 44 |
| Martin Goodman Trail (Marilyn Bell Park) | 27 | 31 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 52 | 57 |
| Wellington St W / Bay St | 51 | 55 |
| Bay St / Albert St | 47 | 63 |
| Bay St / Dundas St W | 44 | 55 |
| Simcoe St / Pullan Pl | 44 | 47 |
| Humber Bay Shores Park / Marine Parade Dr | 43 | 63 |
| Hanlan's Point Beach | 40 | 47 |
| Bloor St W / Manning Ave - SMART | 37 | 42 |
| Fort York  Blvd / Capreol Ct | 36 | 47 |
| Bond St / Queen St E | 36 | 37 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 138 |
| Full       | 40 |
| Available  | 746 |

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
- The mean availability is 32.2% with a standard deviation of 28.3%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
