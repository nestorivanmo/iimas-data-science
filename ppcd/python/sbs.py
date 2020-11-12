class SBS():
    """ Sequential Backward Selection(SBS) es un algoritmo encargado de quitar características
    de un conjunto de datos para encontrar las k características más relevantes. 

    Parámetros
    ----------
    estimador: instancia de estimator
        Un estimador sin ajuste (KNClassifier por ejemplo)

    k_caracteristicas: int
        número de características a las que quieres reducir tu conjunto de características

    rendimiento: 
        accuracy_score proveniente de scikit learn

    tamaño_entrenamiento: int
        porcentaje de pruebas vs porcentaje de entrenamiento

    random_state: int
        booleano para determinar si usamos random state o no

    """
  def __init__(self, estimador, k_caracteristicas, rendimiento=accuracy_score, tamaño_entrenamiento=0.25, random_state=1):
    self.rendimiento = rendimiento
    self.estimador = copy(estimador)
    self.k_caracteristicas = k_caracteristicas
    self.tamaño_entrenamiento = tamaño_entrenamiento
    self.random_state = random_state
  
  def fit(self, X, y):
    """fit() es la función encargada de llevar a cabo el algoritmo de SBS

    Parámetros
    ----------
    X: list
        matriz de características (espacio de características)

    y: list
        vector objetivo del SBS

    Salida
    ------
    Instancia de la clase SBS
  
    """
    X_train, X_test, y_train, y_test = train_test_split(X, y, tamaño_entrenamiento = 
                            self.tamaño_entrenamiento, random_state = self.random_state)
    dim = X_train.shape[1]
    self.indices_ = tuple(range(dim))
    self.subsets_ = [self.indices_]
    puntaje = self.calcular_rendimiento(X_train, y_train, X_test, y_test, self.indices_)
    self.puntajes_ = [puntaje]
    while dim > self.k_caracteristicas:
      puntajes = []
      subsets = []
      for p in combinations(self.indices_, r=dim-1):
        puntaje = self.calcular_rendimiento(X_train, y_train,
                           X_test, y_test, p)
        puntajes.append(puntaje)
        subsets.append(p)
      best = np.argmax(puntajes)
      self.indices_ = subsets[best]
      self.subsets_.append(self.indices_)
      dim -= 1
      self.puntajes_.append(puntajes[best])
    self.k_puntaje_ = self.puntajes_[-1]
    return self

  def calcular_rendimiento(self, X_train, y_train,
                    X_test, y_test, indices):
      """función encargada de evaluar el rendimiento del modelo antes y después de eliminar una columna
      
      Parámetros
      ----------
      X_train: list
        matriz de datos iniciales a entrenar

      y_train: list
        vector de objetivos a entrenar

      X_test: list
        matriz de datos iniciales para hacer pruebas 

      y_test: list
        vector de objetivos para hacer pruebas

      """  
      self.estimador.fit(X_train[:, indices], y_train)
      y_pred = self.estimador.predict(X_test[:, indices])
      puntaje = self.rendimiento(y_test, y_pred)
      return puntaje