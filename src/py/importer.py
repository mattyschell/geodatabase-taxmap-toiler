import sys
import os
import logging
import arcpy
import pathlib

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


class Importsqlmanager(object):

    def __init__(self
                ,whichsql
                ,whichdatabase='oracle'):

        sqlfilepath = pathlib.Path(__file__).parent.parent \
                                            .joinpath('sql_{0}'.format(whichdatabase)) \
                                            .joinpath(whichsql)
        
        with open(sqlfilepath, 'r') as sqlfile:
            sql = sqlfile.read() 

        self.sql = sql   


class Importmanager(object):

    def __init__(self
                ,gdb
                ,targetfcname):

        self.gdb = gdb
        self.name = targetfcname
        self.targetfc = fc.Fc(self.gdb
                             ,self.name)

    def delete(self):

        # check for locks
        # this deletes feature classes, tables, relclasses, more

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
                
        # Dont use this, build and document the schema        
        # you must know what will be stuck here like another feature 
        # layer in a relationship class       
        arcpy.management.Copy(source
                             ,self.targetfc.featureclass)

    def version(self):

        self.targetfc.version()

    def grant(self
             ,esripriv
             ,esriuser):

        # I have made the ESRI changeprivilegesmanagement
        # nobs and dials even more confusing!  

        if esripriv == 'VIEW':

            self.targetfc.grantprivileges(esriuser
                                         ,'AS_IS') 

        elif esripriv == 'EDIT':

            self.targetfc.grantprivileges(esriuser
                                         ,'GRANT')

        else:

            raise ValueError('oops whats {1}'.format(esripriv))

    def analyze(self
               ,esricomponent):

        if esricomponent.upper() == 'BUSINESS':

            return self.targetfc.analyze(['BUSINESS'])

        else:

            # ['BUSINESS','ADDS','DELETES']
            return self.targetfc.analyze()

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
        