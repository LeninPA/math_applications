#!/usr/bin/env python
from numpy import linspace

def inside(i:int, j:int, n:int=100, m:int=100):
    if i == 0 or j == 0 or i == n-1 or j == m-1:
        ...

def f_next(u:list[list[float]], dx:float, dy:float) -> float:
    """
    Calcula sig iteración de f
    """
    n, m = len(u), len(u[0])
    for i in range(m):
    if inside(i, j):
        termino_x = u[i+1][j] - 2 * u[i][j] + u[i-1][j]
        termino_y = u[i][j+1] - 2 * u[i][j] + u[i][j-1]
        return ( (termino_x) / (dx * dx) ) + ( (termino_y) / (dy * dy) )


def solver_2d(f, x_min, x_max, y_min, y_max, Nx, Ny):
    y_vals = linspace(x_min, x_max, Nx)
    x_vals = lisnpace(y_min, y_max, Ny)

    ...

def main():
    ...

if __name__ == "__main__":
    main()
