# Delivery Performance and Delay Analysis

## Project Overview

This project analyzes 25,000 delivery records to identify factors associated with delivery delays and explore operational opportunities that could improve on-time delivery performance.

The analysis was completed using Excel for data cleaning and exploratory analysis, SQL Server for querying and business analysis, and Tableau for data visualization.

## Business Question

**What factors are associated with delivery delays, and what operational improvements could potentially improve on-time delivery?**

### Supporting Questions

- How does weather condition relate to delivery delays?
- Are longer-distance deliveries more likely to be delayed?
- Does vehicle type affect delay rates?
- Do delay rates differ by region?
- Does package type affect delivery performance?
- Are delayed deliveries associated with lower customer ratings?
- Which combinations of weather and distance have the highest delay rates?

---

## Tools Used

- **Excel** — data cleaning, validation, exploratory analysis, and PivotTables
- **SQL Server / SSMS** — querying and business analysis
- **Tableau Public** — dashboard development and visualization
- **GitHub** — project documentation and version control

---

## Data Preparation

Before analysis, the dataset was reviewed for data-quality issues.

### Cleaning Steps

- Reviewed the dataset for missing values and inconsistent categorical values.
- Identified repeated `delivery_id` values. Because the corresponding records were not duplicate rows, the records were retained.
- Created a new `record_id` field to provide a unique identifier for each record.
- Converted incorrectly encoded delivery-time fields into usable numeric hour values:
  - `delivery_time_hours_clean`
  - `expected_time_hours_clean`
- Created a `distance_group` field to compare delay rates across delivery-distance ranges.
- Identified 255 records with a cleaned delivery time of 0 hours. These records were retained for general delay analysis but excluded from calculations comparing actual and expected delivery times.

---

## Exploratory Analysis

Initial analysis was performed in Excel using PivotTables to identify patterns worth investigating further in SQL.

The primary measures included:

- Overall delay rate
- Delay rate by weather
- Delay rate by distance
- Delay rate by vehicle type
- Delay rate by region
- Delay rate by package type
- Average customer rating by delay status

---

## SQL Analysis

SQL was used to reproduce and expand the exploratory analysis.

The analysis included:

- Overall delivery delay rate
- Delay rate by weather condition
- Delay rate by distance group
- Delay rate by vehicle type
- Delay rate by region
- Delay rate by package type
- Average customer rating by delay status
- Combined weather and distance risk
- Actual vs. expected delivery time

The SQL queries are available in the [`sql`](./sql/) folder.

---

## Key Findings

### 1. Overall Delay Rate

**26.68%** of deliveries were delayed.

### 2. Weather Was Strongly Associated With Delays

Adverse weather conditions had substantially higher delay rates:

| Weather Condition | Delay Rate |
|---|---:|
| Stormy | 41.45% |
| Rainy | 37.35% |
| Foggy | 30.32% |
| Clear | 17.43% |
| Hot | 17.12% |
| Cold | 16.02% |

Stormy deliveries experienced more than twice the delay rate of deliveries under cold, clear, or hot conditions.

### 3. Delay Rate Increased With Distance

Longer delivery distances were associated with progressively higher delay rates:

| Distance | Delay Rate |
|---|---:|
| 0–49 km | 17.01% |
| 50–99 km | 19.11% |
| 100–149 km | 23.95% |
| 150–199 km | 28.04% |
| 200–249 km | 33.01% |
| 250+ km | 38.79% |

Deliveries traveling 250 km or more had more than twice the delay rate of deliveries under 50 km.

### 4. Weather and Distance Combined Created the Highest Risk

The highest delay rates occurred when long delivery distances were combined with adverse weather.

Examples include:

- **Stormy + 250+ km:** 57.04%
- **Rainy + 250+ km:** 48.41%
- **Stormy + 200–249 km:** 47.80%
- **Rainy + 200–249 km:** 47.11%
- **Foggy + 250+ km:** 44.40%

This indicates that long-distance deliveries during poor weather represent particularly high-risk operating conditions.

### 5. Delays Were Associated With Lower Customer Ratings

Average customer ratings differed substantially by delay status:

- **Non-delayed deliveries:** 4.21
- **Delayed deliveries:** 2.18

This suggests that improving on-time delivery performance could also help improve customer satisfaction.

### 6. Vehicle, Region, and Package Type Showed Limited Variation

Vehicle type, geographic region, and package type had relatively similar delay rates across categories.

This suggests these factors were less strongly associated with delays than weather and delivery distance in this dataset.

---

## Operational Recommendations

Based on the analysis, potential operational improvements include:

1. **Use weather-aware delivery planning.**  
   Allow additional delivery-time buffers during stormy, rainy, and foggy conditions.

2. **Apply larger time buffers to long-distance deliveries.**  
   Delivery expectations for routes above 150–200 km could account for their higher observed delay rates.

3. **Prioritize high-risk weather and distance combinations.**  
   Long-distance deliveries during adverse weather may benefit from earlier dispatch, alternate routes, or additional operational capacity.

4. **Use delay risk to support customer communication.**  
   Because delayed deliveries were associated with substantially lower ratings, proactive delay notifications and more realistic delivery estimates may help improve the customer experience.

5. **Focus improvement efforts on the strongest observed factors.**  
   Vehicle type, region, and package type showed comparatively small differences, while weather and distance showed much stronger relationships with delay rates.

---

## Tableau Dashboard

The Tableau dashboard summarizes the primary findings of the analysis.

**Dashboard includes:**

- Overall Delay Rate
- Delay Rate by Weather
- Delay Rate by Distance
- Average Customer Rating by Delay Status
- Weather and Distance Delay Risk

**Tableau Public:**  
[View Interactive Dashboard](https://public.tableau.com/app/profile/quay.robinson/viz/DeliveryPerformanceandDelayAnalysis/DeliveryPerformanceandDelayAnalysis)

---

## Project Limitations

- The analysis identifies **associations**, not causal relationships.
- 255 records contained a cleaned delivery time of 0 hours and were excluded from actual-versus-expected delivery-time calculations.
- Repeated `delivery_id` values were found, although the corresponding records were not complete duplicates.
- Additional variables not included in the dataset may also influence delivery delays.

---

## Repository Structure

```text
logistics-delivery-analysis/
│
├── README.md
│
├── data/
│   └── delivery_logistics_cleaned.csv
│
├── excel/
│   └── delivery_logistics_analysis.xlsx
│
├── sql/
│   └── 01_delay_analysis.sql
│
├── tableau/
│   └── dashboard.png
│
└── documentation/
    ├── data_dictionary.md
    └── data_quality_notes.md
