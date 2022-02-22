import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import importer
import arcpy


if __name__ == "__main__":

    fdname = sys.argv[1]
    srcsde = sys.argv[2]

    # for example
    # src/resources/Cadastral
    # create Cadastral feature dataset
    # then import Cadastral contents
    namestoimport = importer.Importlistmanager(fdname)
    
    targetgdb = gdb.Gdb()
    featuredataset = "{0}/{1}".format(targetgdb.sdeconn,fdname)

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('creating feature dataset {0} at {1}'.format(fdname
                                                            ,datetime.datetime.now()))

    # cluephone ringing, no feature dataset manager in geodatabase-toiler
    # this was intentional, now I take the L
    arcpy.CreateFeatureDataset_management(targetgdb.sdeconn
                                         ,fdname
                                         ,os.path.join(os.path.dirname(__file__)
                                                      ,'src'
                                                      ,'py'
                                                      ,'resources'
                                                      ,'epsg_2263.prj'))

    # hack feature dataset name onto the the target "Output location"
    targetgdb.sdeconn = featuredataset

    for name in namestoimport.names:

        logger.info('importing {0} at {1}'.format(name
                                                 ,datetime.datetime.now()))        
        
        target = importer.Importmanager(targetgdb
                                       ,name)

        # hack feature dataset name onto the the source "Input features"
        target.copy(os.path.join("{0}/{1}/{2}".format(srcsde
                                                     ,fdname
                                                     ,name)))

        
        logger.info('completed importing {0} at {1}'.format(name
                                                           ,datetime.datetime.now()))        
        
    logger.info('completed importing {0} at {1}'.format(fdname
                                                       ,datetime.datetime.now()))
    
    
