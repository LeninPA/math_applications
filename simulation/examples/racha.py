from math import sqrt

def detecta_racha(n:int, n1: int, n2: int) -> list:
    b = n1 + n2
    mu = ((2 * n1 * n2) / n ) + 1
    var = (2 * n1 * n2 * (2 * n1 * n2 - n)) / ((n ** 2) * (n - 1))
    z0 = (b - mu) / sqrt(var)
    return z0

print(detecta_racha(8, 1, 3))
