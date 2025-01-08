#! /bin/bash

player_health=30
oppo_type=""
oppo_health=0

monster_type(){
    oppo_health=$((RANDOM % 28 + 3))
    if [ $oppo_health -le 10 ]; then
        oppo_type="GOBLIN"
        echo "It's a GOBLIN!"
        echo "$oppo_type's health: $oppo_health"
    elif [ $oppo_health -gt 10 ] && [ $oppo_health -lt 20 ]; then
        oppo_type="KOBOLD"
        echo "It's a KOBOLD!"
        echo "$oppo_type's health: $oppo_health"
    elif [ $oppo_health -ge 20 ] && [ $oppo_health -lt 30 ]; then
        oppo_type="OGRE"
        echo "It's an OGRE!"
        echo "$oppo_type's health: $oppo_health"
    fi
}

player_attack(){
    player_dam=0
    attack=$((RANDOM % 30))
    if [ $attack -le 10 ]; then
        player_dam=$((RANDOM % 8 + 3))
        oppo_health=$((oppo_health - player_dam))
        echo "You SLASH the $oppo_type for $player_dam damage!"
    elif [ $attack -gt 10 ] && [ $attack -lt 20 ]; then
        player_dam=$((RANDOM % 13 + 3))
        oppo_health=$((oppo_health - player_dam))
        echo "You CHOP the $oppo_type for $player_dam damage!"
    elif [ $attack -ge 20 ] && [ $attack -lt 30 ]; then
        player_dam=$((RANDOM % 18 + 3))
        oppo_health=$((oppo_health - player_dam))
        echo "You STAB the $oppo_type for $player_dam damage!"
    fi
}

monster_attack(){
    oppo_dam=$((RANDOM % 10))
    if [ "$oppo_type" == "GOBLIN" ]; then
        player_health=$((player_health - oppo_dam))
        echo "The $oppo_type attacks you for $oppo_dam damage!"
    elif [ "$oppo_type" == "KOBOLD" ]; then
        player_health=$((player_health - oppo_dam - 5))
        echo "The $oppo_type attacks you for $oppo_dam damage!"
    elif [ "$oppo_type" == "OGRE" ]; then
        player_health=$((player_health - oppo_dam - 10))
        echo "The $oppo_type attacks you for $oppo_dam damage!"
    fi
}

player_health_check(){
    if [ $player_health -le 0 ]; then
        echo "You are dead!"
    fi
}

use_health_potion(){
    health_potion=$((RANDOM % 9 + 2))
    if (( player_health < 30 )); then
        player_health=$(( player_health + health_potion ))
        echo "You restored $health_potion health!"
    else
        echo "You are already at maximum health!"
    fi
    if (( player_health > 30)); then 
        player_health=30
    fi
    echo "Player health: $player_health"
}

fight_loop(){
    monster_type  
    while [ $player_health -gt 0 ] && [ $oppo_health -gt 0 ]; do  
        echo -e "What do you want to do:\n1. Fight\n2. Flee\n3. Use a Health Potion"
        read -r -p "Choice: " ch
        if (( ch == 1)); then
            player_attack  
            if [ $oppo_health -le 0 ]; then 
                echo "The $oppo_type is dead!"
                break
            fi
        elif (( ch == 2 )); then
            echo "You flee the battle."
            break
        elif (( ch == 3 )); then
            use_health_potion
            continue   
        else
            echo "Invalid choice. Fight or Flee."
            continue
        fi
        monster_attack  
        player_health_check
        if [ $player_health -le 0 ]; then 
            echo "You have been defeated!"
            break
        fi
        echo "$oppo_type's health: $oppo_health"
        echo "Player health: $player_health"
    done
}

fight_loop