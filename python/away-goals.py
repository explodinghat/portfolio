#Matt Warren - 07/08/2020
#applet to determine which team wins based on the input of a score from the first leg 
#will output common scores (1-0, 1-1, 0-1, 2-0, 2-1 etc and who goes through), then say 'if team a score more than x and win on the night, they go through'

#Included in portfolio as example of an 'early' python script, with room for improvement - eg:

# Could include input prompts for scores and Team names 
# math / formulas in separate file
# team_A = input('What is the name of Team A? (The home team for the 2nd leg)')
# team_B = input('What is the name of Team B? (The away team for the 2nd leg)')
## add later - which team is at home in the second leg? 
# first_Leg_Score = input(x - y)
# x = first leg score of team_A 
# y = first leg score of team_B -> These are away goals
# second_Leg_Score = pre-set scores to take input of first_Leg_Score and determine who wins. Can then be changed to a user input and run through the formula
# a = second leg score of team_A -> These are away goals
# b = second leg score of team_B 
# if x + a > y + b: team_A wins
# if y + b > x + a: team_B wins
# if x + a == y + b:
#   if x == b: extra time
#   elif x > a: Team A wins?
#   elif x < a: Team B wins?

def the_Winners():
    #This is where we work out who won
    #global fulltime_Score
    #fulltime_score = (x + a)
    if (x + a) > (y + b):
        print(f'{team_A} wins!')
    elif (y + b) > (x + a):
        print(f'{team_B} wins!')
    elif (x + a) == (y + b):
        print("It's a draw..")
        if x == b:
            print(f"We go to extra time.. if {team_A} score another they win on Away Goals (or {team_B} need two more)!")
        elif y > a:
            print(f'{team_B} wins on away goals! {y} over {a}!')
        elif y < a:
            print(f'{team_A} wins on away goals! {a} over {y}!')

def first_leg():
    #in this function we take the information for the first round - this will be free input for the user
    first_Leg_Score = '4 - 1'
    first_Leg_Score_List = [int(s) for s in first_Leg_Score.split() if s.isdigit()]
    #if the user has entered more than 2 integers for the score, they will get an error
    if len(first_Leg_Score_List) != 2:
        print('You have entered an incorrect first leg score')
    #we define x and y as global variables, as they are needed outside of this function    
    global x
    x = first_Leg_Score_List[0]
    global y 
    y = first_Leg_Score_List[1]

def away_Goals():
    #This is the away goals formula
    #we define a and b as global variables, as they are needed outside of this function
    global a
    global b
    second_Leg_Score = '0 - 3'
    second_Leg_Score_List = [int(s) for s in second_Leg_Score.split() if s.isdigit()]
    a = second_Leg_Score_List[0]
    b = second_Leg_Score_List[1]
    #print(x)
    #print(y)
    #print(a)
    #print(b)

#This will be made into a free input for the user to fill out, with appropriate error if name is too long
team_A = 'Manchester United'
team_B = 'Leeds United'


first_leg()
#we output the score from the first leg, which allows the user to sense-check and review the information they are presented
print(f'The score from the first leg was {team_A} {x} - {y} {team_B}')
away_Goals()
#we output the score from the second leg, which allows the user to sense-check and review the information they are presented
print(f'The score from the second leg was {team_B} {b} - {a} {team_A}')
#currently the printout of the winners is under the_Winners() function, it would be good to move this to the end of the script

print(f'The final score over two matches was {team_A} {x + a} - {y + b} {team_B}')
the_Winners()