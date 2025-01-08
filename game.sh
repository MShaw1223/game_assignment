map=(
  0 0 0 0 0 0 0 0 0 0 0
  0 1 1 1 1 1 1 1 1 1 0
  0 1 0 0 0 1 0 0 0 1 0
  0 1 0 0 0 4 0 0 0 1 0
  0 1 1 0 0 1 0 0 0 1 0
  0 0 1 3 1 1 1 1 1 1 0
  0 1 1 0 0 1 0 1 0 1 0
  0 1 0 0 0 1 1 2 1 1 0
  0 1 0 0 0 1 0 1 0 1 0
  0 1 1 1 1 1 1 1 1 1 0
  0 0 0 0 0 0 0 0 0 0 0
)

# Helper function to access the map
get_map_value() {
  local row=$1
  local col=$2
  local index=$((row * 11 + col))
  echo "${map[$index]}"
}

curr_row=5
curr_col=5

tiles=("wall" "path" "loot" "enemy")

while true; do
  echo "Current Position: ($curr_row, $curr_col)"
  current_value=$(get_map_value "$curr_row" "$curr_col")
  echo "You are standing on: ${tiles[$current_value]}"

  read -p "I: inventory | M: move | C: Check score | Q: Quit " choice
  case $choice in
    i) 
      echo "Inventory";;
    c) 
      echo "Check score";;
    m) 
      read -p "Enter A/W/S/D: " movement
      case $movement in
        a)
          next_tile=$(get_map_value "$curr_row" "((curr_col-1))")
          if ((curr_col > 0 && next_tile > 0)); then
            ((curr_col--))
          else
            echo "Can't move left!"; 
          fi;;
        w)
          next_tile=$(get_map_value "((curr_row-1))" "$curr_col")
          if ((curr_row > 0 && next_tile > 0));then
            ((curr_row--))
          else
            echo "Can't move up!"
          fi;;
        s)
          next_tile=$(get_map_value "((curr_row+1))" "$curr_col")
          if ((curr_row > 0 && next_tile > 0)); then
            ((curr_row++))
          else
            echo "Can't move down!"
          fi;;
        d)
          next_tile=$(get_map_value "$curr_row" "$((curr_col+1))")
          if ((curr_col > 0 && next_tile > 0)); then
            ((curr_col++))
          else
            echo "Can't move right!"; 
          fi;;
        *)
          echo "incorrect";;
        esac;;
    q) 
      echo "Quiting game..."; 
      break;;
    *) 
      echo "Incorrect input";;
  esac
done


