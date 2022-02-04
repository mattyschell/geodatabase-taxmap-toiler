import sys
import os
import logging
import arcpy

# SET PYTHONPATH=C:\XX\geodatabase-toiler\src\py
import gdb
import fc


class Importmanager(object):

    def __init__(self
                ,gdb
                ,targetfcname):

        self.gdb = gdb
        self.name = targetfcname
        self.targetfc = fc.Fc(self.gdb
                             ,self.name)

    def delete(self):

        #caller should check for locks

        if self.targetfc.exists():
            self.targetfc.delete()

    def copy(self
            ,sourcefc):

        self.gdb.importfeatureclass(sourcefc
                                   ,self.name)

    def qa(self
          ,sourcefc):

        if arcpy.GetCount_management(sourcefc)[0] == \
           arcpy.GetCount_management(self.targetfc.featureclass)[0]:
            return True
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
        