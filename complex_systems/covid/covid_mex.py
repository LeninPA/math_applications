import pandas as pd
import math
from matplotlib.pyplot import *
import random

df = pd.read_csv("./casos_diarios_2.dat", sep="\t\t", header=None, index_col=0, names=["Casos"])
print(df.Casos)

def log_normal(x, norm, avg, dev):
    return (norm/x)*math.exp(-((math.log(x)-avg)/dev)**2)

def distancia(x1,x2):
    return (x1-x2)**2

scatter(range(1,196),df.Casos)

def ajuste(data, f, norm, avg, dev, k: int=100):
    n = len(data)
    for i in range(k):
        pred = [f(x, norm, avg, dev) for x in range(1,n+1)]
        norm_2 = norm + random.uniform(-1,1)
        avg_2 = norm + random.uniform(-1,1)
        dev_2 = norm + random.uniform(-1,1)
        new_pred = [f(x, norm_2, avg_2, dev_2) for x in range(1,n+1)]
        d1 = sum([distancia(pred[i],data.iloc[i]) for i in range(n)])/n
        d2 = sum([distancia(new_pred[i],data.iloc[i]) for i in range(n)])/n
        if d2 < d1:
            norm, avg, dev = norm_2, avg_2, dev_2
    return norm, avg, dev

n,a,s = 6000,1,1
(n,a,s) = ajuste(df.Casos, log_normal,n,a,s)
print(n,a,s)
plot(range(1,196),[log_normal(x, n,a,s) for x in range(1,196)])

show()