## **Front-End Bioinformaticians' Report on Cholera Outbreak 
# **Data Visualization and Project Report**

1. [Objectives](#objectives)
2. [Team Formation](#team_formation)
3. [Task Breakdown](#task_breakdown)
4. [Contacts](#contacts)

---

## **Objective:**

The objective of this project was to create an intuitive and interactive Shiny app that visualizes cholera outbreak data from the World Health Organization (WHO) and provides insightful summaries and reports for selected countries. The task involved collaboration between AMR epidemiologists and front-end bioinformaticians.

## **Formation of Teams:**

Two AMR epidemiologists and five front-end bioinformaticians were grouped together. The team coordinated closely to ensure that the epidemiologists provided accurate data analysis while the bioinformaticians focused on creating an effective user interface using R Shiny.

## **Task Breakdown**

1. **Data Collection**

The team successfully downloaded the raw cholera outbreak data from the WHO website. The data included records of cholera outbreaks from 1949 to the present.

---

2.  **Shiny App Development**:

The bioinformaticians utilized the **R Shiny** framework to develop the interactive dashboard that would visualize the cholera data. They focused on creating a user-friendly interface that could handle large datasets and enable users to explore data easily.

---

3. **Designing Interactive Maps and Charts**:  
   * **Interactive Maps**: The team implemented choropleth maps that dynamically visualized cholera outbreak locations globally. The map allowed users to zoom in on specific countries or regions and observe the outbreak's spread over time.  
   * **Interactive Charts**: Time-series plots were developed to show trends in cholera cases and fatalities. Users could customize these charts by selecting a country of interest, adjusting the date range, and choosing to view cases, fatalities, or other metrics like zoom in and out. 

---

4. **Key Metrics and Summaries**:

The bioinformaticians integrated automatic calculations for essential metrics, such as:

* **Total number of cases** in selected regions.  
  * **Total fatalities** during outbreaks.  
    * **Duration of outbreaks** (start to end date).  
    * **Case fatality rate** (CFR).

These metrics were summarized in plots and graphs that updated automatically when a user changed the filter settings.

---

5. **Reporting and Summaries**:

Based on the summary template designed by the AMR epidemiologists, the bioinformaticians implemented an automated report generation feature. However, this feature is only for selected country due to the capacity of the Shiny.io used but the generated report was designed to be downloadable in PDF format, enabling users to easily share or print the data.

---

6. **Challenges and Solutions**:

Given the extensive historical data since and other element, performance issues initially arose due to the free Shiny.io plan being used but the bioinformaticians optimized data loading and implemented efficient data processing techniques within R to ensure smooth performance. Although we had to reduce the load on the platform and not use too many colors to ensure proper functionality.

The team integrated reactive elements to ensure that every change in filter settings was reflected in real-time on maps, charts, and reports without any noticeable delay.

---

## **Contacts**
Any questions or feedback, kindly contact the contributors:

- **Tomilayo Oluwaseun Fadairo**: [Oluwaseuntomilayo9@gmail.com](mailto:Oluwaseuntomilayo9@gmail.com)
- **Akinjide Samuel Anifowose**: [Anifowosesamuel54@gmail.com](mailto:Anifowosesamuel54@gmail.com)
- **Opeoluwa Shodipe**: [Opeoluwashodipe94@gmail.com](mailto:Opeoluwashodipe94@gmail.com)
- **Ndubueze Ngozika Abigail**: [ndubungoabi2002@gmail.com](mailto:ndubungoabi2002@gmail.com)
- **Nwankwo Peace Nneka**: [nnekapeace85@gmail.com](mailto:nnekapeace85@gmail.com)


 

