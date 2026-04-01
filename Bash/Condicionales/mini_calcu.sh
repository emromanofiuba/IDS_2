#1.solicitar al usuario el ingreso de dos numeros enteros
#2. crear 4 funciones (una para cada operacion basica)

echo "Ingresa un numero entero"
read num_1
echo "Ingresa otro numero entero"
read num_2

calcular_suma() {
    num_1=$1
    num_2=$2
    suma=$((num_1+num_2))
    echo $suma
}
sumar=$(calcular_suma $num_1 $num_2)
printf "\nla suma de los dos numeros que ingresaste ($num_1) y ($num_2) da $sumar"

calcular_resta() {
    num_1=$1
    num_2=$2
    resta=$((num_1-num_2))
    echo $resta
}
restar=$(calcular_resta $num_1 $num_2)
printf "\nla resta de los dos numeros que ingresaste ($num_1) y ($num_2) da $restar"

calcular_multiplicacion() {
    num_1=$1
    num_2=$2
    multiplicacion=$((num_1*num_2))
    echo $multiplicacion
}
multiplicar=$(calcular_multiplicacion $num_1 $num_2)
printf "\nla multiplicacion de los dos numeros que ingresaste ($num_1) y ($num_2) da $multiplicar"

calcular_division() {
    num_1=$1
    num_2=$2
    local division=$((num_1/num_2))
    echo $division
}
division=$(calcular_division $num_1 $num_2)
printf "\nla division de los dos numeros que ingresaste ($num_1) y ($num_2) da $division\n"
