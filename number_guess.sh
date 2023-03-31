#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
#create random number

NUMBER=$(( RANDOM%1000 + 1 ))
echo Enter your username:
read USERNAME
BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
if [[ -z $BEST_GAME ]]
then
INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
echo Welcome, $USERNAME! It looks like this is your first time here.
else
echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
NUMBER_OF_GUESSES = 1


#functions
#guess again function
GUESS_AGAIN() {
echo $NUMBER
read SECRET_NUMBER

#if not a number
if [[ ! $SECRET_NUMBER =~ ^[0-9]+$ ]]
then
echo That is not an integer, guess again:
read SECRET_NUMBER
fi
}
# reguess function
REGUESS() {
# if guess greater
if [[ $SECRET_NUMBER -lt $NUMBER ]]
then
((NUMBER_OF_GUESSES=NUMBER_OF_GUESSES+1))
echo "It's higher than that, guess again:"
GUESS_AGAIN
REGUESS
fi

# if guess lower
if [[ $SECRET_NUMBER -gt $NUMBER ]]
then
((NUMBER_OF_GUESSES=NUMBER_OF_GUESSES+1))
echo "It's lower than that, guess again:"
GUESS_AGAIN
REGUESS
fi
# if guess correct
if [[ $SECRET_NUMBER == $NUMBER ]]
then
((NUMBER_OF_GUESSES=NUMBER_OF_GUESSES+1))

echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $NUMBER. Nice job!"
exit
fi
}



echo Guess the secret number between 1 and 1000:
echo $NUMBER
read SECRET_NUMBER

#if not a number
if [[ ! $SECRET_NUMBER =~ ^[0-9]+$ ]]
then
echo That is not an integer, guess again:
read SECRET_NUMBER
fi
REGUESS
