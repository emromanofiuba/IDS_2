#triangulo equilatero = todos sus lados iguales
#triangulo isosceles = tiene 2 lados iguales
#triangulo escaleno = tiene todos sus lados distintos

#Crear 3 variables para almacenar las 3 longitudes de los lados del triangulo
#Exigir que sean 3 lados, ya que si el usuario ingresa mas o menos de 3, no se trataría de un triangulo
#Establecer 3 casos posibles
    #1. los tres lados son iguales = triangulo equilatero
    #2. los tres lados son distintos = triangulo escaleno
    #3. por descarte (else) 2 lados son iguales y uno es distinto = triangulo isosceles

echo "Ingrese un lado"
read lado_1
echo "Ingrese otro lado"
read lado_2
echo "Ingrese el último lado"
read lado_3

if [[ $lado_1 -eq $lado_2 && $lado_2 -eq $lado_3 ]]; then
    echo "Tu triangulo es equilatero"
elif [[ $lado_1 -ne $lado_2 && $lado_2 -ne $lado_3 && $lado_1 -ne $lado_3 ]]; then
    echo "Tu triangulo es escaleno"
else
    echo "tu triangulo es isosceles"
fi



