from gcl import gcl, prim_root, is_prime
from data import read_stock_data
from plotnine import (
    aes, ggplot, labs,
    geom_histogram, geom_point
)
from numpy import var, average
from ks import estadistico_ks

def plot_unif(y: list[float], media_path: str = "media/") -> None:
    h = (
        ggplot(aes(x = y))
        + geom_histogram(bins = 25)
        + labs(title = "Histograma de gcl")
    )
    d = (
        ggplot(aes(x = range(0, len(y)), y = y))
        + geom_point()
        + labs(title = "Diagrama de dispersión de gcl")
    )
    d.save(media_path + "dispersion.png")
    h.save(media_path + "histogram.png")
    d.show()
    h.show()
    return y

def print_ej1(n:int = 3259, n_sims: int = 1000):
    q_is_prime = is_prime(n) 
    yes_or_no = "sí" if q_is_prime else "no"
    primitive_roots = prim_root(n)

    print(f"Veamos que {n} {yes_or_no} es número primo")
    print(f"Veamos que {n} tiene a {min(primitive_roots)} como su primera raíz primitiva")

    if q_is_prime:
        print("Un generador congruencial de periodo maximal es:")
        print("x_{n+1}=" + str(min(primitive_roots)) + "x_n")
        print("Con x_0 = 2")
        print(f"Simulando {n_sims} con gcl")
        sims = [ 2 ]
        for _ in range(n_sims):
            sims.append(gcl(sims[-1], min(primitive_roots), 0, n))
        print("Medidas de tendencia central de la simulación")
        print(f"Media: {average(sims)}")
        print(f"varianza: {var(sims)}")
        plot_unif(sims)

def print_ej2():
    print("Se descargaron los datos usando la funcion get_stock_data en data.py")
    df = read_stock_data()
    print(df.describe())
    print("Centrándonos en la col Close, calculamos su estadístico KS")
    print(df["Close"].to_list())
    est = estadistico_ks(df["Close"].to_list())
    print(est)

def main():
    print_ej2()


if __name__ == "__main__":
    main()
