#! /bin/bash
source ./actions.sh

# Global variables
inventory(){
    echo "You have $potions health potions."
    echo "Current Weapon: ${game_weapons[$current_weapon]}"

    echo -e "What do you want to do:\n1. Use potion\n2. Change weapon \n3. Back"
    read -r -p "Choice: " ch
    if (( ch == 1 )); then
        use_health_potion
    elif (( ch == 2 )); then
        change_weapon
    elif (( ch == 3 )); then 
        return
    else
        echo "Invalid choice. Please choose again."
    fi
}
