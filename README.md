# 🚲 Toronto Bike Share Analytics

Updated: 2025-09-08 13:06 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,072 | +219 |
| **Total docks available** | 11,389 | -155 |
| **System utilization rate** | 34.8% | +1.1% |
| **Active stations** | 972/973 (99.9%) | +6 |
| **Average bikes per station** | 6.2 | +0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 183 (18.8%) | +49 |
| **Full stations** | 53 (5.4%) | +27 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 59 | 63 |
| York St / Queens Quay W | 52 | 57 |
| Wellington St W / Bay St | 51 | 55 |
| Bay St / Dundas St W | 49 | 55 |
| Simcoe St / Pullan Pl | 44 | 47 |
| Queens Quay / Yonge St | 41 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 37 | 47 |
| Bremner Blvd / Rees St | 33 | 49 |
| King St W / University Ave | 33 | 37 |
| Spadina Ave / Harbord St - SMART | 32 | 36 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| 144 Harrison St | 46 | 51 |
| 439 Sherbourne St | 45 | 47 |
| 95 Beecroft Rd | 41 | 47 |
| Berkeley St / Dundas St E - SMART | 40 | 40 |
| 91 Via Italia | 38 | 39 |
| Niagara St / Richmond St W | 37 | 42 |
| Hanlan's Point Ferry Dock | 37 | 39 |
| Fort York  Blvd / Capreol Ct | 36 | 47 |
| Toronto Inukshuk Park | 36 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 183 |
| Full       | 52 |
| Available  | 738 |

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
- The mean availability is 30.7% with a standard deviation of 30.2%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
