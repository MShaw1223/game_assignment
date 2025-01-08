#! /bin/bash

oppohealth=$((RANDOM % 40))

if [ $oppohealth -lt 10 ]; then
    echo "It's a Goblin!"
elif [ $oppohealth -ge 10 ] && [ $oppohealth -lt 20 ]; then
    echo "It's a Kobold!"
elif [ $oppohealth -ge 20 ] && [ $oppohealth -lt 30 ]; then
    echo "It's an Orc!"
fi

echo $oppohealth