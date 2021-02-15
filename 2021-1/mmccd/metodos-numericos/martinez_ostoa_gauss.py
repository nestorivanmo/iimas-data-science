from general import *
import numpy as np

def swap(row, A):
  pr = -1
  if row < len(A) - 1:
    for i in range(row + 1, len(A)):
      if A[i][row] != 0:
        pr = i
        break
  else:
    return A
  x = A.pop(row)
  y = A.pop(pr - 1)
  A.insert(row, y)
  A.insert(pr, x)
  return A

def norm(row, A):
  r = A[row]
  e = r[row]
  for i in range(0, len(r)):
    r[i] /= e 
  return A

def operate(row, A):
  for i in range(row + 1, len(A)):
    e = A[i][row] * (-1)
    for j in range(0, len(A[row])):
      A[i][j] += A[row][j] * e
  return A

def solve(A):
    X = [A[A.shape[0]-1][-1]]
    sol_index = -2
    for row in range(A.shape[0]-2,-1,-1):
        stored_sol_idx = sum_ = 0
        for sol_col in range(-1, sol_index-1, -1):
            if sol_col == -1:
                sum_ += A[row][sol_col]
                continue
            sum_ -= A[row][sol_col]*X[stored_sol_idx]
            stored_sol_idx += 1
        X.append(sum_)
        sol_index -= 1
    return np.array(X)[::-1]

def gauss(A, B=None):
    if B is not None:
        A = np.append(A, B, axis=1)
    for i in range(len(A)):
        element = A[i][i]
        if element == 0:
            A = swap(i, A)
            element = A[i][i]
        A = norm(i, A)
        A = operate(i, A)
    return solve(A)


#A = np.array([[-4, -3, 1], [8, 11, -1], [4, 18, 5]]) #LU
#A = np.array([[6, 15, 55], [15, 55, 225], [55, 225, 979]]) #Cholesky
#A = np.array([[-1, -1, 1], [1, 3, 3], [-1, -1, 5], [1, 3, 7]]) #QR

A = np.array([
  [-4,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0],
  [1,-4,1,0,0,0,1,0,0,0,0,0,0,0,0,0],
  [0,1,-4,1,0,0,0,1,0,0,0,0,0,0,0,0],
  [0,0,1,-4,1,0,0,0,1,0,0,0,0,0,0,0],
  [0,0,0,1,-4,0,0,0,0,1,0,0,0,0,0,-70.710678],
  [1,0,0,0,0,-4,1,0,0,0,1,0,0,0,0,0],
  [0,1,0,0,0,1,-4,1,0,0,0,1,0,0,0,0],
  [0,0,1,0,0,0,1,-4,1,0,0,0,1,0,0,0],
  [0,0,0,1,0,0,0,1,-1,1,0,0,0,1,0,0],
  [0,0,0,0,1,0,0,0,1,-4,0,0,0,0,1,-100],
  [0,0,0,0,0,1,0,0,0,0,-4,1,0,0,0,0],
  [0,0,0,0,0,0,1,0,0,0,1,-4,1,0,0,0],
  [0,0,0,0,0,0,0,1,0,0,0,1,-4,1,0,0],
  [0,0,0,0,0,0,0,0,1,0,0,0,1,-4,1,0],
  [0,0,0,0,0,0,0,0,0,1,0,0,0,1,-4,-70.710678]
])

S = gauss(A)
print(S)