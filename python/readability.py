# Author: Matt Warren
# Created - May 2021
# Python re-creation of readability.c 
# Exercise completed as part of Harvard University's CS50 track


import cs50


def main():
    userInput = cs50.get_string("Text: ")
    letter_Count = sum(i.isalpha() for i in userInput)
    word_Count = sum(i.isspace() for i in userInput) + 1
    sentence_Count = userInput.count(".") + userInput.count("!") + userInput.count("?")
    readingLevel(letter_Count, word_Count, sentence_Count)
    return 0


def readingLevel(letter_Count, word_Count, sentence_Count):
    letterAverage = letter_Count / word_Count * 100

    sentenceAverage = sentence_Count / word_Count * 100

    index = round(0.0588 * letterAverage - 0.296 * sentenceAverage - 15.8)

    if(index > 16):
        print(f"Grade 16+")
    elif(index < 1):
        print(f"Before Grade 1")
    else:
        print(f"Grade {index}")
        return 0


main()