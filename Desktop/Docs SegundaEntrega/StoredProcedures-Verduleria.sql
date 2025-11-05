DELIMITER //
CREATE PROCEDURE sp_registrar_venta(
    IN p_cliente_id INT,
    IN p_empleado_id INT,
    IN p_total DECIMAL(12,2),
    IN p_metodo_pago ENUM('EFECTIVO','TARJETA','TRANSFERENCIA','OTRO'),
    IN p_detalle JSON,
    IN p_observaciones TEXT
)
BEGIN
    INSERT INTO ventas(cliente_id, empleado_id, total, metodo_pago, detalle, observaciones)
    VALUES(p_cliente_id, p_empleado_id, p_total, p_metodo_pago, p_detalle, p_observaciones);
END;
//
DELIMITER ;
