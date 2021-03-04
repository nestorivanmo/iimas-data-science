import numpy as np

class Perceptron(object):
  def __init__(self, eta=0.01, n_iter=50, random_state=1):
    self.eta = eta
    self.n_iter = n_iter
    self.random_state = random_state
  
  def fit(self, X, y):
    rgen = np.random.RandomState(self.random_state)
    if self.random_state is None:
      self.w_ = np.zeros(1 + len(X[1]))
    else:
      self.w_ = rgen.normal(loc=0.0, scale = 0.1, size = 1 + X.shape[1])

    self.errors_ = []
    for _ in range(self.n_iter):
      errors = 0
      for xi, yi, in zip(X, y):
        update = self.eta * (yi - self.predict(xi))
        self.w_[1:] += update * xi
        self.w_[0] += update
        errors += int(update != 0.0)
      self.errors_.append(errors)
    return self

  def predict(self, X):
    return np.where(self.net_input(X) >= 0.0, 1, -1)

  def net_input(self, X):
    return np.dot(X, self.w_[0] + self.w_[1:])

if __name__ == '__main__':
  #Implementación - pruebas
  X = np.array([[0, 0], [0, 1], [1, 0], [1, 1]])
  y = np.array([1 ,1, 1, -1])
  ppn = Perceptron(n_iter=6, eta=0.1)
  ppn.fit(X, y)
  print('Pesos: ', ppn.w_)