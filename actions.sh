#! /bin/bash

# Global variables
initial_player_health=30
player_health=$initial_player_health

potions=3

game_weapons=( [0]="bow" [1]="sword" [2]="axe" )
user_weapons=(1 2)
current_weapon=${user_weapons[0]}

# Health potion 
use_health_potion(){
    health_potion=$((RANDOM % 9 + 2))
    if (( player_health < initial_player_health )); then
        if (( potions > 0 )); then
            (( potions-- ))
            player_health=$(( player_health + health_potion ))
            echo "You restored $health_potion health!"
        else
            echo "You have 0 potions left!"
        fi
    else
        echo "You are already at maximum health!"
    fi
    if (( player_health > initial_player_health)); then 
        player_health=$initial_player_health
    fi
    echo "Player health: $player_health"
}

change_weapon(){
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
}