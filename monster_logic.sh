#! /bin/bash
source ./actions.sh

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
    elif [ $oppo_health -ge 20 ] && [ $oppo_health -lt 30 ]; then
        oppo_type="WEREWOLF"
        echo "A wild $oppo_type appears!"
        echo "$oppo_type's health: $oppo_health"
    fi
}

# Player attacks and damage 
player_attack(){
    player_dmg=0
    attack=$((RANDOM % 31))
    if [ $attack -le 10 ]; then
        player_dmg=$((RANDOM % 8 + 3))
        oppo_health=$((oppo_health - player_dmg))
        echo "You SLASH the $oppo_type for $player_dmg damage!"
    elif [ $attack -gt 10 ] && [ $attack -lt 20 ]; then
        player_dmg=$((RANDOM % 13 + 3))
        oppo_health=$((oppo_health - player_dmg))
        echo "You CHOP the $oppo_type for $player_dmg damage!"
    elif [ $attack -ge 20 ] && [ $attack -lt 30 ]; then
        player_dmg=$((RANDOM % 18 + 3))
        oppo_health=$((oppo_health - player_dmg))
        echo "You STAB the $oppo_type for $player_dmg damage!"
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
        if (( ch == 1)); then
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
            echo -e "What do you want to do:\n1. Use potion\n2. Change weapon \n3. Back"
            read -r -p "Choice: " ch
            if (( ch == 1 )); then
                use_health_potion
            elif (( ch == 2 )); then
                echo "Weapon changed."
            elif (( ch == 3 )); then 
                continue
            else
                echo "Invalid choice. Please choose again."
            fi
            continue   
        else
            echo "Invalid choice. Fight or Flee."
            continue
        fi
        monster_attack  
        player_health_check
        if [ $player_health -le 0 ]; then 
            (( score-- ))
            echo "You have been defeated!"
            break
        fi
        echo "$oppo_type's health: $oppo_health"
        echo "Player health: $player_health"
    done
}

fight_loop