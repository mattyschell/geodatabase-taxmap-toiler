import sys
import os
import logging

# SET PYTHONPATH=C:\gis\geodatabase-toiler\src\py
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

        #check for locks buddy

        if self.targetfc.exists():
            self.targetfc.delete()

    def copy(self
            ,sourcefc):

        self.gdb.importfeatureclass(sourcefc
                                   ,self.name)

    def qa():

        # versioned views on target
        # count tool on source !

        return True

if __name__ == "__main__":

    targetfcname = sys.argv[1]
    sourcefc     = sys.argv[2]

    targetsdeconn = os.environ['SDEFILE']
    targetgdb = gdb.Gdb()

    layer = Importmanager(targetgdb,
                          targetfcname)

    layer.delete()
    layer.copy(sourcefc)

    if not layer.qa():
        logging.error('failed qa of {0}'.format(layer.name))