import sys
import os
import logging
import arcpy

# exposes all the required bits from geodatabase-toiler

class Importlistmanager(object):

    def __init__(self,
                 whichlist):

        with open(os.path.join(os.path.dirname(__file__)
                              ,'resources'
                              ,whichlist)) as l:

            contents = [line.strip() for line in l]

        self.names = contents    


class Importmanager(object):

    def __init__(self
                ,sdeconn
                ,targetfcname):

        self.sdeconn = sdeconn
        self.name = targetfcname
        self.featureclass = self.sdeconn + "/" + self.name

    def delete(self):

        arcpy.Delete_management(self.featureclass)

    def exists(self):

        return arcpy.Exists(self.featureclass)

    def copy(self
            ,source):

        datatype = arcpy.Describe(source).dataType

        if (datatype == 'FeatureClass' \
        or  datatype == 'ShapeFile'):

            arcpy.conversion.FeatureClassToFeatureClass(source
                                                       ,self.sdeconn
                                                       ,self.name
                                                       ,''
                                                       ,''
                                                       ,'SDELOB') 

        else:

            raise ValueError('Cant copy {0} to SDELOB '.format(datatype))


    def qa(self
          ,sourcefc):

        if arcpy.GetCount_management(sourcefc)[0] == \
        arcpy.GetCount_management(self.featureclass)[0]:
            return True
        else:
            return False
        


        