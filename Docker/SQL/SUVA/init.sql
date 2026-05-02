-- Tabla maestra de los planes de suscripción disponibles en el gimnasio
CREATE TABLE planes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250),
    precio_mensual INTEGER NOT NULL
);

-- Tabla maestra de las actividades/clases que ofrece el gimnasio (Crossfit, Yoga, Pileta, etc.)
CREATE TABLE actividades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(250)
);

-- Tabla de los clientes del gimnasio
CREATE TABLE socios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dni INTEGER NOT NULL,
    plan_id INTEGER REFERENCES planes(id) -- Clave foránea: ¿Qué plan paga este socio?
);

-- Tabla intermedia: Resuelve la relación Muchos-a-Muchos entre Socios y Actividades
-- (Un socio puede ir a muchas actividades, una actividad tiene muchos socios)
CREATE TABLE socio_actividad (
    id SERIAL PRIMARY KEY,
    socio_id INTEGER REFERENCES socios(id) NOT NULL,
    actividad_id INTEGER REFERENCES actividades(id) NOT NULL
);

-- Tabla de registro/log transaccional: Guarda el historial de quién vino a qué clase y cuándo
CREATE TABLE bitacora_asistencias (
    id SERIAL PRIMARY KEY,
    socio_id INTEGER REFERENCES socios(id) NOT NULL,
    actividad_id INTEGER REFERENCES actividades(id) NOT NULL,
    fecha_asistencia TIMESTAMP NOT NULL,
    presente BOOLEAN NOT NULL -- True si asistió, False si reservó pero faltó
);