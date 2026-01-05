# 🚲 Toronto Bike Share Analytics

Updated: 2026-01-05 12:10 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,242 | +88 |
| **Total docks available** | 12,175 | -21 |
| **System utilization rate** | 33.9% | +0.4% |
| **Active stations** | 1004/1004 (100%) | +3 |
| **Average bikes per station** | 6.2 | +0 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 120 (12%) | -36 |
| **Full stations** | 31 (3.1%) | -7 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 53 | 63 |
| Front St W / Yonge St (Hockey Hall of Fame) | 43 | 47 |
| Bay St / Dundas St W | 40 | 55 |
| 285 Victoria St | 38 | 39 |
| Wellington St W / Bay St | 37 | 55 |
| Toronto Inukshuk Park | 37 | 47 |
| Bond St / Queen St E | 36 | 37 |
| Bremner Blvd / Rees St | 33 | 49 |
| King St E / Church St | 30 | 35 |
| Frederick St / King St E | 30 | 47 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Simcoe St / Pullan Pl | 62 | 79 |
| Humber Bay Shores Park / Marine Parade Dr | 51 | 63 |
| 144 Harrison St | 48 | 51 |
| Niagara St / Richmond St W | 41 | 42 |
| York St / Queens Quay W | 41 | 57 |
| Dundas St W / Crawford St | 40 | 47 |
| 2700 Eglinton Ave W | 40 | 43 |
| 91 Via Italia | 37 | 39 |
| Brimley Rd / Lawrence Ave E  | 37 | 39 |
| 9 Willingdon Blvd | 37 | 39 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 120 |
| Full       | 28 |
| Available  | 856 |

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
- The mean availability is 31.6% with a standard deviation of 28.5%
- The system is currently operating at 34% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
