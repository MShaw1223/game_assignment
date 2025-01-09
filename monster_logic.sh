#! /bin/bash

# Global variables
oppo_type=""
oppo_health=0

# Random monster types
monster_type(){
    oppo_health=$((RANDOM % 28 + 3))
    if [ $oppo_health -le 10 ]; then
        oppo_type="GHOUL"
        echo "A wild $oppo_type appears!"
        echo "$oppo_type's health: $oppo_health"
    elif [ $oppo_health -gt 10 ] && [ $oppo_health -lt 20 ]; then
        oppo_type="VAMPIRE"
        echo "A wild $oppo_type appears!"
        echo "$oppo_type's health: $oppo_health"
    elif [ $oppo_health -ge 20 ] && [ $oppo_health -le 30 ]; then
        oppo_type="WEREWOLF"
        echo "A wild $oppo_type appears!"
        echo "$oppo_type's health: $oppo_health"
    fi
}

# Player attacks and damage 
player_attack(){
    player_dmg=0
    # axe logic 
    if (( current_weapon == 2 ))  ; then
        echo -e "Attack:\n1. Hack (5-12 dmg) \n2. Chop (3-17 dmg) \n3. Cleave (1-23 dmg)"
        read -r -p "Choice: " ch
        if (( ch == 1 )); then
            player_dmg=$((RANDOM % 8 + 5))
            oppo_health=$((oppo_health - player_dmg))
            echo "You HACK the $oppo_type for $player_dmg damage!"
        elif (( ch == 2 )); then
            player_dmg=$((RANDOM % 15 + 3))
            oppo_health=$((oppo_health - player_dmg))
            echo "You CHOP the $oppo_type for $player_dmg damage!"
        elif (( ch == 3 )); then
            player_dmg=$((RANDOM % 23 + 1))
            oppo_health=$((oppo_health - player_dmg))
            echo "You CLEAVE the $oppo_type for $player_dmg damage!"
        fi
    # bow logic 
    elif (( current_weapon == 0 )) ; then
        echo -e "Attack:\n1. Shot (8-9 dmg) \n2. Pierce (7-13 dmg) \n3. Rapid (6-16 dmg)"
        read -r -p "Choice: " ch
        if (( ch == 1 )); then
            player_dmg=$((RANDOM % 2 + 8))
            oppo_health=$((oppo_health - player_dmg))
            echo "You SHOT the $oppo_type for $player_dmg damage!"
        elif (( ch == 2 )); then
            player_dmg=$((RANDOM % 7 + 7))
            oppo_health=$((oppo_health - player_dmg))
            echo "You PIERCE SHOT the $oppo_type for $player_dmg damage!"
        elif (( ch == 3 )); then
            player_dmg=$((RANDOM % 11 + 6))
            oppo_health=$((oppo_health - player_dmg))
            echo "You RAPID SHOT the $oppo_type for $player_dmg damage!"
        fi
    # sword logic 
    elif (( current_weapon == 1 )) ; then
        echo -e "Attack:\n1. Slice (7-10 dmg) \n2. Slash (5-15 dmg) \n3. Stab (2-20 dmg)"
        read -r -p "Choice: " ch
        if (( ch == 1 )); then
            player_dmg=$((RANDOM % 4 + 7))
            oppo_health=$((oppo_health - player_dmg))
            echo "You SLICE the $oppo_type for $player_dmg damage!"
        elif (( ch == 2 )); then
            player_dmg=$((RANDOM % 11 + 5))
            oppo_health=$((oppo_health - player_dmg))
            echo "You SLASH the $oppo_type for $player_dmg damage!"
        elif (( ch == 3 )); then
            player_dmg=$((RANDOM % 19 + 2))
            oppo_health=$((oppo_health - player_dmg))
            echo "You STAB the $oppo_type for $player_dmg damage!"
        fi
    fi
}

# Monster attacks and damage
monster_attack(){
    oppo_dmg=$((RANDOM % 11))
    if [ "$oppo_type" == "GHOUL" ]; then
        player_health=$((player_health - oppo_dmg))
        echo "The $oppo_type attacks you for $oppo_dmg damage!"
    elif [ "$oppo_type" == "VAMPIRE" ]; then
        vampire_dmg=$(( oppo_dmg + 5 ))
        player_health=$((player_health - vampire_dmg))
        echo "The $oppo_type attacks you for $vampire_dmg damage!"
    elif [ "$oppo_type" == "WEREWOLF" ]; then
        werewolf_dmg=$(( oppo_dmg + 10 ))
        player_health=$((player_health - werewolf_dmg))
        echo "The $oppo_type attacks you for $werewolf_dmg damage!"
    fi
}

# Main fight logic
fight_loop(){
    monster_type  
    while [ $player_health -gt 0 ] && [ $oppo_health -gt 0 ]; do  
        echo -e "What do you want to do:\n1. Fight\n2. Flee\n3. Inventory"
        read -r -p "Choice: " ch
        ch=$(echo "$ch" | tr '[:upper:]' '[:lower:]')
        if (( ch == 1 || "$ch" == "fight" )); then
            player_attack  
            if [ $oppo_health -le 0 ]; then 
                (( score+= 5 ))
                echo "The $oppo_type is dead!"
                break
            fi
        elif (( ch == 2 )); then
            echo "You try to flee the battle."
            flee=$(( RANDOM % 11 ))
            if (( flee <= 5 )); then 
                monster_attack
                echo "Wounded, you manage to escape."
                break
            elif (( flee > 5 )); then
                echo "You manage to escape unscratched!"
                break
            fi
        elif (( ch == 3 )); then
            inventory    
            continue
        else
            echo "Invalid choice. Fight or Flee."
            continue
        fi
        monster_attack  
        if [ $player_health -le 0 ]; then 
            (( score=-1 ))
            echo "You have been defeated!"
            break
        fi
        echo "$oppo_type's health: $oppo_health"
        echo "Player health: $player_health"
    done
}