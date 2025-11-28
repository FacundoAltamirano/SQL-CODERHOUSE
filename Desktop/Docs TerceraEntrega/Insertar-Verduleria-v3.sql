USE verduleria;

INSERT IGNORE INTO productos (codigo, nombre, precio, stock, categoria)
VALUES 
('P001','Tomate',90.00,20.500,'Verdura'),
('P002','Papa',50.00,30.000,'Verdura'),
('P003','Lechuga',40.00,15.000,'Verdura'),
('P004','Manzana',120.00,10.000,'Fruta'),
('P005','Zanahoria',60.00,12.000,'Verdura'),
('P006','Cebolla',70.00,18.000,'Verdura'),
('P007','Banana',110.00,25.000,'Fruta');

INSERT IGNORE INTO detalle_producto (id_producto, origen, proveedor, unidad_medida, descripcion)
VALUES
(1,'Campo Norte','Proveedor A','kg','Tomate fresco de primera calidad'),
(2,'Campo Sur','Proveedor B','kg','Papa lavada y lista para consumo'),
(3,'Huerta Central','Proveedor C','kg','Lechuga hoja verde fresca'),
(4,'Campo Este','Proveedor D','kg','Manzana roja dulce'),
(5,'Huerta Norte','Proveedor E','kg','Zanahoria naranja sin químicos'),
(6,'Campo Oeste','Proveedor F','kg','Cebolla fresca de granja'),
(7,'Plantación Sur','Proveedor G','kg','Banana madura lista para consumo');

INSERT IGNORE INTO clientes (nombre, apellido, telefono, direccion, email)
VALUES 
('Maria','Gomez','3515551234','Calle Falsa 123','maria@example.com'),
('Carlos','Gomez','3515559999','Calle Verde 456','carlos@example.com'),
('Lucia','Martinez','3515555678','Calle Azul 789','lucia@example.com');

INSERT IGNORE INTO empleados (nombre, apellido, puesto, fecha_ingreso)
VALUES 
('Juan','Perez','Cajero','2024-01-10'),
('Ana','Lopez','Cajera','2025-10-06'),
('Diego','Ramirez','Repositor','2025-03-15');

INSERT IGNORE INTO ventas (cliente_id, empleado_id, total, metodo_pago, fecha)
VALUES
(1, 1, 250.00, 'EFECTIVO', NOW()),
(2, 2, 200.00, 'TARJETA', NOW()),
(3, 3, 300.00, 'TRANSFERENCIA', NOW());

INSERT IGNORE INTO detalle_venta (id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 2, 90.00, 180.00),
(1, 2, 3, 50.00, 150.00),

(2, 1, 2, 90.00, 180.00),
(2, 3, 1, 40.00, 40.00),

(3, 4, 3, 120.00, 360.00),
(3, 5, 2, 60.00, 120.00);
