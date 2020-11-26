"""
Pseudocódigo
1. Inicializar una cantidad n de filosofos (Process)
n. Escoger uno de los n filósofos para que sea zurdo (i.e., tome siempre primero el tenedor de la izquierda)
2. Inicializar una cantidad n de tenedores libres (definidos con enteros positivos) (Semaphore)
3. Iterar un tiempo indefinido
  3.1 Cada proceso estará pensando hasta que le de hambre
  n.n Si el proceso es el zurdo:
        Adquirir el tenedor de la izquierda primero
        Adquirir el tenedor de la derecha segundo
      De lo contrario:
        Adquirir tenedor derecha
        Adquirir tenedor izquierda
  3.3 El proceso i estará comiendo (aquí hay que evitar que el proceso i se ponga a pensar)
  3.4 El proceso i terminará de comer y liberará los tenedores (V operation)

  |  0  |
0        0
  |  0 |



process F[i]
semaphore tenedores[n]

while True {

  F[i].pensar()

  P(tenedores[i]) //derecha
  P(tenedores[(i+1) mod n]) //izquierda

  F[i].comer()

  V(tenedores[i])
  V(tenedores[(i+1) mod n])
}

P1 -> sema 1 -> sema 0 (P)
P2 -> sema 0 -> sema -1 (P) P2 se vaya a dormir
P3 -> sema -1 -> sema -2 (P) P3 se va a dormir
P1 -> libere 1 (V) -> P2 se despierta

"""