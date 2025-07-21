# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-21 13:12 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,751 | -48 |
| **Total docks available** | 10,861 | +116 |
| **System utilization rate** | 34.6% | -0.4% |
| **Active stations** | 933/934 (99.9%) |  |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 179 (19.2%) | +35 |
| **Full stations** | 26 (2.8%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Temperance St Station | 51 | 55 |
| Wellington St W / Bay St | 49 | 55 |
| Bay St / Albert St | 46 | 63 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| 2700 Eglinton Ave W | 40 | 43 |
| King St W / Bay St (West Side) | 36 | 39 |
| Bay St / Queens Quay W (Ferry Terminal) | 34 | 35 |
| St. George St / Willcocks St | 33 | 35 |
| Bond St / Queen St E | 32 | 37 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 50 | 63 |
| Fort York  Blvd / Capreol Ct | 44 | 47 |
| Dundas St W / Crawford St | 44 | 47 |
| Toronto Inukshuk Park | 42 | 47 |
| Cherry Beach | 41 | 49 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |
| Dundonald St / Church St | 38 | 39 |
| 91 Via Italia | 37 | 39 |
| Hanlan's Point Beach | 37 | 47 |
| 439 Sherbourne St | 36 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 179 |
| Full       | 26 |
| Available  | 729 |

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
- The mean availability is 30.2% with a standard deviation of 28.5%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
