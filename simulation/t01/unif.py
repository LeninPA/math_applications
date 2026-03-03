from gcl import gcl, normalize
from random import random
from math import inf
from pandas import DataFrame
from plotnine import *

def unif(n: int = 1) -> list[int]:
    # a = 1103515245
    # c = 12345
    # m = 2 ** 10
    # return normalize([gcl(time(), a, c, m) for _ in range(n)])
    return [random() for _ in range(n)]

def sim_max_unif_manual(n:int = 100)->float:
    return max(unif(n))

def sim_max_unif_inverse(n:int = 100)->float:
    return unif()[0] ** (1/n)

def construir_empirica(data: list[float]):
    l = sorted(data)
    n = len(data)
    p = [i/n for i in range(n)]
    # print(l)
    # print(p)
    def cdf(x: float)-> float:
        if x < l[0]:
            return 0.0
        if x == l[0]:
            return 1/n
        # if x == l[0]:
        #     return p[0]
        for idx, val in enumerate(l[:-1]):
            if x < val:
                return p[idx]
        return 1.0
    return cdf

def construir_inversa_generalizada(data: list[float]):
    l = sorted(data)
    n = len(data)
    def inv(p:float)-> float:
        if p < 0.0:
            return -inf
        for i in range(n):
            if p <= (i+1)/n:
                return l[i]
    return inv

def main():
    iters = int(100)
    method1 = [sim_max_unif_manual() for _ in range(iters)]
    method2 = [sim_max_unif_inverse() for _ in range(iters)]

    # d1 = {"method": for elem in method 1}

    # p = (
    #     ggplot(data=data, aes(x="n",y="manu"))
    #     + geom_point()
    # )
    # p.show()
    # p = (
    #     ggplot(aes(x=range(iters),y=method2))
    #     + geom_point()
    # )
    # p.show()

if __name__ == "__main__":
    main()
