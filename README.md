# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-13 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,393 | +486 |
| **Total docks available** | 10,215 | -529 |
| **System utilization rate** | 38.5% | +3.0% |
| **Active stations** | 925/925 (100%) | -1 |
| **Average bikes per station** | 6.9 | +1 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 107 (11.6%) | -11 |
| **Full stations** | 24 (2.6%) | -4 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| 2700 Eglinton Ave W | 33 | 43 |
| Queens Quay / Yonge St | 32 | 46 |
| 144 Harrison St | 32 | 51 |
| Cherry Beach Sports Fields (55 Unwin Ave) | 30 | 31 |
| 800 Fleet St (South) | 30 | 43 |
| Fort York  Blvd / Capreol Ct | 29 | 47 |
| Bloor St W / Manning Ave - SMART | 29 | 42 |
| 16 Riverview Gardens  | 29 | 31 |
| St. George St / Willcocks St | 28 | 35 |
| King St E / Berkeley St | 27 | 31 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 54 | 63 |
| Temperance St Station | 49 | 55 |
| Bay St / Albert St | 47 | 63 |
| Simcoe St / Pullan Pl | 47 | 47 |
| Bay St / Dundas St W | 46 | 55 |
| Frederick St / King St E | 43 | 47 |
| Brimley Rd / Lawrence Ave E  | 38 | 39 |
| York St / Queens Quay W | 37 | 57 |
| King St W / University Ave | 37 | 38 |
| Simcoe St / Queen St W | 36 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 107 |
| Full       | 24 |
| Available  | 794 |

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
- The mean availability is 34.8% with a standard deviation of 27.1%
- The system is currently operating at 38% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
