#!/usr/bin/env python

def estadistico_ks(data: list[float]) -> float:
    n = len(data)

    lim_sup = [ (i+1) / n for i in range(n) ]
    lim_inf = [ i   / n for i in range(n) ]
    
    dif_lim_sup = [ abs(data[i] - lim_sup[i]) for i in range(n)]
    dif_lim_inf = [ abs(data[i] - lim_inf[i]) for i in range(n)]
    
    return max(max(dif_lim_sup),max(dif_lim_inf))

def main():
    data = [0.1, 0.4, 0.7, 0.8, 0.9]
    print(estadistico_ks(data))

if __name__ == "__main__":
    main()
