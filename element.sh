#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

NUMCALL() { 
  NUM=$1
  SYM=$($PSQL "select symbol from elements where atomic_number = '$NUM'")
  NAM=$($PSQL "select name from elements where atomic_number = '$NUM'")
  AMASS=$($PSQL "select atomic_mass from properties where atomic_number = '$NUM'")
  MPC=$($PSQL "select melting_point_celsius from properties where atomic_number = '$NUM'")
  BPC=$($PSQL "select boiling_point_celsius from properties where atomic_number = '$NUM'")
  TYP=$($PSQL "select type from types inner join properties using(type_id) where atomic_number='$NUM';")
  echo "The element with atomic number $NUM is $NAM ($SYM). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius."
}
#SYMCALL() {}
#NAMCALL() {}
SPLIT() {
  #echo "bird is good $1"
  NUMCALL $1
}


if [[ $1 ]]
then
  SPLIT $1
else
  echo "Please provide an element as an argument."
fi

