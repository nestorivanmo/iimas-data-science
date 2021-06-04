from pymongo import MongoClient
import time

class MongoDBClient:
    def __init__(self, db_name):
        self.db_name = db_name
        self.locahost = 'mongodb://localhost:27017/'
        self.client = MongoClient(self.locahost)
        self.db = self.client[self.db_name]

    def get_db(self):
        return self.db

    def get_client(self):
        return self.client

    def get_collection(self, collection_name):
        return self.db[collection_name]

    def find_in(self, collection_name, param_name, param_value):
        collection = self.get_collection(collection_name)
        return collection.find_one({param_name:param_value})

    def list_collection(self, collection, limit=10):
        for user in self.db[collection].find():
            print(user)

    def remove_all_from(self, collection):
        self.db[collection].drop()

    def insert_(self, collection, document):
        try:
            self.db[collection].insert_one(document)
        except:
            raise Exception("Error adding user")

    def update_place(self, username, place, latitude, longitude):
        user = self.find_in('users', 'username', username)
        if user is None:
            return False
        self.db['users'].update_one({'username': username}, {
            '$push': {
                'places': {
                    'name':place,
                    'location': {
                        'coordinates': [latitude, longitude],
                        'type':'Point'
                    }
                }
            }
        })
        return True