# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-24 13:12 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,517 | -6 |
| **Total docks available** | 10,893 | -68 |
| **System utilization rate** | 33.6% | +0.1% |
| **Active stations** | 934/934 (100%) | +1 |
| **Average bikes per station** | 5.9 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 200 (21.4%) | +29 |
| **Full stations** | 30 (3.2%) | -8 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| York St / Queens Quay W | 53 | 57 |
| Wellington St W / Bay St | 52 | 55 |
| Bay St / Albert St | 50 | 63 |
| Bremner Blvd / Rees St | 45 | 49 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| Queens Quay / Yonge St | 42 | 47 |
| Temperance St Station | 41 | 55 |
| Cherry Beach | 38 | 49 |
| King St W / Bay St (West Side) | 33 | 39 |
| Simcoe St / Queen St W | 33 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Hanlan's Point Beach | 44 | 47 |
| Fort York  Blvd / Capreol Ct | 43 | 47 |
| Dundas St W / Crawford St | 43 | 47 |
| 439 Sherbourne St | 43 | 47 |
| Humber Bay Shores Park / Marine Parade Dr | 41 | 63 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Toronto Inukshuk Park | 40 | 47 |
| Berkeley St / Dundas St E - SMART | 37 | 40 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Dundonald St / Church St | 35 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 200 |
| Full       | 30 |
| Available  | 704 |

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
- The mean availability is 28.9% with a standard deviation of 28.8%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
