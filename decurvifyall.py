import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import importer
import cx_sde


if __name__ == "__main__":

    listname       = sys.argv[1]

    # tables -> src/resources/tables
    names = importer.Importlistmanager(listname)
    targetsdeconn = os.environ['SDEFILE']

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    curveprocedure = importer.Importsqlmanager('compileremovecurves.sql')

    sdereturn = cx_sde.execute_immediate(targetsdeconn
                                        ,curveprocedure.sql)

    for name in names.names:

        logger.info('removing any curves from {0} at {1}'.format(name
                                                                ,datetime.datetime.now()))

        # editing base table before versioning and indexes, monitor performance
        sdereturn = cx_sde.execute_immediate(targetsdeconn,
                                             """begin remove_curves('{0}'); end; """.format(name))

        logger.info('completed removing curves from {0} at {1} '.format(name
                                                                       ,datetime.datetime.now()))

    logger.info('completed removing {0} curves at {1}'.format(listname
                                                             ,datetime.datetime.now()))