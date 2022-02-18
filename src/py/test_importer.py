import unittest
import os
import pathlib

import gdb
import importer


class ImporterTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(self):

        self.sdeconn = os.environ['SDEFILE']
        self.testgdb = gdb.Gdb()
        
        self.target = importer.Importmanager(self.testgdb
                                            ,'NYBB')

        self.testobjects = importer.Importlistmanager('test_shapefiles')

        self.srcshp = os.path.join(pathlib.Path(__file__).parent.resolve()
                                  ,'resources'
                                  ,self.testobjects.names[0])

        self.testobjects = importer.Importlistmanager('test_tables')

        self.srcdbf = os.path.join(pathlib.Path(__file__).parent.resolve()
                                  ,'resources'
                                  ,self.testobjects.names[0])

        self.target2 = importer.Importmanager(self.testgdb
                                            ,'NYBB2')

    @classmethod
    def tearDownClass(self):

        self.target.delete()
        self.target2.delete()

    def tearDown(self):

        self.target.delete()
        self.target2.delete()

    def test_acopy(self):

        self.target.copy(self.srcshp)

        self.assertTrue(self.target.qa(self.srcshp)) 

    def test_bdeletenoexist(self):

        self.target.delete()

        self.assertFalse(self.target.qa(self.srcshp)) 

    def test_ccopytable(self):

        self.target.copy(self.srcdbf)

        self.assertTrue(self.target.qa(self.srcdbf)) 
        
    def test_dstickycopy(self):

        # just tests copy, not stickyness
        
        # must be same types (in and out)
        self.target.copy(self.srcshp)        
        
        self.target2.stickycopy(self.target.targetfc.featureclass)

        self.assertTrue(self.target2.qa(self.srcshp)) 


if __name__ == '__main__':
    unittest.main()