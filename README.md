# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 06:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 7,052 | +44 |
| **Total docks available** | 9,647 | -19 |
| **System utilization rate** | 42.2% | +0.2% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 7.7 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 112 (12.2%) | -13 |
| **Full stations** | 47 (5.1%) | -19 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| 144 Harrison St | 41 | 51 |
| 265 Armadale Ave | 39 | 44 |
| 800 Fleet St (South) | 37 | 43 |
| Fort York  Blvd / Capreol Ct | 36 | 47 |
| 439 Sherbourne St | 36 | 47 |
| 800 Fleet St (North) | 35 | 43 |
| Lisgar Park | 34 | 35 |
| Berkeley St / Dundas St E - SMART | 33 | 40 |
| Centre Island Ferry Dock | 33 | 35 |
| Bloor St W / Manning Ave - SMART | 32 | 42 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 62 | 63 |
| Temperance St Station | 53 | 55 |
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| Bay St / Dundas St W | 53 | 55 |
| Simcoe St / Pullan Pl | 46 | 47 |
| Wellington St W / Bay St | 45 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 42 | 47 |
| Hanlan's Point Beach | 42 | 47 |
| York St / Queens Quay W | 39 | 57 |
| 285 Victoria St | 39 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 112 |
| Full       | 47 |
| Available  | 762 |

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
- The mean availability is 38.9% with a standard deviation of 30.6%
- The system is currently operating at 42% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
