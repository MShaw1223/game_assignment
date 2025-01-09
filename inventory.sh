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
}