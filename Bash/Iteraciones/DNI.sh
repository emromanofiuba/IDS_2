#Crear un script de Bash que reciba números de DNI y ordene a las personas de menor a mayor edad. 
#Imprimir por pantalla los documentos ordenados. (la cantidad de números de DNI puede variar).

#1. pedir al usuario n cantidad de numeros de DNI
#2.  " " " los DNIs"
#3. almacenarlos en una lista
#4. ordenarlos de menor a mayor edad.
#5. mostrarlo por pantalla.

echo "Cuantos DNIs quiere ingresar" #1
read n

declare -a dni
for ((i=1; i<=n; i++)); do
    echo "Ingrese el $i° DNI"       #2
    read dni_temp
    dni+=($dni_temp)
done 

dni_ordenado=($(printf "%d\n" "${dni[@]}" | sort -rn))

echo "Ingreso $i DNIs y así se ordenan: ${dni_ordenado[@]}"


