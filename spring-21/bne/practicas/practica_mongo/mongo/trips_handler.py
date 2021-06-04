from mongo_client import MongoDBClient
from datetime import datetime

class Trip:
    def __init__(self):
        self.stations = []

    def add_two_stations(self, two_stations):
        if two_stations is None:
            raise Exception("Bike stations is \'None\'")
        self.stations.append(two_stations)

    def __str__(self):
        if self.stations is []: return "Trip is empty"
        trip_str = ""
        for idx, two_station in enumerate(self.stations):
            origin = two_station.origin
            destination = two_station.destination
            trip_str += f"\n({origin.name} -> {destination.name}): {round(two_station.time,1)} min, {round(two_station.distance,2)} m"
        return trip_str

class TwoStations:
    def __init__(self, origin, destination, distance, time, hour=None):
        self.origin = origin
        self.destination = destination
        self.distance = distance
        self.time = time
        self.hour = hour


    def __str__(self):
        return f"({self.origin.name} -> {self.destination.name})\n\tTime: {round(self.time,1)} s\n\tDistance: {round(self.distance,1)} m"

class BikeStation:
    def __init__(self, id, name, latitude, longitude):
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude


    def __str__(self):
        return f"\nBike Station:\n------------\nId: {self.id}\nName: {self.name}\nLocation: ({self.latitude},{self.longitude})"


class BikeStationHandler:
    def __init__(self, client, trip_time, accumulated_time=0, user_time_of_query=None):
        self.client = client
        self.trip_time = trip_time
        self.accumulated_time = accumulated_time
        self.original_time = user_time_of_query
        self.user_time_of_query = user_time_of_query
        self.trips = []

    def __find_best_station(self):
        stations = self.client.db['stations']
        
    def __find_distance_between(self, origin, destination):
        stations = self.client.db['stations']
        result = stations.aggregate([
            {
                "$geoNear": {
                    "near": {"type":"Point", "coordinates": [-73.9816324043, 40.752062306999996]},
                    "key": "loc",
                    "distanceField":"dist",
                    "spherical":True
                }
            },
            {
                "$project":{
                    "_id":0,
                    "id":1,
                    "dist":1
                }
            }
        ])
        for r in result:
            if r['id'] == destination.id:
                return r['dist']
    

    def find_next_trip_station(self, bike_station, trip_time, user_hour=None, multiple=False):
        trips = self.client.db['trips']
        trips.create_index('start_station_id')
        result = trips.aggregate([
            {
                "$match": {
                    "$and": [
                        {"start_station_id": bike_station.id},
                        {"end_station_id": {"$ne": bike_station.id}}
                    ]
                }
            },
            {"$project":{
                "_id": 0,
                "hour": {"$hour": {"date": {"$dateFromString": {"dateString": '$start_time'}}}},
                "year": {"$year": {"date": {"$dateFromString": {"dateString": '$start_time'}}}},
                "month": {"$month": {"date": {"$dateFromString": {"dateString": '$start_time'}}}},
                "trip_duration": 1,
                "start_station_id":1,
                "end_station_id":1
            }},
            {"$sort": {"hour": 1, "year": -1, "month": 1, "trip_duration": -1}},
            {
                "$match": {
                    "$and": [
                        {"hour": {"$gte": user_hour-1, "$lte": user_hour+1}},
                        {"trip_duration": {"$lte": trip_time + 120}}
                    ]
                }
            }
        ])
        if multiple: return result
        return result.next()
    
    def __choose_best_station(self, bike_station, stations, hour=None):
        next_station = None
        distance = None
        time = None
        for idx, station in enumerate(stations):
            if idx == 1:
                next_station = station
                distance = next_station['dist']
                next_station = BikeStation(next_station['id'], next_station['name'], next_station['loc']['coordinates'][1],  next_station['loc']['coordinates'][0])
                print(next_station)
                self.__find_trips_for_station(next_station, user_hour=hour)
                print("Distance: " + str(distance))
                break        
        return (next_station, distance, time)


    def find_first_station(self, location=None, hour=None):
        (lat, lon) = (location[0], location[1])
        # MongoDB Query
        stations = self.client.db['stations']
        result = stations.aggregate([
            {
                "$geoNear": {
                    "near": {"type":"Point", "coordinates": [lon, lat]},
                    "key": "loc",
                    "distanceField":"dist",
                    "spherical":True
                }
            }
        ]).next()
        return BikeStation(
            result['id'], result['name'], result['loc']['coordinates'][1],
            result['loc']['coordinates'][0]
        )


    def find_station_from_id(self, id):
        return self.client.db['stations'].find({
            'id':id
        }).next()


    def __find_next_station(self, station):
        (lat, lon) = (station.latitude, station.longitude)

        # MongoDB query
        trip = self.find_next_trip_station(station, self.trip_time*60, user_hour=self.user_time_of_query)

        # Handle results
        time = trip['trip_duration']/60
        next_station = self.find_station_from_id(trip['end_station_id'])

        station = BikeStation(
            next_station['id'], next_station['name'], 
            next_station['loc']['coordinates'][1], 
            next_station['loc']['coordinates'][0]
        )
        return (station , time)

    def find_starting_stations(self, first_station):
        stations = self.find_next_trip_station(first_station, self.trip_time, self.user_time_of_query, multiple=True)
        times = []
        seen_stations_ids = set()
        for s in stations:
            times.append(s['trip_duration']/60)
            seen_stations_ids.add(s['end_station_id'])
            if len(seen_stations_ids) == 5: break # just 5 first stations
        start_stations = [self.find_station_from_id(id) for id in seen_stations_ids]
        start_stations = []
        
        for id in seen_stations_ids: 
            result = self.find_station_from_id(id)
            start_stations.append(
                BikeStation(
                    result['id'], result['name'], result['loc']['coordinates'][1],
                    result['loc']['coordinates'][0]
                )
            )
        return (start_stations, times)

    def trip_builder(self, station):
        (starting_stations, times) = self.find_starting_stations(station)
        for i in range(len(starting_stations)):
            self.trips.append(Trip())
        distances = []
        for idx, s in enumerate(starting_stations):
            distance = self.__find_distance_between(station, s)
            self.trips[idx].add_two_stations(
                TwoStations(
                    origin=station, destination=s, distance=round(distance, 2),
                    time=times[idx]
                )
            )
        for idx, s in enumerate(starting_stations):
            self.trip_builder2(
                trip_time=self.trip_time, accumulated_time=times[idx],
                station = s, trip_idx=idx
            )


    def trip_builder2(self, trip_time, accumulated_time, station, trip_idx):
        if trip_time <= 10: # minutes
            return
        (next_station, time) = self.__find_next_station(station)
        accumulated_time += time
        trip_time -= time
        distance = self.__find_distance_between(station, next_station)
        self.trips[trip_idx].add_two_stations(
            TwoStations(
                origin=station, destination=next_station, distance=round(distance, 2), 
                time=round(accumulated_time,1), hour=self.original_time
            )
        )
        self.trip_builder2(trip_time, accumulated_time, next_station, trip_idx)
        
