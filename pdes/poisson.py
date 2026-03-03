from math import cos, exp
from numpy import arange, zeros, fill_diagonal

def f(x):
    return (2 * cos(x))/exp(x)

def poisson(x_min:float, x_max: float, 
            u_0:float, u_n: float, 
            f, N:int = 100):
    # Related to the epsilon of the machine
    # N:int           = 1_000 
    # Separation between pts
    delta_x:float   = ( x_max - x_min ) / N 
    x_i:list[float] = []

    for i in arange( N + 1 ):
        x_i.append( x_min + i * delta_x )
    return x_i

def create_sparse_matrix(n: int, diag_val: float, lat_val: float):
    M = zeros((n,n))
    fill_diagonal(M, diag_val)
    for i in range(n):
        if 0 <= i - 1:
            M[i, i - 1] = lat_val
        if i + 1 <= n - 1:
            M[i, i + 1] = lat_val
    return M

def create_sol_vec():
    ...

def main():
    x_min =  0.0
    x_max = 10.0
    u_0   =  0.0
    u_n   =  0.0
    # N = 100
    print(poisson(x_min, x_max, u_0, u_n, f))
    print(create_sparse_matrix(6, 2.0, -1.0))

if __name__ == "__main__":
    main()
