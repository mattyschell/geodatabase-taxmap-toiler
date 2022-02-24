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
    esripriv = sys.argv[2].upper()
    esriuser = sys.argv[3].upper()

    # for example
    # src/resources/tables
    namestogrant = importer.Importlistmanager(listname)
    
    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    for name in namestogrant.names:

        logger.info('granting {0} on {1} to {2} at {3}'.format(esripriv
                                                              ,name
                                                              ,esriuser
                                                              ,datetime.datetime.now()))

        target = importer.Importmanager(targetgdb
                                       ,name)

        target.grant(esripriv
                    ,esriuser)

        logger.info('completed granting {0} on {1} to {2} at {3}'.format(esripriv
                                                                        ,name
                                                                        ,esriuser
                                                                        ,datetime.datetime.now()))

    logger.info('completed {0} grants on {1} at {2}'.format(esripriv
                                                           ,listname
                                                           ,datetime.datetime.now()))