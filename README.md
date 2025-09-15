# 🚲 Toronto Bike Share Analytics

Updated: 2025-09-15 13:07 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,850 | -222 |
| **Total docks available** | 11,504 | +115 |
| **System utilization rate** | 33.7% | -1.1% |
| **Active stations** | 975/975 (100%) | +3 |
| **Average bikes per station** | 6 | -0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 198 (20.3%) | +15 |
| **Full stations** | 47 (4.8%) | -6 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 62 | 63 |
| Temperance St Station | 49 | 55 |
| Wellington St W / Bay St | 49 | 55 |
| Bremner Blvd / Rees St | 45 | 49 |
| Bay St / Dundas St W | 44 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 42 | 47 |
| Cherry Beach | 42 | 48 |
| Simcoe St / Pullan Pl | 42 | 47 |
| York St / Queens Quay W | 41 | 57 |
| Queens Quay / Yonge St | 40 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 54 | 63 |
| 439 Sherbourne St | 45 | 47 |
| Hanlan's Point Beach | 45 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Niagara St / Richmond St W | 39 | 42 |
| Dundas St W / Crawford St | 39 | 47 |
| 144 Harrison St | 34 | 51 |
| Berkeley St / Dundas St E - SMART | 34 | 40 |
| Gibraltar Point Beach | 34 | 35 |
| Fort York  Blvd / Capreol Ct | 33 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 198 |
| Full       | 47 |
| Available  | 730 |

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
- The mean availability is 29.4% with a standard deviation of 30.5%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
