from general import *

def initLU(n):
    L = []
    U = []
    for i in range(0, n):
        l = []
        u = []
        for j in range(0, n):
            if i == j :
                l.append(1)
                u.append(None)
            elif i < j:
                l.append(0)
                u.append(None)
            else:
                l.append(None)
                u.append(0)
        L.append(l)
        U.append(u)
    return (L,U)

def buildFirst(A, L, U):
    firstU = U[0]
    for i in range(0, len(firstU)):
        firstU[i] = A[0][i] / L[0][0]
    firstL = getFirstL(L)
    for i in range(0, len(firstL)):
        firstL[i] = A[i][0] / U[0][0]
    U[0] = firstU
    L = setFirstL(L, firstL)
    return (L, U)

def setFirstL(L, l):
    for i in range(0, len(l)):
        L[i][0] = l[i]
    return L

def getFirstL(L):
    first = []
    for i in range(0, len(L)):
        first.append(L[i][0])
    return first

def lu(A, L, U):
    for i in range(1, len(A)):
        for j in range(0, len(A[0])):
            if j >= i: #U
                s = 0
                for k in range(0, i):
                    s += L[i][k] * U[k][j]
                U[i][j] = A[i][j] - s
            else: #L
                if i > 1 and j > 0:
                    s = 0
                    for k in range(0, j):
                        s += L[i][k] * U[k][j]
                    L[i][j] = (1 / U[j][j]) * (A[i][j] - s)
    return (L, U)

def main():
    (A, n) = ask_for_squared_matrix()
    (L, U) = initLU(n)
    (L, U) = buildFirst(A, L, U)
    (L, U) = lu(A, L, U)
    print("A matrix:")
    print_matrix(A)
    print("L matrix:")
    print_matrix(L)
    print("U matrix:")
    print_matrix(U)

main()


