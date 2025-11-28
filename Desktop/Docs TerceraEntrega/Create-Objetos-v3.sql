USE verduleria;

-- =========================
-- VISTAS
-- =========================

CREATE OR REPLACE VIEW vista_ventas_cliente AS
SELECT c.id_cliente, c.nombre, c.apellido, SUM(v.total) AS total_ventas
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido;

CREATE OR REPLACE VIEW vista_productos_bajo_stock AS
SELECT id_producto, nombre, stock
FROM productos
WHERE stock < 10;

CREATE OR REPLACE VIEW vista_detalle_ventas AS
SELECT v.id_venta,
       v.fecha,
       c.nombre AS cliente,
       e.nombre AS empleado,
       jt.nombre_producto AS producto,
       dp.proveedor,
       jt.cantidad
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id_cliente
JOIN empleados e ON v.empleado_id = e.id_empleado
JOIN JSON_TABLE(
    v.detalle,
    '$[*]' COLUMNS (
        id_producto INT PATH '$.id_producto',
        cantidad DECIMAL(10,3) PATH '$.cantidad',
        nombre_producto VARCHAR(100) PATH '$.nombre'
    )
) AS jt
JOIN productos p ON p.id_producto = jt.id_producto
JOIN detalle_producto dp ON dp.id_producto = jt.id_producto;

-- =========================
-- FUNCIONES
-- =========================
DELIMITER //

CREATE FUNCTION fn_total_ventas_cliente(p_cliente INT) 
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE res DECIMAL(12,2);
    SELECT IFNULL(SUM(total),0) INTO res FROM ventas WHERE cliente_id = p_cliente;
    RETURN res;
END;
//

CREATE FUNCTION fn_stock_producto(p_producto INT) 
RETURNS DECIMAL(10,3)
DETERMINISTIC
BEGIN
    DECLARE s DECIMAL(10,3);
    SELECT IFNULL(stock,0) INTO s FROM productos WHERE id_producto = p_producto;
    RETURN s;
END;
//

CREATE FUNCTION fn_ganancia_total(p_inicio DATETIME, p_fin DATETIME)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE g DECIMAL(12,2);
    SELECT IFNULL(SUM(total),0) INTO g FROM ventas WHERE fecha BETWEEN p_inicio AND p_fin;
    RETURN g;
END;
//

CREATE FUNCTION fn_promedio_compra_cliente(p_cliente INT) 
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE m DECIMAL(12,2);
    SELECT IFNULL(AVG(total),0) INTO m FROM ventas WHERE cliente_id = p_cliente;
    RETURN m;
END;
//

CREATE FUNCTION fn_cantidad_ventas_empleado(p_empleado INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE c INT;
    SELECT IFNULL(COUNT(*),0) INTO c FROM ventas WHERE empleado_id = p_empleado;
    RETURN c;
END;
//

DELIMITER ;

-- =========================
-- PROCEDIMIENTOS
-- =========================
DELIMITER //

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
    IN p_inicio DATETIME,
    IN p_fin DATETIME
)
BEGIN
    SELECT v.id_venta, v.fecha, v.total, v.metodo_pago, v.detalle
    FROM ventas v
    WHERE v.cliente_id = p_cliente AND v.fecha BETWEEN p_inicio AND p_fin;
END;
//

CREATE PROCEDURE sp_top_productos(IN p_cantidad INT)
BEGIN
    SELECT p.nombre, SUM(JSON_EXTRACT(v.detalle, '$[*].cantidad')) AS total_vendido
    FROM ventas v
    JOIN productos p ON JSON_CONTAINS(v.detalle, CAST(p.id_producto AS JSON), '$[*].id_producto')
    GROUP BY p.nombre
    ORDER BY total_vendido DESC
    LIMIT p_cantidad;
END;
//

CREATE PROCEDURE sp_reporte_ganancias(IN p_inicio DATETIME, IN p_fin DATETIME)
BEGIN
    SELECT SUM(total) AS ganancia_total
    FROM ventas
    WHERE fecha BETWEEN p_inicio AND p_fin;
END;
//

CREATE PROCEDURE sp_resumen_empleado(
    IN p_empleado INT,
    IN p_inicio DATETIME,
    IN p_fin DATETIME
)
BEGIN
    SELECT COUNT(*) AS ventas_realizadas, SUM(total) AS total_vendido
    FROM ventas
    WHERE empleado_id = p_empleado AND fecha BETWEEN p_inicio AND p_fin;
END;
//

DELIMITER ;

-- =========================
-- TRIGGERS
-- =========================
DELIMITER //

CREATE TRIGGER trg_auditoria_productos_insert
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos(accion,id_producto,nombre,precio,stock)
    VALUES('INSERT',NEW.id_producto,NEW.nombre,NEW.precio,NEW.stock);
END;
//

CREATE TRIGGER trg_auditoria_productos_update
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos(accion,id_producto,nombre,precio,stock)
    VALUES('UPDATE',NEW.id_producto,NEW.nombre,NEW.precio,NEW.stock);
END;
//

CREATE TRIGGER trg_auditoria_productos_delete
AFTER DELETE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_productos(accion,id_producto,nombre,precio,stock)
    VALUES('DELETE',OLD.id_producto,OLD.nombre,OLD.precio,OLD.stock);
END;
//

CREATE TRIGGER trg_actualiza_stock
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE prod_id INT;
    DECLARE cantidad DECIMAL(10,3);

    WHILE i < JSON_LENGTH(NEW.detalle) DO
        SET prod_id = JSON_EXTRACT(NEW.detalle, CONCAT('$[',i,'].id_producto'));
        SET cantidad = JSON_EXTRACT(NEW.detalle, CONCAT('$[',i,'].cantidad'));
        
        UPDATE productos SET stock = stock - cantidad
        WHERE id_producto = prod_id;

        SET i = i + 1;
    END WHILE;
END;
//

DELIMITER ;
