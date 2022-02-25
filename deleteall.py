import sys
import os
import logging

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import importer


if __name__ == "__main__":

    listname = sys.argv[1]

    # for example
    # src/resources/featureclasses
    names = importer.Importlistmanager(listname)
    
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    for name in names.names:

        logger.info('deleting {0}'.format(name))

        target = importer.Importmanager(targetgdb
                                       ,name)

        target.delete()

    logger.info('completed deleting {0}'.format(listname))