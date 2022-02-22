import sys
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import arcpy


if __name__ == "__main__":

    targetgdb = gdb.Gdb()
    # origin and destination Cadastral/abc when in a featurdataset
    
    origin          = targetgdb.sdeconn + "/" + sys.argv[1] 
    destination     = targetgdb.sdeconn + "/" + sys.argv[2]
    relclassname    = targetgdb.sdeconn + "/" + sys.argv[3]
    relclasstype    = sys.argv[4]
    forwardlabel    = sys.argv[5]
    backwardlabel   = sys.argv[6]
    messagedir      = sys.argv[7]
    cardinality     = sys.argv[8]
    attributed      = sys.argv[9]
    origin_pkc      = sys.argv[10]
    origin_fkc      = sys.argv[11]

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('creating relationship class {0} at {1}'.format(relclassname
                                                               ,datetime.datetime.now()))

    arcpy.management.CreateRelationshipClass(origin
                                            ,destination
                                            ,relclassname
                                            ,relclasstype
                                            ,forwardlabel
                                            ,backwardlabel
                                            ,messagedir
                                            ,cardinality
                                            ,attributed
                                            ,origin_pkc
                                            ,origin_fkc)

    logger.info('completed creating relationship class {0} at {1}'.format(relclassname
                                                                         ,datetime.datetime.now()))

