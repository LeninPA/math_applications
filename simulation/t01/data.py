#!/usr/bin/env python

from yfinance import Ticker

def get_data(tick:str = "^GSPC", years:int = 2, data_path:str = "data/"):
    sp500 = Ticker(tick).history(period = f"{years}y")
    print(sp500.describe())
    sp500.to_csv(data_path + "sp500.csv", encoding='utf-8')

def main():
    get_data()
