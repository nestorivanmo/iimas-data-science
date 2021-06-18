from mongo_client import MongoDBClient
import time

class UserHandler:
    def __init__(self, client):
        self.client = client

    def add_user_to_db(self, user):
        try:
            user_document = user.to_dict()
            self.client.insert_(collection='users', document=user_document)
        except:
            raise Exception("Error adding user")

    def search_for_bike_station(self, name):
        stations = self.client.db['stations']
        result = stations.find({
            'name': name
        })
        return result.next()

    def find_nearest_stations(self, lat, lon):
        stations = self.client.db['stations']
        result = stations.aggregate([
            {
                "$geoNear": {
                    "near": {"type":"Point", "coordinates": [lon, lat]},
                    "key": "loc",
                    "distanceField":"dist",
                    "spherical":True,
                    "maxDistance":500
                }
            },
            {"$limit":10}
        ])
        return result
         

    def search_for_user(self, username):
        user = self.client.find_in(
                collection_name = 'users',
                param_name = 'username',
                param_value = username
        )
        return user

    def update_place(self, username, place, latitude, longitude):
        try:
            user = self.search_for_user(username)
            if user is None:
                return False
            else:
                return self.client.update_place(username, place, latitude, longitude)
        except:
            raise Exception("Error adding new place")

class User:
    def __init__(self, username):
        if username == '':
            raise Exception("Username cannot be empty")
        self.username = username
        self.places = []

    def add_place(self, name, latitude, longitude):
        place = {
            'name':name, 
            'location': {
                'coordinates': [latitude, longitude],
                'type':'Point'
            }
        }
        self.places.append(place)

    def to_dict(self):
        dict_ = {
            'username': self.username,
            'places': self.places
        }
        return dict_

def main():
    # MongoDB configuration
    client = MongoDBClient(db_name='citi-bike')
    db = client.get_db()

    # User object
    user = User(username='nestorivanmo')

    # Adding places
    user.add_place(name = 'home', latitude = 40.71147801967245, longitude = -74.00746388222747)
    user.add_place(name = 'college', latitude = 40.72977354822797, longitude = -73.99709390352537)
    user.add_place(name = 'work', latitude = 40.75313286482328, longitude = -73.97681102916407)

    # Add user to MongoDB
    client.insert_(collection='users', document=user.to_dict())

    # Verifying
    client.list_collection('users')

if __name__ == '__main__':
    main()
    