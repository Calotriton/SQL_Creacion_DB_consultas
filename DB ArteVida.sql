/*
       ArteVida Cultural
*/

# Definición de la estructura de la base de datos

DROP DATABASE IF EXISTS ArteVida;
CREATE DATABASE  ArteVida; #Creación de la DB
USE ArteVida;

#Creamos las tablas
CREATE TABLE ACTIVIDAD(
	id_act INT PRIMARY KEY,
    nombre_act VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    coste_total FLOAT DEFAULT 0 # Almacena el coste total -> Requiere de trigger
);

CREATE TABLE ARTISTA(
	id_art INT PRIMARY KEY,
    nombre_art VARCHAR(50) NOT NULL,
    biografia VARCHAR(255) NOT NULL,
    cache_art FLOAT NOT NULL,
    id_act INT,
    FOREIGN KEY (id_act) REFERENCES ACTIVIDAD(id_act) ON DELETE SET NULL # Participación del artista en la actividad
);

CREATE TABLE UBICACION(
	id_ubi INT PRIMARY KEY,
    nombre_ubi VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    localidad VARCHAR(30) NOT NULL,
    aforo INT NOT NULL,
    precio_alquiler FLOAT NOT NULL,
    precio_entrada FLOAT NOT NULL,
    caracteristicas VARCHAR(255)
);

CREATE TABLE EVENTO(
	id_eve INT PRIMARY KEY,
    nombre_eve VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    hora TIME NOT NULL,
    fecha DATE NOT NULL,
    precio_entrada FLOAT NOT NULL,
    id_act INT,
    id_ubi INT,
    FOREIGN KEY (id_act) REFERENCES ACTIVIDAD(id_act), # Actividad realizada en el evento
    FOREIGN KEY (id_ubi) REFERENCES UBICACION(id_ubi) # Evento realizado en la ubicación
);

CREATE TABLE ASISTENTE(
	id_asi INT AUTO_INCREMENT PRIMARY KEY, # Añadimos el auto_increment para que genere la ID de asistente automáticamente
    nombre_asi VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefono BIGINT NOT NULL
);


# Tabla para la relación N:M entre Evento y Asistente
CREATE TABLE ASISTE(
	id_eve INT,
    id_asi INT,
    PRIMARY KEY (id_eve, id_asi),
    FOREIGN KEY (id_eve) REFERENCES EVENTO(id_eve),
    FOREIGN KEY (id_asi) REFERENCES ASISTENTE(id_asi)
);

# Creación de un trigger para actualizar el coste_total de la actividad cuando se inserta o elimina un nuevo artista
	#Inserción:
DELIMITER //

CREATE TRIGGER INSERT_ARTISTA
AFTER INSERT ON ARTISTA
FOR EACH ROW
BEGIN
    IF NEW.id_act IS NOT NULL THEN
        UPDATE ACTIVIDAD
        SET coste_total = coste_total + NEW.cache_art
        WHERE id_act = NEW.id_act;
    END IF;
END //

DELIMITER ;

	# Eliminación
DELIMITER //

CREATE TRIGGER DELETE_ARTISTA
AFTER DELETE ON ARTISTA
FOR EACH ROW
BEGIN
    IF OLD.id_act IS NOT NULL THEN
        UPDATE ACTIVIDAD
        SET coste_total = coste_total - OLD.cache_art
        WHERE id_act = OLD.id_act;
    END IF;
END //

DELIMITER ;

# Seguidamente, realizamos la inserción de datos (unas 10 observaciones por tabla) 

