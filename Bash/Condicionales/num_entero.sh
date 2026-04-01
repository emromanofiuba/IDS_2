echo "Ingrese un numero entero"
read numero

operacion=$((numero%2))
if [ $operacion -eq 0 ]; then
    echo "El numero ingresado es par"
else
    echo "El numero ingresado es impar"
fi