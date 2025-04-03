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
  echo "The element with atomic number $NUM is $NAM ($SYM). It's a $TYP, with a mass of $AMASS amu. $NAM has a melting point of $MPC celsius and a boiling point of $BPC celsius."
}
NAMCALL() {
  NAM=$1
  NUM=$($PSQL "select atomic_number from elements where name = '$NAM'")
  SYM=$($PSQL "select symbol from elements where atomic_number = '$NUM'")
  AMASS=$($PSQL "select atomic_mass from properties where atomic_number = '$NUM'")
  MPC=$($PSQL "select melting_point_celsius from properties where atomic_number = '$NUM'")
  BPC=$($PSQL "select boiling_point_celsius from properties where atomic_number = '$NUM'")
  TYP=$($PSQL "select type from types inner join properties using(type_id) where atomic_number='$NUM';")
  echo "The element with atomic number $NUM is $NAM ($SYM). It's a $TYP, with a mass of $AMASS amu. $NAM has a melting point of $MPC celsius and a boiling point of $BPC celsius."
}
SYMCALL() {
  SYM=$1
  NUM=$($PSQL "select atomic_number from elements where symbol = '$SYM'")
  NAM=$($PSQL "select name from elements where atomic_number = '$NUM'")
  AMASS=$($PSQL "select atomic_mass from properties where atomic_number = '$NUM'")
  MPC=$($PSQL "select melting_point_celsius from properties where atomic_number = '$NUM'")
  BPC=$($PSQL "select boiling_point_celsius from properties where atomic_number = '$NUM'")
  TYP=$($PSQL "select type from types inner join properties using(type_id) where atomic_number='$NUM';")
  echo "The element with atomic number $NUM is $NAM ($SYM). It's a $TYP, with a mass of $AMASS amu. $NAM has a melting point of $MPC celsius and a boiling point of $BPC celsius."
}

SPLIT() {
  #judgement
  INPUT=$1
  
  # Check if input is a number
  if [[ $INPUT =~ ^[0-9]+$ ]]; then
    NUMCALL $INPUT
  # Check if input is a symbol (1-2 characters)
  elif [[ $INPUT =~ ^[A-Za-z]{1,2}$ ]]; then
    # Convert to proper case (first letter uppercase, second lowercase if exists)
    PROPER_SYM=$(echo ${INPUT:0:1} | tr '[:lower:]' '[:upper:]')$(echo ${INPUT:1} | tr '[:upper:]' '[:lower:]')
    
    # Verify if it's a valid symbol in the database
    if [[ $($PSQL "SELECT symbol FROM elements WHERE symbol='$PROPER_SYM'") ]]; then
      SYMCALL $PROPER_SYM
    else
      echo "I could not find that element in the database."
    fi
  # Otherwise, assume it's a name
  else
    # Capitalize first letter, lowercase the rest
    PROPER_NAME=$(echo ${INPUT:0:1} | tr '[:lower:]' '[:upper:]')$(echo ${INPUT:1} | tr '[:upper:]' '[:lower:]')
    
    # Verify if it's a valid name in the database
    if [[ $($PSQL "SELECT name FROM elements WHERE name='$PROPER_NAME'") ]]; then
      NAMCALL $PROPER_NAME
    else
      echo "I could not find that element in the database."
    fi
  fi
}


if [[ $1 ]]
then
  SPLIT $1
else
  echo "Please provide an element as an argument."
fi

