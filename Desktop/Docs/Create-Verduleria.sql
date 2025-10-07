CREATE DATABASE verduleria;
USE verduleria;

CREATE TABLE productos (
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

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    telefono VARCHAR(30),
    direccion VARCHAR(200),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100),
    puesto VARCHAR(50),
    fecha_ingreso DATE,
    activo TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE ventas (
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

INSERT INTO productos (codigo, nombre, precio, stock, categoria)
VALUES 
('P001','Tomate',80.00,20.500,'Verdura'),
('P002','Papa',50.00,30.000,'Verdura'),
('P003','Lechuga',40.00,15.000,'Verdura'),
('P004','Manzana',120.00,10.000,'Fruta');

INSERT INTO clientes (nombre, apellido, telefono, direccion, email)
VALUES 
('Maria','Gomez','3515551234','Calle Falsa 123','maria@example.com');

INSERT INTO empleados (nombre, apellido, puesto, fecha_ingreso)
VALUES 
('Juan','Perez','Cajero','2024-01-10');

INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
VALUES
(
    1,
    1,
    250.00,
    'EFECTIVO',
    'Tomate x2 - 80.00; Papa x3 - 50.00',
    'Venta realizada sin problemas'
);
