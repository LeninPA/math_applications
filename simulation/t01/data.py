#!/usr/bin/env python

from yfinance import Ticker

def get_stock_data(ticker:str = "^GSPC", years:int=2, path:str = "data/sp500.csv"):
    t = str(years) + "y"
    stock = Ticker(ticker).history(period = t)
    stock.to_csv(path, encoding='utf-8')

def main():
    get_stock_data()

if __name__ == "__main__":
    main()
