#!/usr/bin/env python
# from plotnine import *
from math import gcd

def gcl(x_n:int , a: int, c:int, m:int)->int:
    return (a * x_n + c ) % m

def normalize(vals:list[int])->list[float]:
    max_val = max(vals)
    return [v/max_val for v in vals]

def is_prime(n:int)-> bool: 
    for i in range(2, n): #for every value between 1 and n
        if n % i == 0: #check if i divides n
            return False #if this is true, n is not prime
    return True if n > 1 else False #values less than 2 are not prime.

def prim_root(m:int) -> list[int]:
    required_set = { n for n in range(1, m) if gcd(n, m) }
    return [ g for g in range(1,m) if required_set == { pow(g, powers, m) for powers in range(1, m) } ]

def main():
    # print(len(prim_root(3259)))
    print(len(prim_root(3229)))
    print(len(prim_root(3221)))
    print(len(prim_root(3217)))

if __name__ == "__main__":
    main()
