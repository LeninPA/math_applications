#!/usr/bin/env python

from random import random
from math import exp
from numpy import var
from itertools import accumulate
import matplotlib.pyplot as plt

def mean_by_mc(n:int= 10_000, show: bool = False):
    sims = [exp(random()) for _ in range(n)]
    theta = sum(sims)/n
    if show:
        evolution = [ elem/(idx + 1) for idx, elem in enumerate(accumulate(sims))]
        plt.plot(range(n), evolution)
        plt.show()
    return theta, var(sims)

def mean_by_est(n:int = 10_000, show = False):
    m = n//2
    est_1 = [exp(random()) for _ in range(m)]
    est_2 = [exp(1 - random()) for _ in range(m)]
    est = [(e1+e2)/2 for e1, e2 in zip(est_1, est_2)]
    if show:
        evolution = [ elem/(idx + 1) for idx, elem in enumerate(accumulate(est))]
        plt.plot(range(m), evolution)
        plt.show()
    return sum(est) / m, var(est)

def main():
    print("Estimación montecarlo")
    print(mean_by_mc(show = True))
    print("Estimación reduciendo varianza")
    print(mean_by_est(show = True))

if __name__ == "__main__":
    main()
