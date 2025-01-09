#! /bin/bash
source ./inventory.sh

# Global variables
initial_player_health=30
player_health=$initial_player_health

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

player_health_check(){
    if [ $player_health -le 0 ]; then
        echo "You are dead!"
    fi
}
