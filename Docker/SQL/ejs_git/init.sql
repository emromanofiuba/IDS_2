-- Tabla de bandas musicales
CREATE TABLE bandas (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    pais_origen TEXT NOT NULL,
    fecha_creacion INTEGER NOT NULL,
    genero TEXT NOT NULL,
    cant_integrantes INTEGER NOT NULL
);

-- Tabla de álbumes
CREATE TABLE albumes (
    id SERIAL PRIMARY KEY,
    banda_id INTEGER NOT NULL REFERENCES bandas(id),
    nombre TEXT NOT NULL,
    lanzamiento INTEGER NOT NULL,
    duracion INTEGER NOT NULL,  -- duración en minutos
    ranking INTEGER UNIQUE NOT NULL  -- ranking global entre todos los álbumes
);

-- Tabla de canciones
CREATE TABLE canciones (
    id SERIAL PRIMARY KEY,
    banda_id INTEGER NOT NULL REFERENCES bandas(id),
    album_id INTEGER NOT NULL REFERENCES albumes(id),
    nombre TEXT NOT NULL,
    duracion INTEGER NOT NULL,  -- duración en minutos
    ranking INTEGER UNIQUE NOT NULL  -- ranking global entre todas las canciones
);

-- Tabla de conciertos
CREATE TABLE conciertos (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    pais TEXT NOT NULL,
    fecha INTEGER NOT NULL  -- año
);

-- Tabla intermedia para relación muchos-a-muchos entre conciertos y músicos
CREATE TABLE conciertos_musicos (
    concierto_id INTEGER NOT NULL REFERENCES conciertos(id),
    banda_id INTEGER NOT NULL REFERENCES bandas(id),
    PRIMARY KEY (concierto_id, banda_id)
);