from general import *

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

A = []
rows = int(input("Rows of the matrix: "))
if rows <= 0:
  print("Size should only be greater than 1")
else:
  for i in range(0, rows):
    row = []
    for j in range(0, rows + 1):
      e = int(input("Element ({}, {}): ".format(i, j)))
      row.append(e)
    A.append(row)
print_matrix(A)
element = 0
for i in range(0, len(A)):
  element = A[i][i]
  if element == 0:
    A = swap(i, A)
    element = A[i][i]
  A = norm(i, A)
  A = operate(i, A)
  print_matrix(A)