class TripsHandler:
    def __init__(self, location, trip_time, hour): #location: (lat, lon)
        self.location = location
        self.trip_time = trip_time
        self.hour = hour

    def start_trip_finder(self): 
        client = MongoDBClient(db_name='citi-bike')
        bsh = BikeStationHandler(client=client, trip_time=self.trip_time, accumulated_time=0, user_time_of_query=self.hour)
        first_station = bsh.find_first_station(self.location)
        bsh.trip_builder(first_station)
        self.pprint_trips(bsh.trips)

    def pprint_trips(self, trips):
        idx = 0
        for trip in trips:
            print(f"\nTrip #{idx+1}: [{trip.stations[len(trip.stations)-1].time} min]")
            for two_station in trip.stations:
                origin = two_station.origin
                destination = two_station.destination
                distance = two_station.distance 
                time = two_station.time
                print(f"\t{origin.name} -> {destination.name} in {round(time,1)} minutes and [{round(distance,2)} m]")
            idx += 1
            print("------------------------")
                

def main():
    client = MongoDBClient(db_name='citi-bike')

    # User input
    user_location = (40.75332044500726, -73.98230704636353)
    user_trip_time = 45 # minutes
    user_time_of_query = 16

    th = TripsHandler(user_location, user_trip_time, user_time_of_query)
    th.start_trip_finder()


if __name__ == '__main__':
    main()