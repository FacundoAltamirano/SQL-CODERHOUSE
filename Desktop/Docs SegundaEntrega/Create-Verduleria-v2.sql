CREATE DATABASE IF NOT EXISTS verduleria;
USE verduleria;

CREATE TABLE IF NOT EXISTS productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(30) UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock DECIMAL(10,3) DEFAULT 0,
    categoria VARCHAR(50),
    activo TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS detalle_producto (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    origen VARCHAR(100),
    proveedor VARCHAR(100),
    unidad_medida VARCHAR(30),
    descripcion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    telefono VARCHAR(30),
    direccion VARCHAR(200),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    puesto VARCHAR(50),
    fecha_ingreso DATE,
    activo TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    cliente_id INT,
    empleado_id INT,
    total DECIMAL(12,2) NOT NULL,
    metodo_pago ENUM('EFECTIVO','TARJETA','TRANSFERENCIA','OTRO') DEFAULT 'EFECTIVO',
    detalle TEXT,
    observaciones TEXT,
    CONSTRAINT fk_venta_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_venta_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id_empleado)
) ENGINE=InnoDB;

DELIMITER //
CREATE TRIGGER trg_actualiza_stock AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE prod_id INT;
    DECLARE cantidad DECIMAL(10,3);
    DECLARE prod_detalle JSON;
    SET prod_detalle = NEW.detalle;
    DECLARE i INT DEFAULT 0;
    WHILE i < JSON_LENGTH(prod_detalle) DO
        SET prod_id = JSON_EXTRACT(prod_detalle, CONCAT('$[',i,'].id_producto'));
        SET cantidad = JSON_EXTRACT(prod_detalle, CONCAT('$[',i,'].cantidad'));
        UPDATE productos SET stock = stock - cantidad WHERE id_producto = prod_id;
        SET i = i + 1;
    END WHILE;
END;
//
DELIMITER ;
