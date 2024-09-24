-- Crear la tabla de facturas
CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE,
    subtotal DECIMAL(10, 2),
    total DECIMAL(10, 2)
);

-- Crear la tabla de productos asociados a una factura
CREATE TABLE productos_factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    factura_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (factura_id) REFERENCES facturas(id),
    FOREIGN KEY (producto_id) REFERENCES inventario(id)
);

DELIMITER //

CREATE TRIGGER actualizar_inventario
AFTER INSERT ON productos_factura
FOR EACH ROW
BEGIN
    -- Actualizar el inventario restando la cantidad vendida
    UPDATE inventario
    SET cantidad_disponible = cantidad_disponible - NEW.cantidad
    WHERE id = NEW.producto_id;
END //

DELIMITER ;


insert into inventario(producto, cantidad_disponible)
values ('producto 1',100),
		('producto 2',80);
        
insert into facturas (fecha) values (curdate());
insert into productos_factura (factura_id, producto_id, cantidad, precio_unitario)
values (1, 1, 10, 50.0),
		(1, 2, 5, 100.0);