#Actividades
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('001', 'Concierto de rock', 'Concierto', '150000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('002', 'Conciertos de música popular', 'Concierto', '60000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('003', 'Representación de Hamlet', 'Obra de teatro', '80000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('004', 'Exposición de cuadros', 'Exposición', '300000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('005', 'Exhibición de fósiles', 'Exposición', '400000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('006', 'Charla sobre el cambio climático', 'Conferencia', '5000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('007', 'Concierto de Jazz', 'Concierto', '150000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('008', 'Representación de Los Miserables', 'Obra de teatro', '75000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('009', 'Exposición fotográfica', 'Exposición', '15000.0');
INSERT INTO ACTIVIDAD (id_act, nombre_act, tipo, coste_total) VALUES('010', 'Evento musical de 24h', 'Concierto', '83000.0');

#Artistas
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2930', 'Francisco Ramírez', 'Artista conceptual nacido en 1968, creador de la obra "Pieles"', '14500', '004');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2931', 'Red Hot Chili Peppers', 'Banda de funk-rock conocida mundialmente', '100000', '001');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2932', 'Jaume Badia', 'Científico experto en ecología de rapaces europeas y sus fotografías', '5000', '006');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2933', 'Alejandro Zaballos', 'Violinista profesional', '5000', '002');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2934', 'Compañía de teatro La Marinera', 'Compañía teatral de Mallorca compuesta por 25 miembros', '13500', '003');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2935', 'Quercia', 'Banda de emo-hardcore italiana', '25000', '010');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2936', 'Lucía Ordoñez', 'Diseñadora gráfica famosa por sus diseños conceptuales estéticos', '33000', '004');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2937', 'Totoro', 'Banda músical de indie-rock', '64500', '010');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2938', 'Rodolfo Rodríguez', 'Fotoperiodista experto en los conflitos de los Balcanes', '7500', '009');
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) VALUES('2939', 'Alfredo Frederico', 'Saxofonista profesional nacido en 1954', '76300', '007');

#Ubicaciones, 5 ejemplos
INSERT INTO UBICACION (id_ubi, nombre_ubi, direccion, localidad, aforo, precio_alquiler, precio_entrada, caracteristicas) VALUES('10001', 'Museo de las artes y las ciencias', 'Calle Mayor, núm. 21', 'Valencia', '45000', '350000', '20', 'Gran capacidad, accesible en silla de ruedas');
INSERT INTO UBICACION (id_ubi, nombre_ubi, direccion, localidad, aforo, precio_alquiler, precio_entrada, caracteristicas) VALUES('10002', 'Centro cultural', 'Calle García Lorca, núm. 13', 'Barcelona','200', '3000', '0', 'Centro público, gratuito. Dispone de servicio de cátering');
INSERT INTO UBICACION (id_ubi, nombre_ubi, direccion, localidad, aforo, precio_alquiler, precio_entrada, caracteristicas) VALUES('10003', 'Sala de cenas - La Hiedra', 'Calle Nueva, núm. 3', 'Vic', '150', '6000', '45', 'Dispone de un escenario. La cena viene incluída en el precio');
INSERT INTO UBICACION (id_ubi, nombre_ubi, direccion, localidad, aforo, precio_alquiler, precio_entrada, caracteristicas) VALUES('10004', 'Universidad de Salamanca - Sala de conferencias', 'Avenida Pintor Zuloaga, núm. 2', 'Salamanca', '125', '0', '0', 'Gratuita. Necesita de reserva con antelación mínima de un mes');
INSERT INTO UBICACION (id_ubi, nombre_ubi, direccion, localidad, aforo, precio_alquiler, precio_entrada, caracteristicas) VALUES('10005', 'La Mirona', 'Carretera de Barcelona, núm. 63', 'Girona', '2500', '15000', '33', 'Sala de conciertos, abierta de 20:00 a 03:00');

