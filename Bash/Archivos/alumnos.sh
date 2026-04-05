#!/bin/bash

datos_alumno=()
campos_alumno=("Nombre" "Apellido" "Legajo" "Materia preferida")

echo "Se le solicitarán 4 datos en este orden: Nombre, Apellido, Legajo y Materia preferida"
echo -e "Si debe escribir más de 2 palabras por dato (ej. Nombre: Emiliano Martin), escribalo así: Emiliano-Martin\n"

for campo in ${!campos_alumno[@]}; do
    echo "Ingrese su ${campos_alumno[$campo]}: "
    read dato_temp
    datos_alumno+=($dato_temp)
done   

echo -e " Nombre: ${datos_alumno[0]} \n Apellido: ${datos_alumno[1]} \n Legajo: ${datos_alumno[2]} \n Materia preferida: ${datos_alumno[3]}" > datos_alumno.txt