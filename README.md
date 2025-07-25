# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-25 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,834 | +317 |
| **Total docks available** | 10,658 | -235 |
| **System utilization rate** | 35.4% | +1.8% |
| **Active stations** | 933/933 (100%) | -1 |
| **Average bikes per station** | 6.3 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 152 (16.3%) | -48 |
| **Full stations** | 30 (3.2%) |  |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Cherry Beach | 48 | 49 |
| Temperance St Station | 35 | 55 |
| Niagara St / Richmond St W | 33 | 42 |
| Front St W / Yonge St (Hockey Hall of Fame) | 32 | 47 |
| Frederick St / King St E | 31 | 47 |
| St. George St / Willcocks St | 31 | 35 |
| Wellington St W / Bay St | 30 | 55 |
| Tommy Thompson Park (Leslie Street Spit) | 28 | 31 |
| King St E / Berkeley St | 28 | 31 |
| 16 Riverview Gardens  | 28 | 31 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 46 | 63 |
| Bay St / Dundas St W | 46 | 55 |
| 439 Sherbourne St | 45 | 47 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Bay St / Albert St | 39 | 63 |
| Simcoe St / Pullan Pl | 39 | 47 |
| Fort York  Blvd / Capreol Ct | 38 | 47 |
| Dundas St W / Crawford St | 37 | 47 |
| 800 Fleet St (South) | 36 | 43 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 152 |
| Full       | 30 |
| Available  | 751 |

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
- The mean availability is 31.1% with a standard deviation of 28%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
