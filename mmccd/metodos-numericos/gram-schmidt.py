"""
Entrada del programa matriz cuadrada A de orden n
Saldida: Matrices Q, R cuadradas de orden n

Módulos:
1. Independencia de Vectores
    Entrada:
        ndarray 
    Salida:
        true si es l.i.
        false eoc

2. 
    Crear ui=ai-(ai*e1)e1-...-(ai*ei_1)ei_1
        Entrada: ai,e
            E: {e1, ..., ei_1}
            Q:[e1^T|...|en^T]
        Salida: ui
        
        Operacion
        ui=ai-sum((a@Q)*Q)
        ai 1xn 
        Q nxi_1
        
    Crear ei=ui/||ui||
        Entrada: ui
        Salida: ei

3. Constructores de matrices
    build_Q:
        Entrada: vectores e
        Salida: Matriz Q conformada por los vectores e transpuestos
    
    build_R:
        Entrada: vectores e, matriz A
        Salida: Matriz R conformada por la multiplicación de ei*(ai,...,an)
                ** R debe ser una triangular superior
"""

import numpy as np
from numpy.linalg import norm, det

def validate(A):
    assert A.shape[0] == A.shape[1], "La matriz no es cuadrada"
    assert det(A) != 0, "Los vectores no son linealmente independientes"

def QR(A):
    #validate(A)
    n = A.shape[1]
    u = np.zeros(A.shape)
    Q = np.zeros(A.shape)
    R = np.zeros(A.shape)
    
    for i in range(n):
        Qi = Q[:, :i]
        ai = A[:, i]
        u[:,i] = ai - (ai @ Qi) @ Qi.T
        Q[:,i] = u[:,i] / norm(u[:,i]) 
        
        R[:(i+1), i] = ai @ Q[:, :(i+1)] 

    return Q, R[:i+1, :]

if __name__ == "__main__":
    A = np.array([[-1, -1, 1], [1, 3, 3], [-1, -1, 5], [1, 3, 7]]) #QR
    A = np.array([[-4, -3, 1], [8, 11, -1], [4, 18, 5]]) #LU
    A = np.array([[6, 15, 55], [15, 55, 225], [55, 225, 979]]) #Cholesky
    (Q, R) = QR(A)
    print("A:")
    print(A)
    print("Q:")
    print(Q)
    print("R:")
    print(R)
    print("QR:")
    print(np.matmul(Q,R))