import sys
import os
import logging
import datetime
import arcpy

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
# SET PYTHONPATH=C:\gis\geodatabase-taxmap-toiler\src\py
import importer

def removeschema(dbobjectlist):

    cleandblist = []
    for dbobject in dbobjectlist:
        cleandblist.append(dbobject.partition('.')[2])

    return cleandblist

# TODO
# def get_relationshipclasses():
# 

def get_tables():

    return removeschema(arcpy.ListTables())

def get_feature_datasets():
    
   return  removeschema(arcpy.ListDatasets())

def get_feature_classes():

    feature_classes = arcpy.ListFeatureClasses()

    for dataset in arcpy.ListDatasets():
        dataset_fcs = arcpy.ListFeatureClasses(feature_dataset = dataset)

        #add feature classes to ongoing list
        for fc in dataset_fcs:
            feature_classes.append(fc)

    return removeschema(feature_classes)

def getallobjects():

    return get_tables() \
         + get_feature_datasets() \
         + get_feature_classes()


if __name__ == "__main__":

    listname = sys.argv[1]

    # for example
    # src/resources/listoflists
    listnames = importer.Importlistmanager(listname)
    
    arcpy.env.workspace = os.environ['SDEFILE']

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    existingobjects = getallobjects()

    expectedobjects = []

    for name in listnames.names:

        objectnames = importer.Importlistmanager(name)
        expectedobjects = expectedobjects + objectnames.names
        
    expectednotexisting = set(expectedobjects).difference(set(existingobjects))

    if len(expectednotexisting) == 0:
            logger.info('completed qa at {0} all good'.format(datetime.datetime.now()))
    else:
        for missing in expectednotexisting:
            logger.warning('{0} is missing!'.format(missing))
            