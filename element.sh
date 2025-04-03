#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

NUMCALL() { 
  echo "$1"
  NUM=$1
  SYM=$($PSQL "select symbol from elements where atomic_number = '$NUM'")
  NAM=$($PSQL "select name from elements where atomic_number = '$NUM'")
  AMASS=$($PSQL "select ")
  MPC=$($PSQL "")
  BPC=$($PSQL "")
  TYP=$($PSQL "")
  echo "The element with atomic number $NUM is $NAM ($SYM). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
}
SYMCALL() {

}
NAMCALL() {

}
SPLIT() {
  #echo "bird is good $1"
}


if [[ $1 ]]
then
  SPLIT $1
else
  echo "Please provide an element as an argument."
fi

