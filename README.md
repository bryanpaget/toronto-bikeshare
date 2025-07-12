# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-12 13:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,907 | -426 |
| **Total docks available** | 10,744 | +458 |
| **System utilization rate** | 35.5% | -2.6% |
| **Active stations** | 926/926 (100%) |  |
| **Average bikes per station** | 6.4 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 118 (12.7%) | +9 |
| **Full stations** | 28 (3%) | -1 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 50 | 57 |
| Queens Quay / Yonge St | 40 | 46 |
| Queen St W / Ossington Ave | 38 | 43 |
| Niagara St / Richmond St W | 32 | 42 |
| Front St W / Yonge St (Hockey Hall of Fame) | 30 | 45 |
| Hanlan's Point Beach | 30 | 47 |
| Bay St / Queens Quay W (Ferry Terminal) | 29 | 35 |
| 144 Harrison St | 29 | 51 |
| Frederick St / King St E | 29 | 47 |
| Lisgar Park | 29 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 59 | 63 |
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| Temperance St Station | 47 | 55 |
| Simcoe St / Pullan Pl | 45 | 47 |
| Bay St / Dundas St W | 44 | 55 |
| Simcoe St / Queen St W | 38 | 39 |
| Wellington St W / Bay St | 38 | 55 |
| Toronto Inukshuk Park | 38 | 47 |
| King St W / University Ave | 38 | 38 |
| Brimley Rd / Lawrence Ave E  | 38 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 118 |
| Full       | 28 |
| Available  | 780 |

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
- The mean availability is 32.1% with a standard deviation of 27.8%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
