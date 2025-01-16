#!/bin/bash

# Check for required arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <DAY>"
    exit 1
fi

DAY=$1
DATA_FILE="./data/advent_of_sql_day_${DAY}.sql"

if [ ! -f "$DATA_FILE" ]; then
    echo "Error: Data file '$DATA_FILE' does not exist."
    exit 1
fi

export DAY DATA_FILE

docker compose up --force-recreate -d

echo "Container for day '$DAY' started using '$DATA_FILE'."

unset DAY
unset DATA_FILE