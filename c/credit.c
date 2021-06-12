// Author: Matt Warren
// Created - Mar/April 2021
// Submission for 'Credit' Exercise as part of Harvard's CS50 track

// Building a checksum to confirm if a card number is legitimate or not

// Multiply every other digit by 2, starting with the number’s second-to-last digit, and then add those products’ digits together.
// If the product is over 10, add the two products of that product together (eg 10 = 1 + 0 = 1)
// Add the sum to the sum of the digits that weren’t multiplied by 2.
// If the total’s last digit is 0 (or, put more formally, if the total modulo 10 is congruent to 0), the number is valid!



#include <cs50.h>
#include <stdio.h>

//Select every other digit, starting with the 2nd last
// This can be done by dividing the entered number by 10, 100, 1000 etc and getting the REMAINDER, via the % function

int main()
{
    while (1)
    {
        //Ask for a number to be entered. User will be reprompted if an incorrect input (eg, 'hello') is entered
        long num = get_long("Enter your card number:\n");

        // Count length
        int i = 0;
        //We copy the user input 'num' to a new variable 'cc' for manipulation
        long cc = num;
        while (cc > 0)
        {
            cc = cc / 10;
            //Divide cc by 10 and iterate i until cc = 0
            i++;
        }
        //We print 'INVALID' unless the card number is 13, 15 or 16 digits long
        if (i != 13 && i != 15 && i != 16)
        {
            printf("INVALID\n");
            return 0;
        };
        // We run the checksum algorithm against the number
        // We start by defining a running total, which will become the total for all digits added together
        int runningTotal = 0;
        // Assign a copy of the user's input 'num' into a new variable
        long nextDigit = num;
        // Define another variable, for the 'other' digits in the number
        int otherNumbers = 0;
        // Loop through each digit of the card number until we reach the start of the number
        while (nextDigit > 1)
        {
            // Start by getting the end digit and add it to the 'otherNumbers' variable
            int otherNumber = nextDigit % 10;
            otherNumbers = otherNumbers + otherNumber;
            // Get the next digit
            nextDigit = nextDigit / 10;
            // Split this digit into another variable 'mod' for manipulation
            int mod = nextDigit % 10;
            // Multiply the mod by 2 and split it into separate products if the total is 10 or above
            int timesTwo = mod * 2;
            while (timesTwo > 9)
            {
                int first = timesTwo % 10;
                int last = timesTwo / 10;
                timesTwo = first + last;
            }
            // Add the output of the nested loop to the running total
            runningTotal = timesTwo + runningTotal;
            // Get the next digit and run the next iteration of the loop
            nextDigit = nextDigit / 10;

        }
        // Add the two running totals from the loop together to get the total number, and check if it passes the checksum
        int totalNumbers = runningTotal + otherNumbers;
        int checkSum = totalNumbers % 10;
        if (checkSum > 0)
        {
            printf("INVALID\n");
            return 0;
        };
        // Check the start digits to determine card type
        // Copy the user input into a new variable for manipulation
        long start = num;
        do
        {
            start = start / 10;
        }
        while (start > 100);
        if
        //MasterCard uses 16-digit numbers
        //MasterCard numbers start with 51, 52, 53, 54, or 55
        //Check to see if the starting digit is 5 + second digit is less than 6
        ((start / 10 == 5) && (0 < start % 10 && start % 10 < 6))
        {
            printf("MASTERCARD\n");
            return 0;
        }
        else if
        //American Express uses 15-digit numbers
        //All American Express numbers start with 34 or 37
        //Check to see if starting digit is 3 and second digit is 4 OR 7
        ((start / 10 == 3) && (start % 10 == 4 || start % 10 == 7))
        {
            printf("AMEX\n");
            return 0;
        }
        else if
        //Visa uses 13- and 16-digit numbers starting with 4
        //Check to see if the starting digit is 4
        (start / 10 == 4)
        {
            printf("VISA\n");
            return 0;
        }
        else
        {
            printf("INVALID\n");
            return 0;
        }
    };



}