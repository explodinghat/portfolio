# Author: Matt Warren
# Created - May 2021
# Python re-creation of credit.c (also available in portfolio)
# Exercise completed as part of Harvard University's CS50 track


import cs50
import re


def main():
    while(1):
        num = cs50.get_int("Enter card number: ")
        cc = str(num)
        i = len(cc)
        if(i != 13 and i != 15 and i != 16):
            print(f"INVALID")
            return 0
        checkSum = cc_valid(cc)
        if(checkSum == "INVALID"):
            print(f"INVALID")
            return 0
        elif(checkSum == "VALID"):
            check_card(cc, i)
            return 0


def luhn_checksum(card_number):
    def digits_of(n):
        return [int(d) for d in str(n)]
    digits = digits_of(card_number)
    odd_digits = digits[-1::-2]
    even_digits = digits[-2::-2]
    checksum = 0
    checksum += sum(odd_digits)
    for d in even_digits:
        checksum += sum(digits_of(d*2))
    return checksum % 10


def cc_valid(card_number):
    if(luhn_checksum(card_number) == 0):
        return("VALID")


def check_card(card_number, i):
    first = (int(card_number[0]))
    second = (int(card_number[1]))
    if(first == 3 and second == 4 or second == 7):
        print("AMEX")
    if(first == 5 and 1 <= second <= 5):
        print("MASTERCARD")
    if(first == 4):
        print("VISA")


main()