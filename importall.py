import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import importer


if __name__ == "__main__":

    listname = sys.argv[1]
    srcsde   = sys.argv[2]

    # for example
    # src/resources/featureclasses
    names = importer.Importlistmanager(listname)
    
    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    for name in names.names:

        logger.info('importing {0} at {1}'.format(name
                                                 ,datetime.datetime.now()))

        target = importer.Importmanager(targetgdb
                                       ,name)

        target.copy(os.path.join(srcsde
                                ,name))

        logger.info('completed importing {0} at {1}'.format(name
                                                           ,datetime.datetime.now()))

    logger.info('completed importing {0} at {1}'.format(listname
                                                       ,datetime.datetime.now()))