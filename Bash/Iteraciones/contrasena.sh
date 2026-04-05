#1. pedir al usuario su contrasena
#2. almacenar dicha contrasena
#3. pedir que la ingrese nuevamente
#4. comprobar que sean la misma (sea correcta)

#!/bin/bash

read -p "ingrese su contrasena: " contrasena
read -p "confirme su contrasena: " contrasena_ingresada

pedir_contrasena() {
    local contrasena=$1
    local contrasena_ingresada=$2

    if [ $1 == $2 ]; then
        echo "confirmaste correctamente tu contrasena. Podes ingresar"
    else
        until [ $1 == $contrasena_ingresada ]; do 
            read -p "su contrasena es incorrecta. Confirmela nuevamente: " contrasena_ingresada
        done
        echo "Ahora si! Confirmaste correctamente tu contrasena. Podes ingresar"
    fi
}

ingresar_contrasena=$(pedir_contrasena $contrasena $contrasena_ingresada)
echo "$ingresar_contrasena"