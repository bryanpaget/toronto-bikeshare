# 🚲 Toronto Bike Share Analytics

Updated: 2025-07-07 20:36 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,062 | N/A |
| **Total docks available** | 10,354 | N/A |
| **System utilization rate** | 36.9% | N/A |
| **Active stations** | 922/922 (100%) | N/A |
| **Average bikes per station** | 6.6 | N/A |
| **Median station capacity** | 19 | - |
| **Empty stations** | 123 (13.3%) | N/A |
| **Full stations** | 58 (6.3%) | N/A |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Frederick St / King St E | 42 | 47 |
| 144 Harrison St | 40 | 51 |
| Hanlan's Point Ferry Dock | 36 | 39 |
| 2700 Eglinton Ave W | 33 | 43 |
| Hanna Ave / Liberty St | 29 | 32 |
| Temperance St Station | 28 | 55 |
| Front St W / Yonge St (Hockey Hall of Fame) | 28 | 47 |
| Bathurst St/Queens Quay(Billy Bishop Airport) | 28 | 34 |
| Western Battery Rd / Pirandello St | 28 | 29 |
| Simcoe St / Queen St W | 27 | 39 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 53 | 63 |
| Wellington St W / Bay St | 51 | 55 |
| Bay St / Dundas St W | 50 | 55 |
| Simcoe St / Pullan Pl | 45 | 47 |
| York St / Queens Quay W | 44 | 57 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Fort York  Blvd / Capreol Ct | 41 | 47 |
| Queens Quay / Yonge St | 40 | 46 |
| Humber Bay Shores Park / Marine Parade Dr | 40 | 63 |
| 439 Sherbourne St | 39 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 123 |
| Full       | 58 |
| Available  | 741 |

## 📍 Bike Locations
![Bike Locations](docs/plots/location_plot.png)

## 📊 Station Status Distribution
![Status Distribution](docs/plots/status_distribution.png)

## 📈 Bike Availability Distribution
![Availability Distribution](docs/plots/availability_dist.png)

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
- The mean availability is 34% with a standard deviation of 29%
- The system is currently operating at 37% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
