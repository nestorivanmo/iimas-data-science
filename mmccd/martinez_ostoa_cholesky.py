from general import *
from math import sqrt

def cholesky(A):
    L = []
    for i in range(0, len(A)):
        r = []
        for j in range(0, len(A[0])):
            if j > i:
                r.append(0)
            else:
                r.append(None)
        L.append(r)
    
    l11 = sqrt(A[0][0])
    for i in range(0, len(L)):
        L[i][0] = A[i][0] / l11

    for i in range(0, len(L)):
        for j in range(0, len(L[0])):
            if j < i or j == i:
                if j == i:
                    s = 0
                    for k in range(0, i):
                        s += L[j][k] ** 2
                    L[i][j] = sqrt(A[i][j] - s)
                else:
                    s = 0
                    for k in range(0, j):
                            s += L[i][k] * L[j][k]
                    L[i][j] = (1 / L[j][j]) * (A[i][j] - s)
    return L

def main():
    (A, n) = ask_for_squared_matrix()
    if equal_matrixes(A, transpose(A)):
        print("Matrix A:")
        print_matrix(A)
        print("Matrix L:")
        L = cholesky(A)
        print_matrix(L)
        print("Matrix L^T")
        LT = transpose(L)
        print_matrix(LT)
    else:
        print("Matrix A is not symmetric")

main()