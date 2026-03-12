#!/usr/bin/env python
from numpy import linspace

def solver():
    ...

def solve_at_time_t():
    ...

def T(t:int, x:float, 
      a:float, b:float, c:float, 
      k:float, x_max:float):
    if t == 0:
        return a 
    if x == 0:
        return b
    if x == x_max:
        return c

def next_T():
    ...

def main():
    # Condiciones iniciales
    x_min =  0.0
    x_max = 10.0
    N = 1000
    Nt = 100
    x_vals, dx = linspace(x_min, x_max, N, retstep = True)
    t_vals     = list(range(Nt))

if __name__ == "__main__":
    main()
