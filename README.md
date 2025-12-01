# 🚲 Toronto Bike Share Analytics

Updated: 2025-12-01 12:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,021 | +31 |
| **Total docks available** | 11,968 | -143 |
| **System utilization rate** | 33.5% | +0.4% |
| **Active stations** | 989/989 (100%) | +2 |
| **Average bikes per station** | 6.1 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 312 (31.5%) |  |
| **Full stations** | 57 (5.8%) | +13 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 64 | 79 |
| Bay St / Albert St | 61 | 63 |
| Humber Bay Shores Park / Marine Parade Dr | 55 | 63 |
| Bay St / Dundas St W | 54 | 55 |
| Wellington St W / Bay St | 53 | 55 |
| Temperance St Station | 52 | 55 |
| York St / Queens Quay W | 52 | 57 |
| Bremner Blvd / Rees St | 48 | 49 |
| Queens Quay / Yonge St | 46 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 45 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| 439 Sherbourne St | 44 | 47 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Queen St W / Ossington Ave | 41 | 43 |
| Brimley Rd / Lawrence Ave E  | 39 | 39 |
| Jarvis St / Isabella St | 37 | 39 |
| 9 Willingdon Blvd | 37 | 39 |
| Balliol St / Yonge St - SMART | 36 | 36 |
| Dundonald St / Church St | 35 | 39 |
| Yonge St / Orchard View Blvd | 35 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 312 |
| Full       | 56 |
| Available  | 621 |

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
- The mean availability is 28.9% with a standard deviation of 33.5%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
