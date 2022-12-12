# CS689 Term Project
# Soccer Fixtures and Transfers DWH
  
This repository contains ETL code for populating and updating a PostgreSQL database  
made for CS689: Designing and Implementing a Data Warehouse class.  
  
The term project required creating a constellation schema DWH, with SCD type 2 and 3.  
To receive full marks, the design must have at least 2 fact tables.  
  
Data was retrieved from 2 separate APIs: FOOTBALL API and Transfer Market API.  
The 2 fact tables in the design, fct_fixtures and fct_transfers, are connected by  
dim_team table. Table dim_location is SCD type 2 and table dim_team is SCD type 3.
