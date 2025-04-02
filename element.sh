#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"


if [[ $1 ]]
then
  CHECKS $1
  echo test
else
  echo "Please provide an element as an argument."
  read IDINPUT
  CHECKS $IDINPUT
fi

CHECKS () {
  echo "kfdk"
  #echo "The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."

  #echo "I could not find that element in the database."
}
