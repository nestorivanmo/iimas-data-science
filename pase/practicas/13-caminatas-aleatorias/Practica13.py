import random
import matplotlib.pyplot as plt
import numpy as np
import time

def caminata(M, p):
    valores_caminata = [M]
    m = M #capital de la persona
    i = 0
    while m > 0 and m < 2*M:
        n = random.randint(0, 1)
        if n <= p:
            m += 1
        else:
            m -= 1
        valores_caminata.append(m)
        i += 1
    return valores_caminata

def ejercicio1():
    plt.figure(figsize=(11,6))
    caminatas = []
    for _ in range(5):
        caminatas.append(caminata(50, 0.5))
    for i in range(5):
        plt.plot(caminatas[i])
    plt.xlabel("Pasos")
    plt.ylabel('Capital con M=50 inicial')
    plt.show()


def obten_media(M, K, p=0.5):
    taos=[len(caminata(M, p)) for _ in range(K)]
    return np.mean(taos)

def ejercicio2():
    print("Ejercicio 2:")
    Ms = [20, 50, 80, 150]
    Ks = [100, 200, 400]
    esperanzas = []
    for M in Ms:
        for K in Ks:
            media = obten_media(M, K)
            esperanzas.append((M, K, media))
    print(esperanzas)
    # [(20, 100, 368.74), (20, 200, 422.95), (20, 400, 405.835),
    # (50, 100, 2146.9), (50, 200, 2389.5), (50, 400, 2385.435),
    # (80, 100, 6944.78), (80, 200, 7181.42), (80, 400, 6325.295),
    # (150, 100, 20607.32), (150, 200, 25127.49), (150, 400, 22722.0)]

def caminata2(M, p):
    valores_caminata = [M]
    m = M #capital de la persona
    i = 0
    while m > 0:
        n = random.randint(0, 1)
        if n <= p:
            m += 1
        else:
            m -= 1
        valores_caminata.append(m)
        i += 1
    return valores_caminata

def ruina(M, K, p=0.5):
    taos=[len(caminata2(M, p)) for _ in range(K)]
    return np.mean(taos)

def ejercicio3():
    print("Ejercicio 3:")
    Ms = [20, 50, 80, 150]
    Ks = [100, 200, 400]
    esperanzas = []
    for M in Ms:
        for K in Ks:
            media = ruina(M, K)
            esperanzas.append((M, K, media))
    print(esperanzas)

if __name__ == '__main__':
    #ejercicio1()
    t = time.time()
    ejercicio2()
    print(time.time() - t)
    # ejercicio3()
