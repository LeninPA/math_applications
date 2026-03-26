from math import sqrt, gamma, pi
from random import random, seed

def f(x:float):
    """Función a integrar"""
    return sqrt(1 - x * x)
def g(x_vals:list[float]):
    """Norma infinito de una esfera de dimensión len(x_vals)"""
    s = [ x * x for x in x_vals ]
    if sum(s) < 1:
        return 1
    return 0

def estimator(g,a:float, b:float, x_vals: list[float]):
    """
    Estimador de la integral definida de 'a' a 'b'
    de g usando Ley de los Grandes Números

    g: Callable - Función a integrar
    a: float - Límite inferior
    b: float - Límite superior
    x_vals: list[float] - Muestra aleatora de Unif(a,b)
    """
    N = len(x_vals)
    g_vals = [ g(x) for x in x_vals ]
    return ( (b - a) * sum(g_vals) )/N

def volume_of_sphere(R:float = 1.0, n:int = 10):
    """Fórmula analítica del volumen de una n-esfera"""
    return ( (pi ** (n/2)) / gamma((n/2) + 1) ) * (R ** n)

def estimator_volume_of_sphere(g, x_vals:list[list[float]]):
    N = len(x_vals)
    dim = len(x_vals[0])
    s = sum([ g(x) for x in x_vals ])
    return (2 ** dim) * (s) / N

def main():
    seed(51668900)
    a = 0.0
    b = 1.0
    for n in [10, 100, 1000, 10_000]:
        x_vals = [ (b-a) * random() + a for _ in range(n)]
        est = estimator(f, a, b, x_vals)
        print(f"{n=}, pi={est*4}")
    n = 1_000_000
    dim = 10
    data = [ [ 2 * random() - 1 for k in range(dim) ] for _ in range(n) ]
    print(f"Volumen de esfera, n=10, {volume_of_sphere()}")
    print(f"Sim. del vol. esfera, n=10, {estimator_volume_of_sphere(g, data)}")

if __name__ == "__main__":
    main()
