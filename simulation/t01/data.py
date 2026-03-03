#!/usr/bin/env python

from yfinance import Ticker
from pandas import read_csv

def get_stock_data(ticker:str = "^GSPC", years:int=2, path:str = "data/sp500.csv"):
    t = str(years) + "y"
    stock = Ticker(ticker).history(period = t)
    stock.to_csv(path, encoding='utf-8')

def read_stock_data(path:str = "data/sp500.csv"):
    return read_csv(path)

def main():
    # get_stock_data()
    print(read_stock_data())

if __name__ == "__main__":
    main()
