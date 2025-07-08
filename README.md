# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 07:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,926 | -126 |
| **Total docks available** | 9,798 | +151 |
| **System utilization rate** | 41.4% | -0.8% |
| **Active stations** | 921/921 (100%) |  |
| **Average bikes per station** | 7.5 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 92 (10%) | -20 |
| **Full stations** | 34 (3.7%) | -13 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| 265 Armadale Ave | 39 | 44 |
| 439 Sherbourne St | 37 | 47 |
| 144 Harrison St | 36 | 51 |
| 800 Fleet St (North) | 35 | 43 |
| Lisgar Park | 33 | 35 |
| Centre Island Ferry Dock | 33 | 35 |
| Fort York  Blvd / Capreol Ct | 32 | 47 |
| Bloor St W / Manning Ave - SMART | 32 | 42 |
| Berkeley St / Dundas St E - SMART | 32 | 40 |
| Niagara St / Richmond St W | 31 | 42 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 58 | 63 |
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| Temperance St Station | 52 | 55 |
| Bay St / Dundas St W | 51 | 55 |
| Simcoe St / Pullan Pl | 46 | 47 |
| Hanlan's Point Beach | 42 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 39 | 47 |
| York St / Queens Quay W | 38 | 57 |
| King St W / Bay St (West Side) | 37 | 38 |
| 285 Victoria St | 37 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 92 |
| Full       | 34 |
| Available  | 795 |

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
- The mean availability is 37.9% with a standard deviation of 29%
- The system is currently operating at 41% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
