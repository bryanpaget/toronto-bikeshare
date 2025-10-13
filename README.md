# 🚲 Toronto Bike Share Analytics

Updated: 2025-10-13 13:08 (Toronto Time)

## 📊 System Overview
| Metric | Value | Change |
|--------|-------|--------|
| **Total bikes available** | 7,009 | +1,307 |
| **Total docks available** | 10,898 | -786 |
| **System utilization rate** | 39.1% | +6.3% |
| **Active stations** | 989/989 (100%) | -1 |
| **Average bikes per station** | 7.1 | +1 |
| **Median station capacity** | 17 | - |
| **Empty stations** | 154 (15.6%) | -94 |
| **Full stations** | 53 (5.4%) | +13 |

## 🏆 Top 10 Stations by Bike Availability
| Station | Bikes Available | Capacity |
|---------|-----------------|----------|
| Humber Bay Shores Park / Marine Parade Dr | 61 | 63 |
| Temperance St Station | 53 | 55 |
| York St / Queens Quay W | 48 | 57 |
| Wellington St W / Bay St | 44 | 55 |
| Bay St / Dundas St W | 44 | 55 |
| Queen St W / Ossington Ave | 43 | 43 |
| Queens Quay / Yonge St | 41 | 47 |
| Dundas St W / Crawford St | 41 | 47 |
| Niagara St / Richmond St W | 38 | 42 |
| 265 Armadale Ave | 36 | 44 |

## 🏆 Top 10 Stations by Dock Availability
| Station | Docks Available | Capacity |
|---------|-----------------|----------|
| Bay St / Albert St | 43 | 63 |
| Fort York  Blvd / Capreol Ct | 42 | 47 |
| Simcoe St / Pullan Pl | 42 | 47 |
| Brimley Rd / Lawrence Ave E  | 36 | 39 |
| Bloor St W / Manning Ave - SMART | 35 | 42 |
| Berkeley St / Dundas St E - SMART | 35 | 40 |
| Bremner Blvd / Rees St | 34 | 49 |
| Dundonald St / Church St | 34 | 38 |
| Hanlan's Point Beach | 31 | 47 |
| Toronto Inukshuk Park | 30 | 47 |

## 📊 Station Status Distribution
| Status     | Number of Stations |
|------------|-------------------:|
| Empty      | 154 |
| Full       | 52 |
| Available  | 783 |

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
- The mean availability is 34.9% with a standard deviation of 31.4%
- The system is currently operating at 39% capacity

## ℹ️ Data Source
Data is sourced from the [Toronto Bike Share GBFS API](https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status)
