# 🚲 Toronto Bike Share Analytics

Updated: 2025-08-25 13:04 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,935 | -235 |
| **Total docks available** | 11,152 | +154 |
| **System utilization rate** | 34.7% | -1.2% |
| **Active stations** | 961/961 (100%) | +8 |
| **Average bikes per station** | 6.2 | -0 |
| **Median station capacity** | 18 | - |
| **Empty stations** | 172 (17.9%) | +23 |
| **Full stations** | 33 (3.4%) | -5 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Temperance St Station | 54 | 55 |
| Bay St / Albert St | 48 | 63 |
| Bremner Blvd / Rees St | 45 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 41 | 47 |
| Toronto Inukshuk Park | 40 | 47 |
| Queens Quay / Yonge St | 34 | 47 |
| 2700 Eglinton Ave W | 33 | 43 |
| St. George St / Willcocks St | 33 | 35 |
| Wellington St W / Bay St | 32 | 55 |
| York St / Queens Quay W | 32 | 57 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 63 | 63 |
| Hanlan's Point Beach | 47 | 47 |
| Fort York  Blvd / Capreol Ct | 44 | 47 |
| Dundas St W / Crawford St | 42 | 47 |
| Niagara St / Richmond St W | 41 | 42 |
| Hanlan's Point Ferry Dock | 39 | 39 |
| Bloor St W / Manning Ave - SMART | 36 | 42 |
| Gibraltar Point Beach | 35 | 35 |
| Bathurst St / Front St W | 33 | 35 |
| Dundonald St / Church St | 31 | 38 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 172 |
| Full       | 32 |
| Available  | 757 |

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
- The mean availability is 30.7% with a standard deviation of 28.5%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
