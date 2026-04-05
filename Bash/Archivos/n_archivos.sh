read -p "ingresa un numero natural: " n

for ((i=1; i<=n; i++)); do
    touch archivo$i
    echo "usuario actual: $USER" > archivo$i 
done