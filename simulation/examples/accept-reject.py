#!/usr/bin/env python

from random import random

def unif(n:int = 1, a:float = 1.0, b:float = 0.0):
    return [a * random() + b for _ in range(n)]

def sim_f(f, x: tuple[float], y: tuple[float], n: int=1):
    total = 0
    sims = []
    while len(sims) < n:
        sim_x = unif(a = x[0], b = x[1])[0]
        sim_fx = unif(a = y[0], b = y[1])[0]
        if sim_x < f(sim_x):
            sims.append(sim_fx)
        total += 1
    return sims, total

def main():
    f = lambda x: (3/4) * (1 - x ** 2)
    sims, total = sim_f(f, (2.0, -1.0), (0.75,0), n = 5)
    print(sims)
    print(total)

if __name__ == "__main__":
    main()
