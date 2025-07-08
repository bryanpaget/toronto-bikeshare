# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 12:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,023 | -44 |
| **Total docks available** | 10,663 | +22 |
| **System utilization rate** | 36.1% | -0.2% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 6.5 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 166 (18%) | +4 |
| **Full stations** | 34 (3.7%) | -15 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 52 | 57 |
| Wellington St W / Bay St | 46 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 45 | 47 |
| Bremner Blvd / Rees St | 42 | 49 |
| Queens Quay / Yonge St | 41 | 46 |
| Bay St / Albert St | 39 | 63 |
| King St W / University Ave | 38 | 38 |
| 265 Armadale Ave | 36 | 44 |
| Frederick St / King St E | 35 | 47 |
| Simcoe St / Queen St W | 34 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 439 Sherbourne St | 46 | 47 |
| Hanlan's Point Beach | 43 | 47 |
| Dundas St W / Crawford St | 40 | 47 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Church St / Alexander St | 34 | 35 |
| Bloor St W / Shaw St - SMART | 34 | 34 |
| Cherry Beach | 33 | 49 |
| Temperance St Station | 32 | 55 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 166 |
| Full       | 34 |
| Available  | 721 |

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
- The mean availability is 32.2% with a standard deviation of 29.4%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
