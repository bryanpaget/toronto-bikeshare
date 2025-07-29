# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-29 13:12 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,769 | -49 |
| **Total docks available** | 10,944 | +67 |
| **System utilization rate** | 34.5% | -0.3% |
| **Active stations** | 939/939 (100%) | +3 |
| **Average bikes per station** | 6.1 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 180 (19.2%) | -2 |
| **Full stations** | 31 (3.3%) | -11 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 56 | 63 |
| Temperance St Station | 53 | 55 |
| Wellington St W / Bay St | 48 | 55 |
| York St / Queens Quay W | 47 | 57 |
| Bremner Blvd / Rees St | 41 | 49 |
| Queens Quay / Yonge St | 40 | 47 |
| Cherry Beach | 39 | 49 |
| Simcoe St / Queen St W | 34 | 39 |
| Bond St / Queen St E | 33 | 37 |
| 285 Victoria St | 33 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 52 | 63 |
| Dundas St W / Crawford St | 45 | 47 |
| Hanlan's Point Beach | 41 | 47 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Queen St W / Ossington Ave | 37 | 43 |
| Bloor St W / Manning Ave - SMART | 36 | 42 |
| Berkeley St / Dundas St E - SMART | 35 | 40 |
| 1 Shortt St | 35 | 38 |
| Lisgar Park | 34 | 35 |
| Brimley Rd / Lawrence Ave E  | 34 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 180 |
| Full       | 31 |
| Available  | 728 |

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
- The mean availability is 30.1% with a standard deviation of 29.4%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
