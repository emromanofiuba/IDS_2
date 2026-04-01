echo "ingrese un numero equivalente a su dia de semana correspondiente (ej 1=lunes)"
read numero_dia

while [ $numero_dia -ge 7 ]; do
    echo "el numero que eligió ($numero_dia) no es asociable a un dia de semana. Intente nuevamente con uno valido."
    read numero_dia
done

case $numero_dia in 
    1)
        echo "elegiste el lunes" ;;
    2)  
        echo "elegiste el martes" ;;
    3)
        echo "elegiste el miercoles" ;;
    4)  
        echo "elegiste el jueves" ;;
    5)
        echo "elegiste el viernes" ;;
    6)  
        echo "elegiste el sabado" ;;
    7)
        echo "elegiste el domingo" ;;
esac
