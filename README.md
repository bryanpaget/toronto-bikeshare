# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-11 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,333 | +280 |
| **Total docks available** | 10,286 | -286 |
| **System utilization rate** | 38.1% | +1.7% |
| **Active stations** | 926/926 (100%) | +1 |
| **Average bikes per station** | 6.8 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 109 (11.8%) | -38 |
| **Full stations** | 29 (3.1%) | +2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Frederick St / King St E | 43 | 47 |
| Queen St W / Ossington Ave | 42 | 43 |
| Temperance St Station | 41 | 55 |
| Cherry Beach | 38 | 48 |
| 800 Fleet St (South) | 35 | 43 |
| Bremner Blvd / Rees St | 34 | 49 |
| King St W / University Ave | 34 | 38 |
| Bay St / Albert St | 33 | 63 |
| 265 Armadale Ave | 32 | 44 |
| St. George St / Willcocks St | 31 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 53 | 63 |
| Bay St / Dundas St W | 53 | 55 |
| 439 Sherbourne St | 47 | 47 |
| Fort York  Blvd / Capreol Ct | 42 | 47 |
| Bloor St W / Manning Ave - SMART | 41 | 42 |
| Simcoe St / Pullan Pl | 41 | 47 |
| Brimley Rd / Lawrence Ave E  | 35 | 39 |
| York St / Queens Quay W | 33 | 57 |
| Spadina Ave / Sussex Ave  | 31 | 35 |
| Howard St / Sherbourne St | 30 | 31 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 109 |
| Full       | 29 |
| Available  | 788 |

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
- The mean availability is 34% with a standard deviation of 28.3%
- The system is currently operating at 38% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
