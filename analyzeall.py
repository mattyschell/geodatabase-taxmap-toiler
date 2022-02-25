import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import importer


if __name__ == "__main__":

    listname       = sys.argv[1]
    esricomponents = sys.argv[2].upper() # business or delta

    # tables -> src/resources/tables
    names = importer.Importlistmanager(listname)
    
    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    for name in names.names:

        logger.info('analyzing {0} at {1}'.format(name
                                                 ,datetime.datetime.now()))

        target = importer.Importmanager(targetgdb
                                       ,name)

        zerosuccess = target.analyze(esricomponents)

        if zerosuccess == 0:
            
            logger.info('completed analyzing {0} at {1} '.format(name
                                                                ,datetime.datetime.now()))

        else:
        
            logger.warn('failed analyzing {0} at {1} '.format(name
                                                             ,datetime.datetime.now()))


    logger.info('completed analyzing {0} at {1}'.format(listname
                                                       ,datetime.datetime.now()))