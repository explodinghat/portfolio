// Author: Matt Warren
// Created - Mar/April 2021
// Submission for 'Mario (More comfortable)' Exercise as part of Harvard's CS50 track

#include <cs50.h>
#include <stdio.h>

int main()
{
    // We want to ask the user how tall their pyramid will be. Height will be 'height'
    // If the user doesn't enter a positive integer between 1-8, they will be re-prompted
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (!(height < 9 && height > 0));


    // We want to create a pyramid of hashes based on user input (height) that looks per line like '###  ###'
    // We want the number of hashes each side of the double space to be equal to height
    // Eg if the input height is 4 - the line will look like '#### ####'

    // We want the program to loop through each line of hashes starting from 1 and looping until we reach height
    // In every iteration on the loop, we print the left side spaces/ hashes, two spaces, then the right side
    // hashes/spaces, and a new line.

    int i = 0;
    string hash = "#";
    string doubleSpace = "  ";
    string singleSpace = " ";

    while (i < height)
    {
        // We want to loop through each side of the pyramid and print a set number of space or
        // hashes depending on which line we're on
        // We could likely do this better if we compiled a list for each side of the pyramid,
        // printed the list, then created a new list with the values reversed and printed this

        // For the timebeing though, we write this out as 4 individual 'while' loops

        // We start by defining integers that will be used within the loops
        int x = 0;
        // spLeft must be height - x - 2, as the maximum number of spaces in one section will be 7, and we are starting 'x' from 0
        int spLeft = height - x - 2;
        // One for the number of spaces placed before the hashes on the left side
        while (spLeft >= i)
        {
            printf("%s", singleSpace);
            spLeft--;
        }
        // One for the number of hashes on the left side
        while (x <= i)
        {
            printf("%s", hash);
            x++;
        }
        // We print out the double-space for the centre 'column'
        printf("%s", doubleSpace);

        // C does not seem to let me re-use the existing variables for the right section, so we define new variables instead
        int y = 0;
        // spRight must be height - y - 2, as the maximum number of spaces in one section will be 7, and we are starting 'y' from 0
        //int spRight = height - y - 2;

        // One loop for the number of hashes on the right side
        while (y <= i)
        {
            printf("%s", hash);
            y++;
        }
        // the spaces in the right section have been removed, as they are not required to make the program function
        // One loop for the number of spaces on the right side
        //while (spRight >= i)
        //{
        //    printf("%s", singleSpace);
        //    spRight--;
        //}
        printf("\n");
        i++;
    }



}