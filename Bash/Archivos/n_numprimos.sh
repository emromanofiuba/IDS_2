#1. pedir al usuario hasta el numero n que quiere iterar
    #1.1_ iterar todos los numeros hasta n
#2. establecer un contador de divisores en 0
#3. analizar todos los divisores j hasta i (para cada iteracion)
    #3.1_ si el resto de la div es cero, es divisor, se agrega al contador
#4. los numeros i que tienen cantidad de divisores = 2, se imprimen

read -p "ingrese un numero n hasta donde quiera iterar: " n

for ((i=2; i<=n; i++)); do
    contador_divisores=0

    for ((j=1; j<=i; j++)); do
        if ((i % j == 0)) ; then
            ((contador_divisores ++))
        fi
    done

    if ((contador_divisores == 2)); then
            echo $i >> primos.txt
    fi
done


