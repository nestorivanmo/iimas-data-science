import sys
from menu_handler import MenuHandler
from mongo_client import MongoDBClient

class MongoApp:
    def __init__(self):
        self.client = MongoDBClient(db_name='citi-bike')
        self.menu_handler = MenuHandler(self.client)

    def start_app(self):
        while True:
            self.menu_handler.show_menus()
            
if __name__ == '__main__':
    MongoApp().start_app()