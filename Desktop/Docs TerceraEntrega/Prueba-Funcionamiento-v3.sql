USE verduleria;

SELECT '================ Prueba VISTAS ================' AS prueba;

SELECT 'Prueba vista_ventas_cliente' AS prueba;
SELECT * FROM vista_ventas_cliente;

SELECT 'Prueba vista_productos_bajo_stock' AS prueba;
SELECT * FROM vista_productos_bajo_stock;

SELECT 'Prueba vista_detalle_ventas' AS prueba;
SELECT * FROM vista_detalle_ventas;

SELECT '================ Prueba FUNCIONES ================' AS prueba;

SELECT 'Prueba función fn_ganancia_total' AS prueba;
SELECT fn_ganancia_total('2024-01-01','2025-12-31') AS ganancia_total;

SELECT 'Prueba función fn_promedio_compra_cliente' AS prueba;
SELECT fn_promedio_compra_cliente(1) AS promedio_cliente_1;
SELECT fn_promedio_compra_cliente(2) AS promedio_cliente_2;

SELECT 'Prueba función fn_cantidad_ventas_empleado' AS prueba;
SELECT fn_cantidad_ventas_empleado(1) AS ventas_empleado_1;
SELECT fn_cantidad_ventas_empleado(2) AS ventas_empleado_2;

SELECT '================ Prueba PROCEDIMIENTOS ================' AS prueba;

SELECT 'Prueba procedimiento sp_top_productos' AS prueba;
CALL sp_top_productos(5);

SELECT 'Prueba procedimiento sp_reporte_ganancias' AS prueba;
CALL sp_reporte_ganancias('2024-01-01','2025-12-31');

SELECT 'Prueba procedimiento sp_resumen_empleado 1' AS prueba;
CALL sp_resumen_empleado(1,'2024-01-01','2025-12-31');

SELECT 'Prueba procedimiento sp_resumen_empleado 2' AS prueba;
CALL sp_resumen_empleado(2,'2024-01-01','2025-12-31');

SELECT '================ Prueba TRIGGERS DE AUDITORÍA ================' AS prueba;

TRUNCATE TABLE auditoria_productos;

INSERT INTO productos(codigo, nombre, precio, stock, categoria) 
VALUES ('TEST01','PruebaTrigger',100,10,'Test');

UPDATE productos SET precio = 150 WHERE codigo = 'TEST01';

DELETE FROM productos WHERE codigo = 'TEST01';

SELECT 'Auditoría productos' AS prueba;
SELECT * FROM auditoria_productos;

SELECT '================ Pruebas FINALIZADAS ================' AS prueba;
