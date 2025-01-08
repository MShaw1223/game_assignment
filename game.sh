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
  local cols=11
  echo "${map[$((row * cols + col))]}"
}

while true; do
  read -p "I: inventory | M: move | C: Check score | Q: Quit " choice
  case $choice in
    i) 
      echo "Inventory";;
    c) 
      echo "Check score";;
    m) 
      read -p "Enter row: " row
      read -p "Enter column: " col
      value=$(get_map_value "$row" "$col")
      echo "Value at ($row, $col): $value";;
    q) 
      echo "Quit"; 
      break;;
    *) 
      echo "Incorrect input";;
  esac
done


