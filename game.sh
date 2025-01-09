#! /bin/bash
source ./inventory.sh
source ./monster_logic.sh

map=(
  0 0 0 0 0 0 0 0 0 0 0
  0 1 1 1 1 4 1 1 1 1 0
  0 1 0 0 0 4 0 0 0 1 0
  0 1 0 0 0 4 0 0 0 1 0
  0 1 1 0 0 1 0 0 0 1 0
  0 0 1 3 1 1 1 1 1 1 0
  0 1 1 0 0 1 0 1 0 1 0
  0 1 0 0 0 1 1 2 1 1 0
  0 1 0 0 0 1 0 1 0 1 0
  0 1 1 1 1 1 1 1 1 1 0
  0 0 0 0 0 0 0 0 0 0 0
)

get_map_value() {
  local row=$1
  local col=$2
  local index=$((row * 11 + col))
  echo "${map[$index]}"
}

moves=("None")

score=0
# spawn=((5*11+5))

curr_row=5
curr_col=5

tiles=("wall" "path" "loot" "door" "enemy")

revertLastMove(){
  local last=$1

  case $last in 
    [aA])
      moves+=($last)
      ((curr_col++));;
    [wW])
      moves+=($last)
      ((curr_row++));;
    [sS])
      moves+=($last)
      ((curr_row--));;
    [dD])
      moves+=($last)
      ((curr_col--));;
    *)
      echo "Error reading last move";;
  esac
}

repeatLastMove(){
  local last=$1

  case $last in 
    [aA])
      ((curr_col--));;
    [wW])
      ((curr_row--));;
    [sS])
      ((curr_row++));;
    [dD])
      ((curr_col++));;
    *)
      echo "Error reading last move";;
  esac
}


while true; do
  len_moves=${#moves[@]}
  last_move_index=$((len_moves-1))
  last_move=${moves[$last_move_index]}



  echo "last move: $last_move"
  echo "Current Position: ($curr_row, $curr_col)"
  current_value=$(get_map_value "$curr_row" "$curr_col")

  if ((current_value == 4));then 
    fight_loop
    repeatLastMove $last_move
    if (( score < 0 )); then
      score=0
      echo -e "RISE AGAIN TO FIGHT THE DARKNESS?\n1. Yes\n2. No"
      read -r -p "Choice: " ch
      if (( ch == 1 )); then 
        $(( curr_row=5 ))
        $(( curr_col=5 ))
        continue
      elif (( ch == 2 )); then
        echo "Coward."
        break
      else
        echo "Invalid choice. Please choose again"
      fi
    fi
  fi

  if ((current_value == 2));then
    echo "You are standing on: ${tiles[$current_value]}"
    read -p "P to pickup loot, b to go back: " pickup
      case $pickup in
        [pP])
          loot_drop=RANDOM % 3 # 0-weapon 1-potion 2-score
          case $loot_drop in
            0)
              weapon_drop=RANDOM % 3
              user_weapons+=($weapon_drop);;
            1)
             echo "Potion found +1"
              (( potions++ ));;
            2)
               echo "Loot picked up, +1 score!"
              ((score++));;
            *)
              echo "Loot drop error";;
          esac
          repeatLastMove $last_move;;
        [bB])
          revertLastMove $last_move;;
        *)
          echo "Input incorrect, loot not picked up.";;
    esac
    else
      echo "You are standing on: ${tiles[$current_value]}"
  fi

  echo "I: inventory | M: move | C: Check score | Q: Quit "
  read -p "> " choice
  case $choice in
    [iI]) 
      echo "Inventory"
      inventory;;
    [cC]) 
      echo "Current score: $score";;
    [mM]) 
      read -p "Enter A/W/S/D: " movement
      case $movement in
        [aA])
          next_tile=$(get_map_value "$curr_row" "((curr_col-1))")
          if ((curr_col > 0 && next_tile > 0)); then
            if ((next_tile == 1 || next_tile == 2|| next_tile == 4));then
              ((curr_col--))
              moves+=($movement)
            elif ((next_tile==3));then
              read -p "A to continue through door, B to go back: " choice
              case $choice in
                [aA])
                  ((curr_col--))
                  moves+=($choice);;
                [bB])
                  echo "Turning around...";;
                *)
                  echo "Incorrect input";;
              esac
            fi
          else
            echo "Can't move left!"; 
          fi;;
        [wW])
          next_tile=$(get_map_value "((curr_row-1))" "$curr_col")
          if ((curr_col > 0 && next_tile > 0)); then
            if ((next_tile == 1 || next_tile == 2 || next_tile == 4));then
              ((curr_row--))
              moves+=($movement)
            elif ((next_tile==3));then
              read -p "W to continue through door, B to go back: " choice
              case $choice in
                [wW])
                  ((curr_row--))
                  moves+=($choice);;
                [bB])
                  echo "Turning around...";;
                *)
                  echo "Incorrect input";;
              esac
            fi
          else
            echo "Can't move up!"
          fi;;
        [sS])
          next_tile=$(get_map_value "((curr_row+1))" "$curr_col")
          if ((curr_col > 0 && next_tile > 0)); then
            if ((next_tile == 1 || next_tile == 2 || next_tile == 4));then
              ((curr_row++))
              moves+=($movement)
            elif ((next_tile==3));then
              read -p "S to continue through door, B to go back: " choice
              case $choice in
                [sS])
                  ((curr_row++))
                  moves+=($choice);;
                [bB])
                  echo "Turning around...";;
                *)
                  echo "Incorrect input";;
              esac
            fi
          else
            echo "Can't move down!"
          fi;;
        [dD])
          next_tile=$(get_map_value "$curr_row" "$((curr_col+1))")
          if ((curr_col > 0 && next_tile > 0)); then
            if ((next_tile == 1 || next_tile == 2|| next_tile == 4));then
              ((curr_col++))
              moves+=($movement)
            elif ((next_tile==3));then
              read -p "D to continue through door, b to go back: " choice
              case $choice in
                [dD])
                  ((curr_col++))
                  moves+=($choice);;
                [bB])
                  echo "Turning around...";;
                *)
                  echo "Incorrect input";;
              esac
            fi
          else
            echo "Can't move right!"; 
          fi;;
        *)
          echo "incorrect";;
        esac;;
    [qQ]) 
      echo "Final score: $score"
      echo "Quiting game..."
      break;;
    *) 
      echo "Incorrect input";;
  esac
done
