from gcl import gcl, normalize
from random import random
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

def main():
    iters = int(100)
    method1 = [sim_max_unif_manual() for _ in range(iters)]
    method2 = [sim_max_unif_inverse() for _ in range(iters)]

    d1 = {"method": for elem in method 1}

    p = (
        ggplot(data=data, aes(x="n",y="manu"))
        + geom_point()
    )
    p.show()
    p = (
        ggplot(aes(x=range(iters),y=method2))
        + geom_point()
    )
    p.show()

if __name__ == "__main__":
    main()
