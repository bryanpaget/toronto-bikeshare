# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-08 16:09 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,023 | -92 |
| **Total docks available** | 10,721 | +126 |
| **System utilization rate** | 36% | -0.6% |
| **Active stations** | 924/924 (100%) | +1 |
| **Average bikes per station** | 6.5 | -0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 103 (11.1%) | -5 |
| **Full stations** | 18 (1.9%) | -2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 49 | 63 |
| York St / Queens Quay W | 49 | 57 |
| Temperance St Station | 48 | 55 |
| Wellington St W / Bay St | 46 | 55 |
| Queens Quay / Yonge St | 44 | 46 |
| Front St W / Yonge St (Hockey Hall of Fame) | 39 | 45 |
| Bremner Blvd / Rees St | 38 | 49 |
| Simcoe St / Queen St W | 35 | 39 |
| 3220 Bloor St W | 34 | 38 |
| Frederick St / King St E | 33 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 43 | 63 |
| Bloor St W / Manning Ave - SMART | 40 | 42 |
| Fort York  Blvd / Capreol Ct | 39 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Hanlan's Point Ferry Dock | 36 | 39 |
| 439 Sherbourne St | 34 | 47 |
| Lisgar Park | 32 | 35 |
| Dundas St W / Crawford St | 31 | 47 |
| Bloor St W / Shaw St - SMART | 31 | 34 |
| Lake Shore Blvd W / Ontario Dr | 31 | 35 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 103 |
| Full       | 18 |
| Available  | 803 |

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
- The mean availability is 32.1% with a standard deviation of 26.7%
- The system is currently operating at 36% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
