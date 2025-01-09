#! /bin/bash

# Global variables
potions=3
weapon=( "sword" )

inventory(){
    echo "You have $potions health potions."
    echo "Your weapons: "
    for w in "${weapon[@]}"; do
        echo "- $w"
    done
    echo -e "What do you want to do:\n1. Use potion\n2. Change weapon \n3. Back"
    read -r -p "Choice: " ch
    if (( ch == 1 )); then
        use_health_potion
    elif (( ch == 2 )); then
        echo "Weapon changed."
    elif (( ch == 3 )); then 
        return
    else
        echo "Invalid choice. Please choose again."
    fi
}