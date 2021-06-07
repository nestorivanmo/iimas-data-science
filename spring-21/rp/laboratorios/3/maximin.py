import numpy as np
import pandas as pd
import plotly.express as px
import scipy.special
import itertools

class Builder:
	def __init__(self, path_to_csv):
		self.df = pd.read_csv(path_to_csv)
		self.data = []

	def build_data(self, x_name, y_name):
		for idx, row in self.df.iterrows():
			p1 = row[x_name]
			p2 = row[y_name]
			point = Point(x=p1, y=p2)
			self.data.append(point)
		return self.data

class Algorithm:
	def euclidean_distance(self, a, b):
		return np.sqrt((a.x - b.x)**2 + (a.y - b.y)**2)

class Point:
	def __init__(self, x, y):
		self.x = x
		self.y = y
		self.class_idx = None

	def __str__(self):
		return f"Point: ({self.x}, {self.y}) Class: {self.class_idx}"

	def euclidean_distance(self, other_point):
		return np.sqrt((self.x - other_point.x)**2 + (self.y - other_point.y)**2)

class PointClass:
	def __init__(self, representative):
		self.representative = representative
		self.members = [] # [<Point>]

	def add_member(self, member):
		"""
		member: <Point>
		"""
		self.members.append(member)

	def __str__(self):
		return f"Representative: {self.representative}\nNum members: {len(self.members)}"

	def get_members(self, data):
		members = []
		for p in data:
			if p.class_idx == self.representative.class_idx:
				members.append(p)
		return members

class Maximin:
	def __init__(self, path_to_csv=None, x_name=None, y_name=None, data=None, f=0.5):
		try:
			if data is not None:
				self.data = data
			else:
				print("here")
				builder = Builder(path_to_csv)
				self.data = builder.build_data(x_name, y_name)
			self.points_classes = [] #[<PointClass>]
			self.f = f
		except:
			raise Exception("Error while initializing Maximin")

	def print_status(self):
		for idx, pc in enumerate(self.points_classes):
			print(f"------------- Class #{idx+1} ------------")
			print(f"Representative:\n\t{pc.representative}")
			print("Members: ")
			for p in self.data:
				if p.class_idx == pc.representative.class_idx:
					print(f"\t{p}")
			print("\n")

	def __find_farthest_point(self, point_class):
		"""
		We don't have to check if the euclidean distance is less than the min allowed
		distance since this function is only called after checking that all the points
		have at least one element with a greater distance
		"""
		try:
			representative = point_class.representative
			members = []
			for p in self.data:
				if p.class_idx == representative.class_idx:
					members.append(p)
			max_distance = -1
			max_idx = -1
			for idx, m in enumerate(members):
				d = m.euclidean_distance(representative)
				if d > max_distance:
					max_distance = d
					max_idx = idx
			return members[max_idx]
		except:
			raise Exception("Error while finding the farthest point")

	def choose_representative(self):
		try:
			if self.points_classes == []:
				return self.data[0]
			else:
				curr_class = self.points_classes[-1]
				new_representative = self.__find_farthest_point(curr_class)
				#print(f"\tFarthest point: {new_representative}")
				return new_representative
		except:
			raise Exception("Error while choosing representative")

	def __get_max_distance(self):
		if len(self.points_classes) < 2:
			return 0
		M = len(self.points_classes)
		representatives_indices = list(range(0, M))
		distance = 0
		for comb in itertools.combinations(representatives_indices, 2):
			Z1 = self.points_classes[comb[0]].representative
			Z2 = self.points_classes[comb[1]].representative
			distance += Z1.euclidean_distance(other_point=Z2)
		return self.f * distance


	def new_class_allowed(self):
		if self.points_classes == []: return True
		else:
			max_distance = self.__get_max_distance()
			for pc in self.points_classes:
				Zi = pc.representative
				for m in pc.get_members(self.data):
					if Zi.euclidean_distance(other_point=m) > max_distance:
						return True
			return False

	def auto_classification(self):
		representatives = [pc.representative for pc in self.points_classes]
		points = []
		for point in self.data:
			min_distance = 1e20
			min_repr_idx = None
			for r in representatives:
				d = point.euclidean_distance(r)
				if d < min_distance:
					min_distance = d
					min_repr = r
			#print(f"\t{point} --> {min_distance} --> {min_repr}")
			if point not in representatives:
				point.class_idx = min_repr.class_idx
				points.append(point)
		self.data = points


	def classify(self):
		try:
			if len(self.points_classes) == 1:
				pc = self.points_classes[0]
				for p in self.data: p.class_idx = 1
			else:
				self.auto_classification()
		except:
			raise Exception("Error while classifying")


	def run_(self, verbose=False):
		while self.new_class_allowed():
			representative = self.choose_representative()
			representative.class_idx = len(self.points_classes) + 1
			self.points_classes.append(PointClass(representative))
			self.classify()
		if verbose:
			self.print_status()
		return self.data


if __name__ == '__main__':
	# Textbook example
# 	data = [
# 		Point(0,0),
# 		Point(3,8),
# 		Point(2,2),
# 		Point(1,1),
# 		Point(5,3),
# 		Point(4,8),
# 		Point(6,3),
# 		Point(5,4),
# 		Point(6,4),
# 		Point(7,5),
# 	]
#
# 	data = Maximin(data=data).run_(verbose=True)

	# Iris dataset
	data = Maximin(path_to_csv='iris.csv', x_name='sepal_length', y_name='petal_width').run_(verbose=True)