# Eventos
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('101', 'Noche de rock', 'Noche de conciertos de rock', '20:00', '2024-10-10', '15.0', '001', '10005'); # Se realiza el concierto de rock en La Mirona
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('102', 'Conciertos populares', 'Evento de conciertos de música popular, para todas las edades', '15:00', '2024-10-11', '0.0', '002', '10002'); # Se realiza el concierto popular en el centro cultural
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('103', 'Hamlet', 'Obra de teatro representando Hamlet', '16:00', '2024-10-12', '21.50', '003', '10002'); # Se realiza la obra de teatro en el centro cultural
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('104', 'Van Gogh', 'Exposición sobre la vida y obra de Van Gogh', '10:00', '2024-10-13', '17.50', '004', '10001' ); # Se realiza la exposición de arte en el museo
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('105', 'Fósiles del cretácico', 'Exposición de fósiles del periodo Cretácico', '09:00', '2024-10-14', '0.0', '005', '10001'); # Se realiza la exposición de fósiles en el museo
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('106', 'Cambio climático: presente y futuro', 'Charla sobre el impacto del cambio climático en los ecosistemas y sociedad', '17:30', '2024-10-14', '0.0', '006', '10005'); # Se realiza la charla en la universidad 
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('107', 'Jazz a la fresca', 'Noche de conciertos de jazz', '21:00', '2024-10-16', '5.0', '007', '10003'); # Se realiza el concierto de jazz en la sala de cenas
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('108', 'Los miserables', 'Obra de teatro representando Los Miserables', '19:30', '2024-10-17', '21.50', '008', '10005'); # Se realiza la obra de teatro en La Mirona
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('109', 'Fotografías de los anfibios de Costa Rica', 'Exposición de anfibios amenazados de Costa Rica', '11:00', '2024-10-18', '0.0', '009', '10001'); # Se realiza la expo fotográfica en el museo
INSERT INTO EVENTO (id_eve, nombre_eve, descripcion, hora, fecha, precio_entrada, id_act, id_ubi) VALUES('110', '24 horas de música', 'Evento de conciertos de 24 horas de duración con múltiples artistas invitados', '10:00', '2024-10-19', '15.0', '010', '10002'); # Se realiza el concierto de 24h en el centro cultural

# Asistentes
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('José Miguel', 'jose.miguel@gmail.com', '672134721');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('María Teresa', 'maria.teresa@gmail.com', '642285372');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Alberto López', 'alberto.lopez@gmail.com', '673134127');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Claudia Ordóñez', 'claudia.ordoñez@gmail.com', '613133521');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Lluís Matas', 'lluis.matas@gmail.com', '639174216');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Esteve Pou', 'esteve.pou@gmail.com', '619364715');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Juan José', 'juan.jose@gmail.com', '611927432');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Mireia Martínez', 'mireia.martinez@gmail.com', '618932375');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Teresa Fereira', 'teresa.fereira@gmail.com', '613425152');
INSERT INTO ASISTENTE (nombre_asi, email, telefono) VALUES('Carmen López', 'carmen.lopez@gmail.com', '611545431');

# Vamos a especificar quién asiste a qué evento:
INSERT INTO ASISTE (id_eve, id_asi) VALUES (101, 1);  # José Miguel asiste a Noche de rock
INSERT INTO ASISTE (id_eve, id_asi) VALUES (101, 2);  # María Teresa asiste a Noche de rock
INSERT INTO ASISTE (id_eve, id_asi) VALUES (102, 3);  # Alberto López asiste a Conciertos populares
INSERT INTO ASISTE (id_eve, id_asi) VALUES (103, 4);  # Claudia Ordóñez asiste a Hamlet
INSERT INTO ASISTE (id_eve, id_asi) VALUES (104, 5);  # Lluís Matas asiste a Van Gogh
INSERT INTO ASISTE (id_eve, id_asi) VALUES (105, 6);  # Esteve Pou asiste a Fósiles del cretácico
INSERT INTO ASISTE (id_eve, id_asi) VALUES (106, 7);  # Juan José asiste a Cambio climático: presente y futuro
INSERT INTO ASISTE (id_eve, id_asi) VALUES (107, 8);  # Mireia Martínez asiste a Jazz a la fresca
INSERT INTO ASISTE (id_eve, id_asi) VALUES (108, 9);  # Teresa Fereira asiste a Los miserables
INSERT INTO ASISTE (id_eve, id_asi) VALUES (109, 10); # Carmen López asiste a Fotografías de los anfibios de Costa Rica

# Consultas, modificaciones, borrados y vistas con enunciado
# 1: Lista de eventos con sus ubicaciones y precio de la entrada
SELECT nombre_eve AS "Evento", nombre_ubi AS "Ubicación", evento.precio_entrada AS "Precio Entrada"
FROM EVENTO
JOIN UBICACION ON EVENTO.id_ubi = UBICACION.id_ubi;

# 2: Lista de todas las actividades con su coste total, ordenadas de mayor a menor
SELECT nombre_act AS "Actividad", coste_total AS "Coste Total"
FROM ACTIVIDAD
ORDER BY coste_total DESC;

