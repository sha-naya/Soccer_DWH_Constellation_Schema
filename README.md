# Constellation Schema DWH of Soccer Data
## European Soccer Fixtures and Transfers
  
This repository contains ETL code for populating and updating a PostgreSQL DWH  
originally made for CS689: Designing and Implementing a Data Warehouse class' term project.  
  
The term project required creating a constellation schema DWH, with SCD type 2 and 3.  
To receive full marks, the design demanded at least 2 fact tables.  
  
Data was retrieved from 2 separate APIs: FOOTBALL API and Transfer Market API.  
The 2 fact tables in the design, fct_fixtures and fct_transfers, are connected by  
dim_team table. Table dim_location is SCD type 2 and table dim_team is SCD type 3.
