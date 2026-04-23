docker build -t mi-app-vieja .

docker run mi-app-vieja

docker build -t mi-app-nueva .

docker run mi-app-nueva


BASE DE DATOS para persistencia


docker run --name db-consorcio -p 5432:5432 -e POSTGRES_PASSWORD=1234 -d postgres

docker rm -f db-consorcio

 docker run --name db-consorcio-segura -p 5432:5432 -e POSTGRES_PASSWORD=1234 -v mis-datos-pg:/var/lib/postgresql -d postgres