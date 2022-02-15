import sys
import os
import logging

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

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('creating feature dataset {0}'.format(fdname))

    # cluephone ringaling, no feature dataset manager in 
    # geodatabase-toiler was intentional, but maybe should do
    arcpy.CreateFeatureDataset_management(targetgdb.sdeconn
                                         ,fdname)

    # will someone answer the phone
    # hack feature dataset name onto the the target "Output location"
    targetgdb.sdeconn = "{0}/{1}".format(targetgdb.sdeconn,fdname)

    for name in namestoimport.names:

        logger.info('importing {0}'.format(name))        
        
        target = importer.Importmanager(targetgdb
                                       ,name)

        # hack feature dataset name onto the the source "Input features"
        target.copy(os.path.join("{0}/{1}/{2}".format(srcsde
                                                     ,fdname
                                                     ,name)))

    logger.info('completed importing {0}'.format(fdname))