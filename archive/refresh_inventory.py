import arcpy


def get_feature_datasets():
    
   return  arcpy.ListDatasets()


def get_feature_classes():

    #this is bare feature classes, not in a feature dataset
    feature_classes = arcpy.ListFeatureClasses()

    feature_datasets = get_feature_datasets()

    #get any feature datasets
    for dataset in feature_datasets:
        dataset_fcs = arcpy.ListFeatureClasses(feature_dataset = dataset)

        #add feature classes to ongoing list
        for fc in dataset_fcs:
            feature_classes.append(fc)

    return feature_classes

def get_grants(object_list):

    #typically pass in a list of tables or views
    #first convert object list to comma-delimited list for SQL usage
    #also make all text caps
    #also also if its an esri list with schema.tablename remove the schema dot
    #Goal is like
    # ('TABLEA','TABLEB','TABLEC')

    formattedobjects = []
    
    #convert to uppered table names only
    
    for dbobject in object_list:
        
        splitobject = dbobject.split('.')
        
        if len(splitobject) == 2:
            formattedobjects.append(splitobject[1].upper())
        elif len(splitobject) == 1:
            formattedobjects.append(splitobject[0].upper())
        else:
            raise ValueError("Weird dot notation: " + str(splitobject))

    #now make comma delimited for SQL
    parenclause = "('" + "','".join(formattedobjects) + "')"

    #print parenclause

    sql = "SELECT " \
          "'GRANT ' || a.privilege || ' ON ' || a.table_name || ' TO ' || a.grantee || ';'" \
          "FROM dba_tab_privs a " \
          "WHERE a.owner = sys_context('USERENV','CURRENT_SCHEMA') " \
          "AND a.table_name IN " + parenclause + " " \
          "ORDER by a.table_name, a.grantee, a.privilege "

    try:
        grant_ddls = executeimmediate(sql)
    except:
        #this can fail for schemas without access to dba_tab_privs
        #consider using dbms_metadata.get_ddl
        raise ValueError("Error selecting from dba_tab_privs. Personal schema?")

    #print grant_ddls

    grants = []

    #should return a list of lists
    #where each list is a single element ddl
    #restructure as a single list
    for grant_ddl in grant_ddls:
        
        if len(grant_ddl) == 1:
            grants.append(grant_ddl[0])     
        else:
            raise ValueError("This list should contain 1 ddl " + str(grant_ddl))

    return grants


def get_tables():

    #these are only tables registered with sde
    #all the other tables, most notably sde system tables
    #and versioned system tables (the A_ and D_) tables
    #will be ignored
    return arcpy.ListTables()

       
def executeimmediate(sql_str):
    
    try:
        sdeconn = arcpy.ArcSDESQLExecute(arcpy.env.workspace)
    except:
        print(" ")
        print("workspace = " + str(arcpy.env.workspace))
        print(arcpy.GetMessages())
        raise

    try:
        sdeReturn = sdeconn.execute(sql_str)
        #print "sdeReturn is " + sdeReturn
    except:
        sdeReturn = False
        raise;

    #returns either True (if DDL or not a select)
    #or a list of lists (each row is a list)
    #commitTransaction()?  Not performing updates in this context
    return sdeReturn;



def get_views():

    #we are leaving ESRI here
    #these are oracle views, without regard to registration with SDE

    listoflists = executeimmediate("select view_name from user_views")
    views = []

    #should return a list of lists
    #where each list is a single view name
    #restructure as a single list
    for singleviewlist in listoflists:
        
        if len(singleviewlist) == 1:
            views.append(singleviewlist[0])     
        else:
            raise ValueError("This list should contain 1 view " + str(singleviewlist))
            
    return views

def print_mismatches(sourcelist,
                     targetlist,
                     header,
                     indentation):

    mismatchestoprint = []
    
    sourcenottarget = set(sourcelist).difference(set(targetlist))

    if len(sourcenottarget) > 0:
        mismatchestoprint.append(indentation + "In the source but not in the target: ")
        for elem in sourcenottarget:
            mismatchestoprint.append(indentation + indentation + str(elem))

    targetnotsource = set(targetlist).difference(set(sourcelist))

    if len(targetnotsource) > 0:
        mismatchestoprint.append(indentation + "In the target but not in the source: ")
        for elem in targetnotsource:
            mismatchestoprint.append(indentation + indentation + str(elem))

    if len(mismatchestoprint) > 0:
        print (header)
        for mismatch in mismatchestoprint:
            print (mismatch                      )


######main##########


sourcesdeconnection = "c:/arcgisconnections/dof_taxmap@geocprd (dof_taxmap).sde"
targetsdeconnection =  "c:/arcgisconnections/dof_taxmap@geocstg.sde (dof_taxmap).sde"

#user schema geodatabase connection above has limited scope.
#Cant see (unregistered) views for ex, even when executing sql
sourceschemaconnection = "c:/arcgisconnections/dof_taxmap@geocprd.sde"
targetschemaconnection = "c:/arcgisconnections/dof_taxmap@geocstg.sde"


#source user schema geodabase sde
arcpy.env.workspace = sourcesdeconnection
sourcefeaturedatasets = get_feature_datasets()
sourcefeatureclasses = get_feature_classes()
sourcefeatureclassgrants = get_grants(sourcefeatureclasses)
sourcetables = get_tables()
sourcetablegrants = get_grants(sourcetables)

#source regular sde connection
arcpy.env.workspace = sourceschemaconnection
sourceviews = get_views()
sourceviewsgrants = get_grants(sourceviews)

#target geodatabase sde
arcpy.env.workspace = targetsdeconnection
targetfeaturedatasets = get_feature_datasets()
targetfeatureclasses = get_feature_classes()
targetfeatureclassgrants = get_grants(targetfeatureclasses)
targettables = get_tables()
targettablegrants = get_grants(targettables)

#target regular sde connection
arcpy.env.workspace = targetschemaconnection
targetviews = get_views()
targetviewsgrants = get_grants(targetviews)

print_mismatches(sourcefeaturedatasets,
                 targetfeaturedatasets,
                 "Feature Dataset mismatches:",
                 "    ")

print_mismatches(sourcefeatureclasses,
                 targetfeatureclasses,
                 "Feature Class mismatches:",
                 "    ")

print_mismatches(sourcetables,
                 targettables,
                 "SDE Registered Table mismatches:",
                 "    ")

print_mismatches(sourceviews,
                 targetviews,
                 "View mismatches:",
                 "    ")

print_mismatches(sourcefeatureclassgrants,
                 targetfeatureclassgrants,
                 "Feature Class grant mismatches:",
                 "    ")

print_mismatches(sourceviewsgrants,
                 targetviewsgrants,
                 "View grant mismatches:",
                 "    ")

print("Finished dataset inventory.  Any mismatches would be printed above this line")

