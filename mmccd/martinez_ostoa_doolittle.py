def initLu(n):
  L = []
  U = []
  for i in range(0, n):
    l = []
    u = []
    for j in range(0, n):
      if i == j:
        l.append(1)
        u.append(None)
      elif i < j:
        l.append(None)
        u.append(0)
      else:
        l.append(0)
        u.append(None)
  return (L, U)

def doolittle(A, n):
  L = []
  U = []

  return (L, U)