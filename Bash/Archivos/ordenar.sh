#!/bin/bash

#Crear un script de Bash que imprima en un archivo llamado “ordenados.txt” 
#los nombres de todos los archivos del directorio actual ordenados según sus tamaños.

ls -S | grep -v '^d' > ordenados.txt