import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import arcpy


if __name__ == "__main__":

    fdname = sys.argv[1]
    
    targetgdb = gdb.Gdb()
    targetgdb.sdeconn = "{0}/{1}".format(targetgdb.sdeconn,fdname)

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('building possession hook topology in {0} at {1}'.format(fdname
                                                                        ,datetime.datetime.now()))

    arcpy.management.CreateTopology(targetgdb.sdeconn
                                   ,"Possession_Hook_Topology"
                                   ,.0005274907)
    
    # targetgdb.sdeconn includes feature dataset
    # C:\gis\xx.sde\Cadastral\
    arcpy.management.AddFeatureClassToTopology(os.path.join(targetgdb.sdeconn,'Possession_Hook_Topology')
                                              ,os.path.join(targetgdb.sdeconn,'Possession_Hooks')
                                              ,1
                                              ,1)

    arcpy.management.AddFeatureClassToTopology(os.path.join(targetgdb.sdeconn,'Possession_Hook_Topology')
                                              ,os.path.join(targetgdb.sdeconn,'Boundary')
                                              ,1
                                              ,1)

    arcpy.management.AddRuleToTopology(os.path.join(targetgdb.sdeconn,'Possession_Hook_Topology')
                                      ,"Must Be Covered By (Point-Line)"
                                      ,os.path.join(targetgdb.sdeconn,'Possession_Hooks')
                                      ,""
                                      ,os.path.join(targetgdb.sdeconn,'Boundary'))

    logger.info('completed building possession hook topology in {0} at {1}'.format(fdname
                                                                                  ,datetime.datetime.now()))
