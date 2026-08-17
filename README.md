# Motor-Vehicle-Collision-Analysis
An analytical study of motor vehicle collisions in New York City aimed at understanding crash severity, fatal risk, vulnerable road users, and geographic disparities, with the goal of identifying data-driven opportunities to reduce fatalities and serious injuries.

[Data Source](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/about_data)

The SQL queries used to inspect and perform quality checks: [here](https://github.com/walktyler/Motor-Vehicle-Collision-Analysis/blob/main/mvc%20cleaning.sql)

The SQL queries used to clean, organize and prepare data: [here](https://github.com/walktyler/Motor-Vehicle-Collision-Analysis/blob/main/mvc_fact_table.sql)

Targeted SQL queries regarding various business questions can be found: [here](https://github.com/walktyler/Motor-Vehicle-Collision-Analysis/blob/main/MVC_queries.sql)

# Project Background
The Motor Vehicle Collisions dataset contains detailed records of police-reported motor vehicle crashes in New York City, where each row represents a single collision event.

Insights and recommendations are structured around the following analytical themes:
1) ### Fatalities & Crash Severity:
    - Evaluation of long term trends in Fatal Collision Rate (FCR).
    - An analysis of Average Injuries per Collision to assess whether crashes are becoming more severe over time.
2) ### Time & Risk Patterns:
    - Comparison of crash severity between daytime and nighttime collisions.
    - Identification of time of day and temporal patterns associated with elevated fatal collision rate.
3) ### Road User Vulnerability:
    - An assessment of pedestrian, cyclist, and motorist injury and fatality exposure.
    - Identification of populations most disproportionately impacted by traffic crashes.
4) ### Geography & Equity:
    - Analysis of collisions to identify high-risk boroughs and locations

# Data Structure
Data Source: [here](https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/about_data)

The Data Structure for Motor Vehicle Collisions is as shown in `Raw_Motor_Vehicle_Collisions`, with a total row count of 2,235,783.

<img width="369" height="600" alt="image" src="https://github.com/user-attachments/assets/64bc1c6f-591c-4058-b7ff-da9fa087197f" />
<img width="248" height="600" alt="image" src="https://github.com/user-attachments/assets/ea63fe59-36c1-42f4-9123-a96142481305" />


The SQL queries utilized to inspect and perform quality checks can be found [here](https://github.com/walktyler/Motor-Vehicle-Collision-Analysis/blob/main/mvc%20cleaning.sql)

# Data Cleaning
Prior to analysis, comprehensive data quality checks and cleaning were performed:
- Removed duplicate records by validating unique collision IDs and excluding rows with missing primary keys.
- Validated borough values, flagging any records outside the five official NYC boroughs for correction.
- Reconstructed missing location fields using available latitude and longitude values where possible.
- Tagged records lacking location, latitude, and longitude data, as they cannot be used for geographic analysis.
- Standardized vehicle type naming conventions by identifying redundant labels using wildcard pattern matching (`LIKE`) and consolidating them into consistent categories.

# Executive Summary
### Overview of Findings
- Collisions peaked at **231,564** in 2018, after which a sustained downwards trend appeared. Total collisions declined by **8.7%** from 2018 to 2019, followed by a sharp **46.6%** drop in 2020. Since 2020, collisions have continued to decrease at an average annual rate of approximately **5.4%**, excluding incomplete 2026 data.
- Nighttime collisions are approximately **2.6x** more likely to result in a fatality than daytime collisions, despite overall collision volume being substantially lower at night.
  
<img width="1769" height="993" alt="image" src="https://github.com/user-attachments/assets/efce2c61-fd06-4025-b22f-c09381a867da" />


### Fatalities & Crash Severity:

- Fatalities are volatile year over year, not consistently trending  in one direction. Following a spike between 2020-2021, fatalities have declined for three consecutive years with the most recent shrinkage being **15.77%**.
- While the number of collisions has declined by nearly 63% since 2018, the fatal risk per crash has more than doubled in the years following the same period, indicating that collisions have become substantially more severe.

### Time & Risk Patterns:
- The likelihood that a collision results in a fatality is significantly elevated at night. The average fatal collision rate is **0.29%** at night, compared with **0.11%** during the daytime, with nighttime rates peaking at **0.52%** versus **0.28%** during the day. This suggests that collisions occurring at night tend to be significantly more severe.
- While approximately 2.9 times more collisions occur on weekdays, crashes occurring on weekends are about 29% more likely to result in a fatality.

### Road User Vulnerability:
- Collisions occurring in Manhattan are significantly more likely to involve cyclists compared to other boroughs, while pedestrian injury rates remain elevated across all dense boroughs, particularly the Bronx and Brooklyn. Conversely, motorist injury rates are substantially lower in Manhattan relative to outer boroughs, where collisions are more likely to result in motorist harm. This may reflect differences in traffic patterns and density.
- While motorist make up for 73% of motor vehicle collision injuries, pedestrians are the most vulnerable as they make up 50% of the fatalities.

<img width="1889" height="1059" alt="image" src="https://github.com/user-attachments/assets/ba1de279-04c9-4362-a0ee-b1f40f095f40" />


# Recommendations

- Deploy targeted seasonal enforcement during peak collision months (May–October).
- Adjust traffic signal timing and congestion management during peak seasonal months.
- Develop an ongoing collision monitoring system to track structural shifts and emerging trends.
