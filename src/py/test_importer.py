import unittest
import os

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

        self.srcshp = os.path.join(os.path.dirname(__file__)
                                  ,'resources'
                                  ,self.testobjects.names[0])

        self.testobjects = importer.Importlistmanager('test_tables')

        self.srcdbf = os.path.join(os.path.dirname(__file__)
                                  ,'resources'
                                  ,self.testobjects.names[0])

    @classmethod
    def tearDownClass(self):

        self.target.delete()

    @classmethod
    def tearDown(self):

        self.target.delete()

    def test_acopy(self):

        self.target.copy(self.srcshp)

        self.assertTrue(self.target.qa(self.srcshp)) 

    def test_bdeletenoexist(self):

        self.target.delete()

        self.assertFalse(self.target.qa(self.srcshp)) 

    def test_ccopytable(self):

        self.target.copy(self.srcdbf)

        self.assertTrue(self.target.qa(self.srcdbf)) 
        

if __name__ == '__main__':
    unittest.main()