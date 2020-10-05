from os import system, name

def clear():
    if name == 'nt':
        _ = system('cls')
    else:
        _ = system('clear')

def print_matrix(A):
  print("")
  for i in range(0, len(A)):
    for j in range(0, len(A[i])):
      if j == len(A[i]) - 1 and i == len(A) - 1:
        print("", A[i][j])
      else:
        print("", A[i][j], ",", end='')
    print("")

def ask_for_squared_matrix():
    A = []
    rows = int(input("Rows of the matrix: "))
    if rows <= 0:
        print("Size should only be greater than 1")
    else:   
        for i in range(0, rows):
            row = []
            for j in range(0, rows):
                e = int(input("Element ({}, {}): ".format(i, j)))
                row.append(e)
            A.append(row)
    clear()
    return (A, rows)

def transpose(A):
    T = []
    for i in range(0, len(A[0])):
        r = []
        for j in range(0, len(A)):
            r.append(0)
        T.append(r)
    for i in range(0, len(T)):
        for j in range(0, len(T[0])):
            T[i][j] = A[j][i]
    return T

def equal_matrixes(A, B):
    if len(A) == len(B) and len(A[0]) == len(B[0]):
        equal = True
        for i in range(len(A)):
            for j in range(len(A[i])):
                if A[i][j] == B[i][j]: 
                    pass
                else:
                    equal = False
                    break
        return equal
    else:
        return False