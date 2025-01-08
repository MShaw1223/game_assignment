map=(
  0 0 0 0 0 0 0 0 0 0 0
  0 1 1 1 1 1 1 1 1 1 0
  0 1 0 0 0 1 0 0 0 1 0
  0 1 0 0 0 4 0 0 0 1 0
  0 1 1 0 0 1 0 0 0 1 0
  0 0 1 3 1 0 1 1 1 1 0
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
get_next_val(){
  local current_position=$1
  local val=$2
  echo "${map[$((current_position + val))]}"
}

curr_row=6
curr_col=6

while true; do
  echo "Current Position: ($curr_row, $curr_col)"
  current_value=$(get_map_value "$curr_row" "$curr_col")
  echo "You are standing on: $current_value"

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
          if ((curr_col > 0)); then
            ((curr_col--))
          else
            echo "Can't move left!"; 
          fi;;
        *)
          echo "incorrect";;
        esac;;
    q) 
      echo "Quit"; 
      break;;
    *) 
      echo "Incorrect input";;
  esac
done


