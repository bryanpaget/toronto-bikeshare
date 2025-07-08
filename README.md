# 🚨 Error in Bike Share Dashboard

Updated: 2025-07-07 23:03 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 6,391 | N/A |
| **Total docks available** | 10,021 | N/A |
| **System utilization rate** | 38.9% | N/A |
| **Active stations** | 922/922 (100%) | N/A |
| **Average bikes per station** | 6.9 | N/A |
| **Median station capacity** | 19 | - |
| **Empty stations** | 128 (13.9%) | N/A |
| **Full stations** | 65 (7%) | N/A |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Frederick St / King St E | 44 | 47 |
| 144 Harrison St | 39 | 51 |
| Fort York  Blvd / Capreol Ct | 35 | 47 |
| Berkeley St / Dundas St E - SMART | 34 | 40 |
| 439 Sherbourne St | 34 | 47 |
| Lisgar Park | 33 | 35 |
| 2700 Eglinton Ave W | 33 | 43 |
| Centre Island Ferry Dock | 33 | 35 |
| Bathurst St / Front St W | 32 | 35 |
| Hanna Ave / Liberty St | 29 | 32 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 61 | 63 |
| Temperance St Station | 52 | 55 |
| Bay St / Dundas St W | 52 | 55 |
| Wellington St W / Bay St | 51 | 55 |
| Simcoe St / Pullan Pl | 43 | 47 |
| Bloor St W / Manning Ave - SMART | 42 | 42 |
| Hanlan's Point Beach | 42 | 47 |
| 285 Victoria St | 39 | 39 |
| York St / Queens Quay W | 38 | 57 |
| 800 Fleet St (North) | 38 | 43 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 128 |
| Full       | 65 |
| Available  | 729 |

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
- The mean availability is 35.9% with a standard deviation of 30.4%
- The system is currently operating at 39% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
