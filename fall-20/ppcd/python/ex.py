import numpy as np

class Perceptron():
  def __init__(self, eta):
    self.eta = eta
  
  def fit(self, X, y):