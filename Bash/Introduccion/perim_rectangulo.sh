echo "Dame la base del rect (en m)"
read base

echo "Dame la altura (en m)"
read altura

perimetro=$(($base*2 + $altura*2))
echo "El perimetro del rectangulo es: $perimetro m"