# -----------------------------------------------------------------------------
# ARG — Variables del Build Time 
# Solo existen mientras Docker construye la imagen.
# Útiles para versionar la imagen sin modificar el Dockerfile.
# -----------------------------------------------------------------------------

FROM nginx:1.25-alpine

# -----------------------------------------------------------------------------
# ENV — Variables de entorno disponibles en runtime (slide 9 - Mastering)
# Configuran el comportamiento del contenedor mientras está vivo.
# A diferencia de ARG, estas persisten dentro del contenedor en ejecución.
# -----------------------------------------------------------------------------
ENV NGINX_PORT=80
ENV APP_ENV=production
ENV TZ=America/Argentina/Buenos_Aires

# -----------------------------------------------------------------------------
# RUN — Preparación del sistema base (slide 8 & 10 - Mastering)
# REGLA CLAVE: agrupamos todos los comandos en un solo RUN con && para
# que queden en UNA sola capa inmutable (1 RUN = 1 Capa).
# Limpiamos el caché APK en la MISMA instrucción — si lo hiciéramos en
# un RUN separado, los archivos "eliminados" seguirían en la capa anterior
# (slide 10 - Mastering: "nunca limpies cachés en un RUN posterior").
# -----------------------------------------------------------------------------
RUN apk update && \
    apk add --no-cache \
        tzdata \
        curl && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/* /tmp/*

# -----------------------------------------------------------------------------
# WORKDIR — El escritorio de trabajo interno (slide 7 - Mastering)
# Establece el directorio base para los COPY, RUN y CMD siguientes.
# Nginx sirve archivos estáticos desde /usr/share/nginx/html por defecto.
# -----------------------------------------------------------------------------
WORKDIR /usr/share/nginx/html

# -----------------------------------------------------------------------------
# Nginx trae una página de bienvenida que necesitamos reemplazar
# con nuestra aplicación. Limpiamos en este paso.
# -----------------------------------------------------------------------------
RUN rm -rf ./*

# -----------------------------------------------------------------------------
# COPY — Transferir archivos del Host al contenedor (slide 8 - Mastering)
# "Simple, transparente y seguro."
# Copiamos primero la configuración de Nginx (cambia poco → capa estable).
# -----------------------------------------------------------------------------
COPY nginx.conf /etc/nginx/nginx.conf
# -----------------------------------------------------------------------------
COPY src/ .

COPY healthcheck.sh /usr/local/bin/healthcheck.sh

# -----------------------------------------------------------------------------
EXPOSE 80

# -----------------------------------------------------------------------------
# CMD — Comando por defecto al iniciar el contenedor (slide 13 - Mastering)
# Inicia Nginx en primer plano (daemon off).
# "daemon off" es crítico en Docker: si el proceso corre en background,
# el contenedor cree que el proceso principal terminó y se detiene.
# Este comando puede sobreescribirse en 'docker run ... <otro comando>'.
# -----------------------------------------------------------------------------
CMD ["nginx", "-g", "daemon off;"]
