USE verduleria;

INSERT INTO productos (codigo, nombre, precio, stock, categoria)
VALUES 
('P001','Tomate',90.00,20.500,'Verdura'),
('P002','Papa',50.00,30.000,'Verdura'),
('P003','Lechuga',40.00,15.000,'Verdura'),
('P004','Manzana',120.00,10.000,'Fruta'),
('P005','Zanahoria',60.00,12.000,'Verdura');

INSERT INTO detalle_producto (id_producto, origen, proveedor, unidad_medida, descripcion)
VALUES
(1,'Campo Norte','Proveedor A','kg','Tomate fresco de primera calidad'),
(2,'Campo Sur','Proveedor B','kg','Papa lavada y lista para consumo'),
(3,'Huerta Central','Proveedor C','kg','Lechuga hoja verde fresca'),
(4,'Campo Este','Proveedor D','kg','Manzana roja dulce'),
(5,'Huerta Norte','Proveedor E','kg','Zanahoria naranja sin químicos');

INSERT INTO clientes (nombre, apellido, telefono, direccion, email)
VALUES 
('Maria','Gomez','3515551234','Calle Falsa 123','maria@example.com'),
('Carlos','Gomez','3515559999','Calle Verde 456','carlos@example.com');

INSERT INTO empleados (nombre, apellido, puesto, fecha_ingreso)
VALUES 
('Juan','Perez','Cajero','2024-01-10'),
('Ana','Lopez','Cajera','2025-10-06');

INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
VALUES
(
    1,
    1,
    250.00,
    'EFECTIVO',
    '[{"id_producto":1,"cantidad":2},{"id_producto":2,"cantidad":3}]',
    'Venta realizada sin problemas'
),
(
    2,
    2,
    200.00,
    'EFECTIVO',
    '[{"id_producto":1,"cantidad":2},{"id_producto":3,"cantidad":1}]',
    'Venta realizada sin problemas'
);
