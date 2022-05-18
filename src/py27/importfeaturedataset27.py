import sys
import os
import logging
import datetime

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import importer27 
import arcpy


if __name__ == "__main__":

    fdname = sys.argv[1]
    srcsde = sys.argv[2]

    targetsdeconn = os.environ['SDEFILE']

    # for example
    # src/resources/Cadastral
    # create Cadastral feature dataset
    # then import Cadastral contents
    names = importer27.Importlistmanager(fdname)
    
    featuredataset = "{0}/{1}".format(targetsdeconn,fdname)

    print 'creating feature dataset {0} at {1}'.format(fdname,datetime.datetime.now())


    arcpy.CreateFeatureDataset_management(targetsdeconn
                                         ,fdname
                                         ,os.path.join(os.path.dirname(__file__)
                                                      ,'resources'
                                                      ,'epsg_2263.prj'))

    # hack feature dataset name onto the the target "Output location"
    targetgdb_sdeconn = featuredataset

    for name in names.names:

        print 'importing {0} at {1}'.format(name,datetime.datetime.now())        
        
        target = importer27.Importmanager(targetgdb_sdeconn
                                         ,name)

        # hack feature dataset name onto the the source "Input features"
        target.copy(os.path.join("{0}/{1}/{2}".format(srcsde
                                                     ,fdname
                                                     ,name)))
       
        print 'completed importing {0} at {1}'.format(name,datetime.datetime.now())       
        
    print 'completed importing {0} at {1}'.format(fdname,datetime.datetime.now())
    
    
