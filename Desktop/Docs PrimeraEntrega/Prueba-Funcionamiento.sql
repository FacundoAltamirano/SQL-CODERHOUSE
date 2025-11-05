INSERT INTO empleados (nombre, apellido, puesto, fecha_ingreso)
VALUES ('Ana', 'Lopez', 'Cajera', '2025-10-06');

INSERT INTO clientes (nombre, apellido, telefono, direccion, email)
VALUES ('Carlos', 'Gomez', '3515559999', 'Calle Verde 456', 'carlos@example.com');

INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle)
VALUES (
    (SELECT id_cliente FROM clientes ORDER BY id_cliente DESC LIMIT 1),
    (SELECT id_empleado FROM empleados ORDER BY id_empleado DESC LIMIT 1),
    200.00,
    'EFECTIVO',
    'Tomate x2 - 80.00, Lechuga x1 - 40.00'
);


SELECT * FROM ventas;
