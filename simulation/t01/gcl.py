#!/usr/bin/env python
# from plotnine import *

def gcl(x_n:int , a: int, c:int, m:int)->int:
    return (a * x_n + c ) % m

def normalize(vals:list[int])->list[float]:
    max_val = max(vals)
    return [v/max_val for v in vals]

def main():
    params = [
        # (m, a, c, x_0)
        (8,5,3,0),
        (8,4,1,0),
        (10,3,0,1),
        (11,2,0,1),
        (10,11,3,0),
        (16, 5, 0, 12),
        (16, 1, 0, 12),
        (16, 5, 0, 1),
        # (2 ** 37, 5, 5, 10)
    ]

    n = 10

    for p in params:
        m, a, c, x_0 = p
        steps = [gcl(x_0, a, c, m)]
        for _ in range(n):
            steps.append(gcl(steps[-1], a, c, m))
        print(f"{m=}|{a=}|{c=}|{x_0=}")
        # x = steps[:-1]
        # y = steps[1:]
        print(steps)
        print(normalize(steps, m))
        # p = (
        #     #ggplot(aes(x=range(n+1),y=steps))
        #     ggplot(aes(x=x,y=y))
        #     + geom_point()
        # )
        # p.show()

if __name__ == "__main__":
    main()
