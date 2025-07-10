# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-10 13:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,053 | -3 |
| **Total docks available** | 10,572 | -137 |
| **System utilization rate** | 36.4% | +0.3% |
| **Active stations** | 925/925 (100%) | -1 |
| **Average bikes per station** | 6.5 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 147 (15.9%) | +2 |
| **Full stations** | 27 (2.9%) | +4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Wellington St W / Bay St | 47 | 55 |
| Cherry Beach | 46 | 48 |
| Temperance St Station | 44 | 55 |
| Queens Quay / Yonge St | 40 | 46 |
| King St W / Bay St (West Side) | 35 | 38 |
| 2700 Eglinton Ave W | 35 | 43 |
| Front St W / Yonge St (Hockey Hall of Fame) | 34 | 45 |
| King St W / University Ave | 34 | 38 |
| Bay St / Queens Quay W (Ferry Terminal) | 32 | 35 |
| Bond St / Queen St E | 32 | 37 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 59 | 63 |
| 439 Sherbourne St | 47 | 47 |
| Bay St / Dundas St W | 45 | 55 |
| Fort York  Blvd / Capreol Ct | 43 | 47 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |
| Hanlan's Point Ferry Dock | 37 | 39 |
| Bay St / Albert St | 36 | 63 |
| Dundas St W / Crawford St | 36 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Lisgar Park | 33 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 147 |
| Full       | 27 |
| Available  | 751 |

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
- The mean availability is 32.2% with a standard deviation of 28.9%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
