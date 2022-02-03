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

        self.srcshp = os.path.join(os.path.dirname(__file__)
                                  ,'resources'
                                  ,'nybb.shp')


    @classmethod
    def tearDownClass(self):

        self.target.delete()

    def test_acopy(self):

        # incomplete test
        # check counts
        self.target.copy(self.srcshp)

if __name__ == '__main__':
    unittest.main()