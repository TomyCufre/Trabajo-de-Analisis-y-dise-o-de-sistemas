-- Base de datos
CREATE DATABASE IF NOT EXISTS heladera_inteligente;
USE heladera_inteligente;

-- Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    email VARCHAR(100)
);

-- Grupo
CREATE TABLE Grupo (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    id_usuario_principal INT,
    FOREIGN KEY (id_usuario_principal) REFERENCES Usuario(id_usuario)
);

-- UsuarioGrupo
CREATE TABLE UsuarioGrupo (
    id_usuario INT,
    id_grupo INT,
    PRIMARY KEY (id_usuario, id_grupo),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_grupo) REFERENCES Grupo(id_grupo)
);

-- Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2)
);

-- Heladera
CREATE TABLE Heladera (
    id_heladera INT AUTO_INCREMENT PRIMARY KEY,
    ubicacion VARCHAR(100),
    gps_lat DECIMAL(9,6),
    gps_lng DECIMAL(9,6),
    estado VARCHAR(20)
);

-- Inventario
CREATE TABLE Inventario (
    id_heladera INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_heladera, id_producto),
    FOREIGN KEY (id_heladera) REFERENCES Heladera(id_heladera),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Compra
CREATE TABLE Compra (
    id_compra INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_heladera INT,
    fecha_hora TIMESTAMP,
    total DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_heladera) REFERENCES Heladera(id_heladera)
);

-- DetalleCompra
CREATE TABLE DetalleCompra (
    id_compra INT,
    id_producto INT,
    cantidad INT,
    id_consumidor_final INT,
    FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_consumidor_final) REFERENCES Usuario(id_usuario)
);

-- Calificacion
CREATE TABLE Calificacion (
    id_usuario INT,
    id_producto INT,
    puntaje INT,
    comentario TEXT,
    PRIMARY KEY (id_usuario, id_producto),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Usuarios
INSERT INTO Usuario (id_usuario, nombre, apellido, email) VALUES
(1, 'Juan', 'Pérez', 'juan@example.com'),
(2, 'Lucía', 'Gómez', 'lucia@example.com'),
(3, 'Carlos', 'Martínez', 'carlos@example.com');

-- Grupo
INSERT INTO Grupo (id_grupo, nombre, id_usuario_principal) VALUES
(1, 'Familia Pérez', 1);

-- UsuarioGrupo
INSERT INTO UsuarioGrupo (id_usuario, id_grupo) VALUES
(1, 1),
(2, 1);

-- Productos
INSERT INTO Producto (id_producto, nombre, descripcion, precio) VALUES
(1, 'Ensalada César', 'Con pollo y croutons', 1500.00),
(2, 'Wrap Vegetariano', 'Con hummus y vegetales grillados', 1200.00),
(3, 'Sopa Detox', 'A base de calabaza y jengibre', 1000.00);

-- Heladeras
INSERT INTO Heladera (id_heladera, ubicacion, gps_lat, gps_lng, estado) VALUES
(1, 'Av. Santa Fe 1234', -34.5895, -58.3974, 'activa'),
(2, 'Calle Falsa 123', -34.6037, -58.3816, 'activa');

-- Inventario
INSERT INTO Inventario (id_heladera, id_producto, cantidad) VALUES
(1, 1, 5),
(1, 2, 0),
(2, 1, 2),
(2, 2, 3),
(2, 3, 4);

-- Compras
INSERT INTO Compra (id_compra, id_usuario, id_heladera, fecha_hora, total) VALUES
(1, 1, 1, '2025-05-15 10:00:00', 1500.00),
(2, 2, 2, '2025-05-15 11:00:00', 2200.00);

-- Detalle de compras
INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, id_consumidor_final) VALUES
(1, 1, 1, 1),
(2, 1, 1, 2),
(2, 2, 1, 2);

-- Calificaciones
INSERT INTO Calificacion (id_usuario, id_producto, puntaje, comentario) VALUES
(1, 1, 5, 'Muy buena ensalada'),
(2, 2, 4, 'Rico pero un poco seco');
