# Author: Matt Warren
# Created - May 2021
# Python re-creation of mario (more comfortable) (also available in portfolio)
# Exercise completed as part of Harvard University's CS50 track

import cs50


def main():
    # We want to ask the user how tall their pyramid will be. Height will be 'height'
    # If the user doesn't enter a positive integer between 1-8, they will be re-prompted
    height = get_height()

    i = 0
    hashes = "#"
    doubleSpace = "  "
    singleSpace = " "

    while (i < height):
        x = 0
        spLeft = height - x - 2
        while (spLeft >= i):
            print(singleSpace, end="")
            spLeft -= 1
        while (x <= i):
            print(hashes, end="")
            x += 1
        print(doubleSpace, end="")
        y = 0
        while (y <= i):
            print(hashes, end="")
            y += 1
        print("")
        i += 1


def get_height():
    height = cs50.get_int("Enter the pyramid's height: \n")
    if (height > 8 or height < 1):
        height = get_height()
    return height


main()