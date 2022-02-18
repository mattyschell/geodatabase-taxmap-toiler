import sys
import os
import logging
import arcpy

# SET PYTHONPATH=C:\XX\geodatabase-toiler\src\py
import gdb
import fc


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
                ,gdb
                ,targetfcname):

        self.gdb = gdb
        self.name = targetfcname
        self.targetfc = fc.Fc(self.gdb
                             ,self.name)

    def delete(self):

        #check for locks

        if self.targetfc.exists():
            self.targetfc.delete()

    def copy(self
            ,source):

        datatype = arcpy.Describe(source).dataType

        if (datatype == 'FeatureClass' \
        or  datatype == 'ShapeFile'):

            self.gdb.importfeatureclass(source
                                       ,self.name)

        elif datatype == 'Table':

            self.gdb.importtable(source
                                ,self.name)

    def stickycopy(self
                  ,source):
            
        print("sc line 62")
        # you must know what will be stuck here
        # like another feature layer in a relationship class
        # Better to copy one by one and then 
        # create support objects?
        # A: Yes, the code documents the schema
        print("{0}".format(source))
        print("{0}".format(self.targetfc.featureclass))

        
        arcpy.management.Copy(source
                             ,self.targetfc.featureclass)


    def qa(self
          ,sourcefc):

        if self.targetfc.exists():

            if arcpy.GetCount_management(sourcefc)[0] == \
            arcpy.GetCount_management(self.targetfc.featureclass)[0]:
                return True
            else:
                return False
        
        else:
        
            return False

if __name__ == "__main__":

    targetfcname = sys.argv[1]
    sourcefc     = sys.argv[2]

    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    layer = Importmanager(targetgdb,
                          targetfcname)

    if not layer.targetfc.locksexist():
        layer.delete()
    else:
        raise ValueError('Cannot import, the target exists and is locked')

    layer.copy(sourcefc)

    if not layer.qa(sourcefc):
        logging.error('failed qa of {0}'.format(layer.name))
        