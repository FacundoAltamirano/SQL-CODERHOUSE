USE verduleria;

DELIMITER //

CREATE TRIGGER trg_actualiza_stock AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE prod_id INT;
    DECLARE cantidad DECIMAL(10,3);
    DECLARE i INT DEFAULT 0;
    DECLARE prod_detalle JSON;
    SET prod_detalle = NEW.detalle;
    WHILE i < JSON_LENGTH(prod_detalle) DO
        SET prod_id = JSON_EXTRACT(prod_detalle, CONCAT('$[',i,'].id_producto'));
        SET cantidad = JSON_EXTRACT(prod_detalle, CONCAT('$[',i,'].cantidad'));
        UPDATE productos SET stock = stock - cantidad WHERE id_producto = prod_id;
        SET i = i + 1;
    END WHILE;
END;
//

CREATE VIEW vista_ventas_cliente AS
SELECT c.id_cliente, c.nombre, c.apellido, SUM(v.total) AS total_ventas
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido;
//

CREATE VIEW vista_productos_bajo_stock AS
SELECT id_producto, nombre, stock
FROM productos
WHERE stock < 10;
//

CREATE VIEW vista_detalle_ventas AS
SELECT v.id_venta, v.fecha, c.nombre AS cliente, e.nombre AS empleado, p.nombre AS producto, dp.proveedor, JSON_EXTRACT(v.detalle, CONCAT('$[',i,'].cantidad')) AS cantidad
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id_cliente
JOIN empleados e ON v.empleado_id = e.id_empleado
JOIN productos p ON JSON_CONTAINS_PATH(v.detalle, 'one', CONCAT('$[',0,'].id_producto')) 
JOIN detalle_producto dp ON p.id_producto = dp.id_producto;
//

CREATE FUNCTION fn_total_ventas_cliente(cliente INT) RETURNS DECIMAL(12,2)
DETERMINISTIC
RETURN (SELECT IFNULL(SUM(total),0) FROM ventas WHERE cliente_id = cliente);
//

CREATE FUNCTION fn_stock_producto(prod INT) RETURNS DECIMAL(10,3)
DETERMINISTIC
RETURN (SELECT stock FROM productos WHERE id_producto = prod);
//

CREATE PROCEDURE sp_registrar_venta(
    IN p_cliente INT,
    IN p_empleado INT,
    IN p_detalle JSON,
    IN p_total DECIMAL(12,2),
    IN p_metodo_pago ENUM('EFECTIVO','TARJETA','TRANSFERENCIA','OTRO')
)
BEGIN
    INSERT INTO ventas(cliente_id, empleado_id, total, metodo_pago, detalle)
    VALUES(p_cliente, p_empleado, p_total, p_metodo_pago, p_detalle);
END;
//

CREATE PROCEDURE sp_reporte_ventas_cliente(
    IN p_cliente INT,
    IN p_fecha_inicio DATETIME,
    IN p_fecha_fin DATETIME
)
BEGIN
    SELECT v.id_venta, v.fecha, v.total, v.metodo_pago, v.detalle
    FROM ventas v
    WHERE v.cliente_id = p_cliente AND v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END;
//

DELIMITER ;
