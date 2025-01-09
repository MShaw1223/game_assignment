#! /bin/bash

# Global variables
potions=3
game_weapons=( [0]="bow" [1]="sword" [2]="axe" )

user_weapons=(1)
current_weapon=${user_weapons[0]}

inventory(){
    echo "You have $potions health potions."
    echo "Current Weapon: ${game_weapons[$current_weapon]}"

    echo -e "What do you want to do:\n1. Use potion\n2. Change weapon \n3. Back"
    read -r -p "Choice: " ch
    if (( ch == 1 )); then
        use_health_potion
    elif (( ch == 2 )); then
        if ((${#user_weapons[@]} == 1));then
            echo "No other weapons in inventory."
        else
            echo "Available Weapons: "
            for ((i=0; i < ${#user_weapons[@]};i++)); do
                weapon_name=${game_weapons[${user_weapons[$i]}]}
                if [ $weapon_name != ${game_weapons[$current_weapon]} ]; then
                    echo "$i: $weapon_name"
                fi
            done
            read -p "Enter choice: " ch

            current_weapon=${user_weapons[ch]}
            echo "Weapon changed to ${game_weapons[$current_weapon]}."
        fi
    elif (( ch == 3 )); then 
        return
    else
        echo "Invalid choice. Please choose again."
    fi
}
