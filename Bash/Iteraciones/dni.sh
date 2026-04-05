#!/bin/bash

# Solicitar cantidad de DNIs
read -p "¿Cuántos DNIs desea ingresar? " n

# Leer los DNIs
dni=()
for ((i=1; i<=n; i++)); do
    read -p "ingrese los DNIs: " dni_temp
    dni+=($dni_temp)
done

# Ordenar y mostrar de mayor a menor edad
echo ""
echo "DNIs ordenados por edad (de menor a mayor):"
printf '%s\n' "${dni[@]}" | sort -rn
