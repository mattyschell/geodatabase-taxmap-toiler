# Export to File Geodatabase

This is the export procedure we will use in the taxmap cutover from the legacy 10.2 Enterprise Geodatabase on Oracle 11g to the new application in Azure.  We will export required data from the dof_taxmap schema to a file geodatabase using the copy and paste in ArcGIS Pro's catalog pane. Yes, that's right.

Use ArcGIS Pro for all steps.  ArcCatalog (32 bit) seems to crash unexpectedly at various stages of export. 

REMINDER: Focus and do not execute deletes unless absolutely necessary.  A delete clicked on the production database is a risk here.   

1. Create the empty output file geodatabase
2. Copy-paste the Cadastral feature dataset from source to target
3. Copy-paste the DCP feature  dataset from source to target
3. Use Table2table to export the three tables with big BLOB columns.  Remove the blob columns in the export
    3a. HAB
    3b. MAP_INSET_LIBRARY
    3c. MAP_LIBRARY
4. Check the output for _1s that got dragged along from the steps above.  Take better notes next time. 
5.  Copy and paste the rest to fill in the missing datasets.  Refer to finalexport1.png and finalexport2.png in this directory.
