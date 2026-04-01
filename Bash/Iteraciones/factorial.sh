echo "ingrese un numero n"
read n

factorial=1
for ((i=1; i<=n; i++)); do
    factorial=$((factorial*i))
done

echo "$n! = $factorial"