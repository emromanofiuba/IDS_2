echo "ingrese un numero par"
read num

until [ $((num%2)) -eq 0 ]; do
    echo "su numero ($num) no es par. Vuelva a ingresar un numero"
    read num
done

echo "bien, ingresaste un numero par ($num)"