USE verduleria;

SELECT * FROM productos;

SELECT * FROM clientes;

SELECT * FROM empleados;

SELECT * FROM ventas;

SELECT dp.id_detalle, p.nombre AS producto, dp.origen, dp.proveedor, dp.unidad_medida
FROM detalle_producto dp
JOIN productos p ON dp.id_producto = p.id_producto;

INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
VALUES
(
    1,
    2,
    180.00,
    'TARJETA',
    '[{"id_producto":5,"cantidad":3},{"id_producto":3,"cantidad":2}]',
    'Venta de prueba para trigger'
);

SELECT id_producto, nombre, stock FROM productos;
