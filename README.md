# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-16 13:12 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,800 | -38 |
| **Total docks available** | 10,746 | -9 |
| **System utilization rate** | 35.1% | -0.1% |
| **Active stations** | 929/930 (99.9%) | +2 |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 160 (17.2%) |  |
| **Full stations** | 33 (3.5%) |  |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 50 | 55 |
| Bay St / Albert St | 49 | 63 |
| York St / Queens Quay W | 49 | 57 |
| Queens Quay / Yonge St | 41 | 46 |
| Bremner Blvd / Rees St | 38 | 49 |
| Temperance St Station | 38 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 38 | 47 |
| King St W / Bay St (West Side) | 37 | 39 |
| Simcoe St / Queen St W | 34 | 39 |
| 2700 Eglinton Ave W | 34 | 43 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 56 | 63 |
| Hanlan's Point Beach | 45 | 47 |
| Fort York  Blvd / Capreol Ct | 43 | 47 |
| 439 Sherbourne St | 43 | 47 |
| Dundas St W / Crawford St | 40 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Toronto Inukshuk Park | 38 | 47 |
| Berkeley St / Dundas St E - SMART | 36 | 40 |
| Hanlan's Point Ferry Dock | 36 | 39 |
| Niagara St / Richmond St W | 34 | 42 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 160 |
| Full       | 33 |
| Available  | 737 |

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
- The mean availability is 30.6% with a standard deviation of 28.5%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
