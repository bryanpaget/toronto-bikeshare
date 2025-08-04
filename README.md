# 🚲 Toronto Bike Share Analytics

Updated: 2025-08-04 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,153 | +384 |
| **Total docks available** | 11,070 | +126 |
| **System utilization rate** | 35.7% | +1.2% |
| **Active stations** | 946/946 (100%) | +7 |
| **Average bikes per station** | 6.5 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 116 (12.3%) | -64 |
| **Full stations** | 25 (2.6%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Queens Quay / Yonge St | 46 | 47 |
| Niagara St / Richmond St W | 41 | 42 |
| 265 Armadale Ave | 36 | 44 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| Bremner Blvd / Rees St | 31 | 49 |
| Dundas St W / Yonge St | 30 | 31 |
| Yonge St / Dundas Sq | 30 | 31 |
| 16 Riverview Gardens  | 30 | 31 |
| Bay St / Albert St | 28 | 63 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 52 | 63 |
| Temperance St Station | 47 | 55 |
| Simcoe St / Pullan Pl | 46 | 47 |
| Hanlan's Point Beach | 44 | 47 |
| Frederick St / King St E | 42 | 47 |
| King St W / Bay St (West Side) | 36 | 39 |
| Bay St / Dundas St W | 36 | 55 |
| Bloor St W / Manning Ave - SMART | 34 | 42 |
| Bay St / Albert St | 33 | 63 |
| Wellington St W / Bay St | 33 | 55 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 116 |
| Full       | 25 |
| Available  | 805 |

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
- The mean availability is 32.6% with a standard deviation of 27.2%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
