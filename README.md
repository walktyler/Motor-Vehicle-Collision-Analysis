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
Collisions peaked at **231,564** in 2018, after which a sustained downwards trend appeared. Total collisions declined by **8.7%** from 2018 to 2019, followed by a sharp **46.6%** drop in 2020. Since 2020, collisions have continued to decrease at an average annual rate of approximately **5.4%**, excluding incomplete 2026 data.

<img width="1941" height="1080" alt="image" src="https://github.com/user-attachments/assets/792bbead-4a42-44bb-88e7-887f370f4545" />


### Fatalities & Crash Severity:

- Fatalities are volatile year over year, not consistently trending  in one direction. Following a spike between 2020-2021, fatalities have declined for three consecutive years with the most recent shrinkage being **15.77%**.
- While the number of collisions has declined by nearly 63% since 2018, the fatal risk per crash has more than doubled in the years following the same period, indicating that collisions have become substantially more severe.

### Time & Risk Patterns:
- Although overall crash volume is higher during the daytime, the probability that a collision results in a fatality is significantly elevated at night (0.26% vs 0.10%), indicating substantially higher crash severity during nighttime hours.
- While approximately 2.9 times more collisions occur on weekdays, crashes occurring on weekends are about 29% more likely to result in a fatality.

### Road User Vulnerability:
- Collisions occurring in Manhattan are significantly more likely to involve cyclists compared to other boroughs, while pedestrian injury rates remain elevated across all dense boroughs, particularly the Bronx and Brooklyn. Conversely, motorist injury rates are substantially lower in Manhattan relative to outer boroughs, where collisions are more likely to result in motorist harm. This may reflect differences in traffic patterns and density.
