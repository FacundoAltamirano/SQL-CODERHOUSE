USE verduleria;

-- 1. Revisar estado inicial de las tablas
SELECT 'Productos iniciales' AS prueba;
SELECT id_producto, nombre, stock FROM productos;

SELECT 'Clientes' AS prueba;
SELECT * FROM clientes;

SELECT 'Empleados' AS prueba;
SELECT * FROM empleados;

SELECT 'Ventas iniciales' AS prueba;
SELECT * FROM ventas;

SELECT 'Detalle productos' AS prueba;
SELECT dp.id_detalle, p.nombre AS producto, dp.origen, dp.proveedor, dp.unidad_medida
FROM detalle_producto dp
JOIN productos p ON dp.id_producto = p.id_producto;

-- 2. Prueba triggers: insertar nuevas ventas
SELECT 'Insertando venta prueba 1' AS prueba;
INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
VALUES
(
    1,
    2,
    180.00,
    'TARJETA',
    '[{"id_producto":5,"cantidad":3},{"id_producto":3,"cantidad":2}]',
    'Venta prueba trigger 1'
);

SELECT 'Stock despues venta prueba 1' AS prueba;
SELECT id_producto, nombre, stock FROM productos;

SELECT 'Insertando venta prueba 2' AS prueba;
INSERT INTO ventas (cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
VALUES
(
    2,
    1,
    300.00,
    'EFECTIVO',
    '[{"id_producto":4,"cantidad":5},{"id_producto":2,"cantidad":2}]',
    'Venta prueba trigger 2'
);

SELECT 'Stock despues venta prueba 2' AS prueba;
SELECT id_producto, nombre, stock FROM productos;

-- 3. Probar vistas
SELECT 'Vista ventas por cliente' AS prueba;
SELECT * FROM vista_ventas_cliente;

SELECT 'Vista productos bajo stock' AS prueba;
SELECT * FROM vista_productos_bajo_stock;

SELECT 'Vista detalle ventas' AS prueba;
SELECT * FROM vista_detalle_ventas;

-- 4. Probar funciones
SELECT 'Total ventas cliente 1' AS prueba;
SELECT fn_total_ventas_cliente(1) AS total_ventas_cliente_1;

SELECT 'Total ventas cliente 2' AS prueba;
SELECT fn_total_ventas_cliente(2) AS total_ventas_cliente_2;

SELECT 'Stock producto 3' AS prueba;
SELECT fn_stock_producto(3) AS stock_producto_3;

SELECT 'Stock producto 5' AS prueba;
SELECT fn_stock_producto(5) AS stock_producto_5;

-- 5. Probar procedimientos almacenados
SELECT 'Procedimiento registrar venta' AS prueba;
CALL sp_registrar_venta(
    1,
    1,
    '[{"id_producto":1,"cantidad":1},{"id_producto":4,"cantidad":2}]',
    220.00,
    'TRANSFERENCIA'
);

SELECT 'Stock despues procedimiento registrar venta' AS prueba;
SELECT id_producto, nombre, stock FROM productos;

SELECT 'Procedimiento reporte ventas cliente 1' AS prueba;
CALL sp_reporte_ventas_cliente(1, '2024-01-01', NOW());

SELECT 'Procedimiento reporte ventas cliente 2' AS prueba;
CALL sp_reporte_ventas_cliente(2, '2024-01-01', NOW());

-- Fin script pruebas
SELECT 'Pruebas finalizadas' AS prueba;