# 3: Obtener el evento en el que participa Jaume Badia, incluyendo el nombre de la actividad y del evento
SELECT ARTISTA.nombre_art AS "Artista", ACTIVIDAD.nombre_act AS "Actividad", EVENTO.nombre_eve AS "Evento"
FROM ARTISTA
JOIN ACTIVIDAD ON ARTISTA.id_act = ACTIVIDAD.id_act
JOIN EVENTO ON ACTIVIDAD.id_act = EVENTO.id_act
WHERE ARTISTA.nombre_art = 'Jaume Badia';

# 4: Lista de todos los asistentes y de los eventos a los que asisten
SELECT ASISTENTE.nombre_asi AS "Asistente", EVENTO.nombre_eve AS "Evento"
FROM ASISTENTE
JOIN ASISTE ON ASISTENTE.id_asi = ASISTE.id_asi
JOIN EVENTO ON ASISTE.id_eve = EVENTO.id_eve;

# 5: Recuento del número de asistentes a cada evento
SELECT EVENTO.nombre_eve AS "Evento", COUNT(ASISTE.id_asi) AS "Número de Asistentes"
FROM EVENTO
LEFT JOIN ASISTE ON EVENTO.id_eve = ASISTE.id_eve
GROUP BY EVENTO.nombre_eve;

# 6: Calcular el ingreso total que se generaría por las entradas vendidas en cada evento, asumiendo que el aforo es completo.
SELECT EVENTO.nombre_eve AS "Evento", 
       UBICACION.aforo * EVENTO.precio_entrada AS "Ingreso Total Estimado"
FROM EVENTO
JOIN UBICACION ON EVENTO.id_ubi = UBICACION.id_ubi;

# 7: Buscar todos los artistas en cuya biografia se cite la palabra 'fotografía'
SELECT nombre_art AS "Artista", biografia AS "Biografía"
FROM ARTISTA
WHERE biografia LIKE '%fotografía%';

# 8: Consulta para ver la efectividad del trigger, añadimos un artista
	# Consulta previa para ver el coste total de la exposición de cuadros antes de insertar un nuevo artista 
SELECT nombre_act AS "Actividad", coste_total AS "Coste Total"
FROM ACTIVIDAD
WHERE id_act = '004'; # Valor de 300,000
	# Añadimos un artista nuevo
INSERT INTO ARTISTA (id_art, nombre_art, biografia, cache_art, id_act) 
VALUES ('2940', 'Juan José', 'Pintor andaluz expresionista', 12000, '004');
	# Consultamos de nuevo el coste total de la actividad
SELECT nombre_act AS "Actividad", coste_total AS "Coste Total"
FROM ACTIVIDAD
WHERE id_act = '004'; # Ahora observamos un valor de 31200, el trigger funciona

# 9: Ahora comprovamos el trigger de la eliminación
	# Eliminamos el nuevo artista
DELETE FROM ARTISTA
WHERE id_art = '2940';
	#Consultamos de nuevo el coste total, debería ser de 300,000
SELECT nombre_act AS "Actividad", coste_total AS "Coste Total"
FROM ACTIVIDAD
WHERE id_act = '004'; # En efecto da 300,000, el trigger funciona

# 10: Creación de una vista que incluya la información de cada evento, actividad y artista.
CREATE VIEW vista_eventos_artistas AS
SELECT EVENTO.nombre_eve AS "Evento", EVENTO.fecha AS "Fecha", EVENTO.hora AS "Hora",
       UBICACION.nombre_ubi AS "Ubicación", ACTIVIDAD.nombre_act AS "Actividad", ARTISTA.nombre_art AS "Artista"
FROM EVENTO
JOIN UBICACION ON EVENTO.id_ubi = UBICACION.id_ubi
JOIN ACTIVIDAD ON EVENTO.id_act = ACTIVIDAD.id_act
JOIN ARTISTA ON ACTIVIDAD.id_act = ARTISTA.id_act;

	# Consultamos la vista para obtener la información del evento en el que participa Rodolfo Rodríguez
SELECT Evento, Fecha, Hora, Ubicación, Actividad
FROM vista_eventos_artistas
WHERE Artista = 'Rodolfo Rodríguez';
