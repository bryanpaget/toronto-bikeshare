# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 08:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,364 | -562 |
| **Total docks available** | 10,366 | +568 |
| **System utilization rate** | 38% | -3.4% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 6.9 | -1 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 111 (12.1%) | +19 |
| **Full stations** | 19 (2.1%) | -15 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| 265 Armadale Ave | 36 | 44 |
| 144 Harrison St | 33 | 51 |
| 439 Sherbourne St | 33 | 47 |
| Centre Island Ferry Dock | 33 | 35 |
| Bremner Blvd / Rees St | 31 | 49 |
| Niagara St / Richmond St W | 31 | 42 |
| Berkeley St / Dundas St E - SMART | 31 | 40 |
| 800 Fleet St (North) | 31 | 43 |
| Bathurst St/Queens Quay(Billy Bishop Airport) | 30 | 34 |
| Bond St / Queen St E | 29 | 37 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 55 | 63 |
| Bay St / Dundas St W | 53 | 55 |
| Temperance St Station | 51 | 55 |
| Bay St / Albert St | 49 | 63 |
| York St / Queens Quay W | 49 | 57 |
| Simcoe St / Pullan Pl | 42 | 47 |
| Hanlan's Point Beach | 41 | 47 |
| Wellington St W / Bay St | 38 | 55 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Simcoe St / Queen St W | 35 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 111 |
| Full       | 19 |
| Available  | 791 |

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
- The mean availability is 34.5% with a standard deviation of 27.3%
- The system is currently operating at 38% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
