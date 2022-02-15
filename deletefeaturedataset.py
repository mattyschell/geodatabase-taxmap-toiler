import sys
import os
import logging

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import gdb
import importer


if __name__ == "__main__":

    fdname = sys.argv[1]
    
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    target = importer.Importmanager(targetgdb
                                   ,fdname)

    target.delete()

    logger.info('completed deleting {0}'.format(fdname))