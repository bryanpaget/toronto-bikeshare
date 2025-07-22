# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-22 13:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,534 | -217 |
| **Total docks available** | 11,007 | +146 |
| **System utilization rate** | 33.5% | -1.2% |
| **Active stations** | 933/934 (99.9%) |  |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 174 (18.6%) | -5 |
| **Full stations** | 31 (3.3%) | +5 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 51 | 63 |
| Wellington St W / Bay St | 50 | 55 |
| York St / Queens Quay W | 50 | 57 |
| Temperance St Station | 44 | 55 |
| Bremner Blvd / Rees St | 41 | 49 |
| Simcoe St / Pullan Pl | 41 | 47 |
| Queens Quay / Yonge St | 37 | 46 |
| King St W / Bay St (West Side) | 36 | 39 |
| Simcoe St / Queen St W | 35 | 39 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 57 | 63 |
| Fort York  Blvd / Capreol Ct | 45 | 47 |
| Dundas St W / Crawford St | 45 | 47 |
| 144 Harrison St | 43 | 51 |
| Bloor St W / Manning Ave - SMART | 39 | 42 |
| Dundonald St / Church St | 38 | 39 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| 91 Via Italia | 35 | 39 |
| Berkeley St / Dundas St E - SMART | 35 | 40 |
| 439 Sherbourne St | 34 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 174 |
| Full       | 31 |
| Available  | 729 |

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
- The mean availability is 28.8% with a standard deviation of 28.3%
- The system is currently operating at 33% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
