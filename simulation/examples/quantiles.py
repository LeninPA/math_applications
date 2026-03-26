#!/usr/bin/env python
"""
quantiles.py

Quantile estimation using montecarlo integration
"""

from math import sqrt, exp, pi
from montecarlo import (
        estimator,
        volume_of_sphere, estimator_volume_of_sphere, g
)
from numpy import linspace
from random import random


def norm(x:float, mu:float = 0.0, sigma_2:float = 1.0)->float:
    return exp( - ( x - mu ) * (x - mu) / ( 2 * sigma_2 ) ) / sqrt( 2 * pi * sigma_2 )

def main():
    N = 10_000
    # ---------------------------------------------
    # 2026-03-13-E1
    # ---------------------------------------------
    print("Estimando el cuantil 95 con montecarlo")
    a = -4
    b = 1.65
    s = estimator(norm, a, b, linspace(a, b, N))
    print(s)
    # ---------------------------------------------
    # 2026-03-13-E2
    # ---------------------------------------------
    print("El volumen de una esfera de tres dimensiones es:")
    print(volume_of_sphere(n = 3))
    print("La estimación con montecarlo es")
    points = [[random() for k in range(3)] for _ in range(N)]
    print(estimator_volume_of_sphere(g, points))


if __name__ == "__main__":
    main()
