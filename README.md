# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-23 13:11 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,523 | -11 |
| **Total docks available** | 10,961 | -46 |
| **System utilization rate** | 33.5% | +0.0% |
| **Active stations** | 933/933 (100%) |  |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 171 (18.3%) | -3 |
| **Full stations** | 38 (4.1%) | +7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 48 | 55 |
| York St / Queens Quay W | 48 | 57 |
| Temperance St Station | 45 | 55 |
| Queens Quay / Yonge St | 43 | 47 |
| Bay St / Albert St | 40 | 63 |
| King St W / Bay St (West Side) | 38 | 39 |
| Bremner Blvd / Rees St | 37 | 49 |
| 2700 Eglinton Ave W | 35 | 43 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |
| Simcoe St / Queen St W | 32 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Dundas St W / Crawford St | 45 | 47 |
| 144 Harrison St | 45 | 51 |
| 439 Sherbourne St | 45 | 47 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Frederick St / King St E | 41 | 47 |
| Hanlan's Point Beach | 40 | 47 |
| Queen St W / Ossington Ave | 37 | 43 |
| 800 Fleet St (South) | 36 | 43 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Humber Bay Shores Park / Marine Parade Dr | 34 | 63 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 171 |
| Full       | 38 |
| Available  | 724 |

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
- The mean availability is 29.2% with a standard deviation of 28.1%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
