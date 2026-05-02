#!/bin/sh
# healthcheck.sh — Script de verificación de salud del contenedor.
# Usado por la instrucción HEALTHCHECK del Dockerfile.
# Retorna 0 si Nginx responde correctamente, 1 si no.

curl -f http://localhost/health || exit 1
