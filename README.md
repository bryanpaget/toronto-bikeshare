# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-20 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 5,799 | +104 |
| **Total docks available** | 10,745 | -7 |
| **System utilization rate** | 35.1% | +0.4% |
| **Active stations** | 933/934 (99.9%) |  |
| **Average bikes per station** | 6.2 | +0 |
| **Median station capacity** | 19 | - |
| **Empty stations** | 144 (15.4%) | +3 |
| **Full stations** | 32 (3.4%) | +2 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Toronto Inukshuk Park | 45 | 47 |
| Queen St W / Ossington Ave | 40 | 43 |
| Bay St / Queens Quay W (Ferry Terminal) | 33 | 35 |
| 800 Fleet St (North) | 33 | 43 |
| Queens Quay / Yonge St | 32 | 46 |
| 1 Shortt St | 32 | 38 |
| 800 Fleet St (South) | 31 | 43 |
| 2700 Eglinton Ave W | 31 | 43 |
| Western Battery Rd / Pirandello St | 30 | 31 |
| Hanna Ave / Liberty St | 28 | 31 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 52 | 63 |
| Bay St / Dundas St W | 51 | 55 |
| Temperance St Station | 49 | 55 |
| Bay St / Albert St | 45 | 63 |
| Simcoe St / Pullan Pl | 44 | 47 |
| Fort York  Blvd / Capreol Ct | 42 | 47 |
| Front St W / Yonge St (Hockey Hall of Fame) | 42 | 47 |
| York St / Queens Quay W | 39 | 57 |
| Bond St / Queen St E | 37 | 37 |
| Frederick St / King St E | 37 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 144 |
| Full       | 32 |
| Available  | 758 |

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
- The mean availability is 31.2% with a standard deviation of 27.1%
- The system is currently operating at 35% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
