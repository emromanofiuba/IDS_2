echo "Ingrese un numero"
read numero

if [ $numero -gt 0 ]; then
    echo "El numero que ingresaste ($numero) es mayor a cero"
elif [ $numero -lt 0 ]; then
    echo "El numero que ingresaste ($numero) es menor a cero"
else
    echo "El numero que ingresaste ($numero) es igual a cero"
fi