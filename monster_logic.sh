#! /bin/bash

playerhealth=30
oppohealth=$((RANDOM % 28 + 3))
oppodam=$((RANDOM % 10))
monster_type=""

if [ $oppohealth -le 10 ]; then
    monster_type="Goblin"
    echo "It's a Goblin!"
    echo "Monster health: $oppohealth"
elif [ $oppohealth -gt 10 ] && [ $oppohealth -lt 20 ]; then
    monster_type="Kobold"
    echo "It's a Kobold!"
    echo "Monster health: $oppohealth"
elif [ $oppohealth -ge 20 ] && [ $oppohealth -lt 30 ]; then
    monster_type="Orc"
    echo "It's an Orc!"
    echo "Monster health: $oppohealth"
fi

if [ "$monster_type" == "Goblin" ]; then
    playerhealth=$((playerhealth - oppodam))
elif [ "$monster_type" == "Kobold" ]; then
    playerhealth=$((playerhealth - oppodam - 5))
elif [ "$monster_type" == "Orc" ]; then
    playerhealth=$((playerhealth - oppodam - 10))
fi