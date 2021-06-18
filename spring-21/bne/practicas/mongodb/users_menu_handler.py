import time
import signal
from trips_handler import TripsHandler
from users_handler import User, UserHandler
from datetime import datetime

class UserMenuHandler:
    def __init__(self, client):
        self.client = client
        self.user_handler = UserHandler(client)

    def ask_for_user_input(self):
        username = input("Username: ")
        place = input("Place name: ")
        latitude = float(input("Latitude (only numbers): "))
        longitude = float(input("Longitude (only numbers): "))
        try:
            user = User(username)
            user.add_place(place, latitude, longitude)
        except:
            raise Exception('User could not be created')
        return user

    def __adding_user(self):
        print("\nAdding user...")
        self.__sleep()

    def __user_added(self):
        print("User added successfully !")
        self.__sleep()
    
    def add_user_to_db(self, user):
        self.__adding_user()
        try:
            self.user_handler.add_user_to_db(user)
            self.__user_added()
        except:
            raise Exception("User could not be added")

    def __ask_for_username(self):
        return input("Username to add place to: ")

    def __no_user_for_username(self, username):
        print(f'Username \'{username}\' could not be found in database')
        self.__sleep()

    def __sleep(self, secs=2):
        time.sleep(secs)

    def __user_place_added(self):
        print("New place added !")
        self.__sleep()

    def update_place(self):
        try:
            username = self.__ask_for_username()
            user = self.user_handler.search_for_user(username)
            if user is None:
                self.__no_user_for_username(username)
            else:
                (place, latitude, longitude) = self.__ask_for_place()
                if self.user_handler.update_place(username, place, latitude, longitude):
                    print(f"\'{place}\' added to {username}\'s places")
                else:
                    print(f"\'{place}\'could not be added")
                self.__sleep()
        except:
            raise Exception ("New place could not be added")

    def __ask_for_place(self):
        place = input("Place name: ")
        latitude = float(input("Latitude (only numbers): "))
        longitude = float(input("Longitude (only numbers): "))
        return (place, latitude, longitude)

    def __ask_for(self, element):
        return input(f"{element}: ")

    def __ask_for_num_place(self, username):
        user = self.user_handler.search_for_user(username)
        if user is None:
            print(f"No user found for username: \'{username}\'")
            self.__sleep(1)
            raise Exception("Missing user")
        text_input = f"\nShowing {user['username']}\'s places (select one):\n"
        pc = 1
        for place in user['places']:
            name = place['name']
            text_input += f"{pc}. {name}\n"
            pc += 1
        text_input += '-> '
        return (user, int(input(text_input))-1) #-1 to be 0-based index

    #num_place is 0-based index
    def __show_nearest_stations(self, user, num_place, show=True):
        place = user['places'][num_place]
        place_name = place['name']
        place_latitude = place['location']['coordinates'][0]
        place_longitude = place['location']['coordinates'][1]
        print(f"\nShowing nearest stations to {place_name}:")
        stations = self.user_handler.find_nearest_stations(place_latitude, place_longitude)
        pc = 1
        for station in stations:
            station_name = station['name']
            distance = station['dist']            
            print(f"{pc}. {station_name}\n  {round(distance,1)} m")
            pc += 1
        if show:
            input("Press any key to continue ")
        else: return self.user_handler.find_nearest_stations(place_latitude, place_longitude)
        

    def nearest_station(self):
        try:
            username = self.__ask_for('Username')
            (user, num_place) = self.__ask_for_num_place(username)
            self.__show_nearest_stations(user, num_place)
        except:
            raise Exception("Error in nearest station finder")

    def __ask_for_trip_start_method(self):
        return int(input("Select a method to start your trip:\n1. Specific bike station\n2. Nearest bike stations \n3. Nearest bike stations to your places\n-> "))

    def __get_coordinates_from_start_method(self, start_method):
        if start_method == 1: #specific bike station
            return self.__get_coordinates_from_bike_station()
        if start_method == 2: #nearest bike stations
            return self.__get_coordinates_from_nearest_stations()
        if start_method == 3: # nearest to user's places
            return self.__get_coordinates_from_user_places()

    def __get_coordinates_from_bike_station(self):
        bike_station_name = input("\nBike station name: ")
        try:
            bike_station = self.user_handler.search_for_bike_station(bike_station_name.strip())
            coordinates = bike_station['loc']['coordinates']
            return (coordinates[1], coordinates[0]) # (lat, lon)
        except:
            print(f"Bike station \'{bike_station_name}\' could not be found")
            self.__sleep()
            return None


    def __get_coordinates_from_nearest_stations(self):
        # 40.731884028650974, -73.99737494603235
        try:
            latitude = float(input("\nYour current latitude: "))
            longitude = float(input("Your current longitude: "))
            stations = self.user_handler.find_nearest_stations(latitude, longitude)
            bike_stations = []
            print("\nShowing nearest stations: ")
            pc = 1
            for station in stations:
                bike_stations.append(station)
                station_name = station['name']
                distance = station['dist']            
                print(f"{pc}. {station_name}\n   {round(distance,1)} m")
                pc += 1
            bike_idx = int(input("\nBike station: "))
            coordinates = bike_stations[bike_idx-1]['loc']['coordinates']
            return (coordinates[1], coordinates[0]) # (lat, lon)
        except:
            raise Exception("Bad coordinates")

    def __get_coordinates_from_user_places(self):
        try:
            username = self.__ask_for('username')
            (user, num_place) = self.__ask_for_num_place(username)
            stations = self.__show_nearest_stations(user, num_place, show=False)
            bike_stations = [s for s in stations]
            bike_idx = int(input("\nNumber of bike station: "))
            coordinates = bike_stations[bike_idx-1]['loc']['coordinates']
            return (coordinates[1], coordinates[0]) # (lat, lon)
        except:
            print("Username could not be found")
            raise Exception("Bad username")

    
    def trip_planner(self):
        try:
            start_method = self.__ask_for_trip_start_method()
            coordinates = self.__get_coordinates_from_start_method(start_method)
            trip_time = float(self.__ask_for('\nHow long do you want your trip to last? (minutes)'))
            current_time = datetime.now()
            current_time = str(current_time).split(' ')[1]
            print(f"\nFetching trips [Time={current_time[:8]}]...")
            current_time = current_time[1] if current_time[0] == '0' else current_time[:2]
            current_time = int(current_time)
            th = TripsHandler(location=coordinates, trip_time=trip_time, hour=current_time)
            th.start_trip_finder()
            input("\nPress any key to continue ")
        except:
            raise Exception("Error in trip planner")