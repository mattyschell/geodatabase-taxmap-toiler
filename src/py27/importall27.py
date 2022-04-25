import sys
import os
import logging
import datetime

import importer27 


if __name__ == "__main__":

    listname = sys.argv[1]
    srcsde   = sys.argv[2]

    # for example
    # src/resources/featureclasses
    names = importer27.Importlistmanager(listname)
    
    targetsdeconn = os.environ['SDEFILE']

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    for name in names.names:

        logger.info('importing {0} at {1}'.format(name
                                                 ,datetime.datetime.now()))

        target = importer27.Importmanager(targetsdeconn
                                         ,name)

        if target.exists():
        
            try:
                target.delete()
            except:
                print 'Cannot import, the target exists and is locked'
        
        target.copy(os.path.join(srcsde
                                ,name))

        logger.info('completed importing {0} at {1}'.format(name
                                                           ,datetime.datetime.now()))

    logger.info('completed importing {0} at {1}'.format(listname
                                                       ,datetime.datetime.now()))