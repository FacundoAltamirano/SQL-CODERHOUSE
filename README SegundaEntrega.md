Segunda entrega - SQL CODERHOUSE
Alumno: Facundo Gastón Altamirano
Fecha de entrega: 05/11/2025
Base de datos: Verduleria

Objetivo

En esta segunda entrega se amplia el proyecto anterior incorporando una nueva tabla llamada detalle_producto, que permite almacenar información complementaria de cada producto, como su proveedor, origen y unidad de medida.
Ademas, se implementan triggers para control de stock automatico y se definen vistas y funciones que facilitan consultas de gestión y reportes.

Sistema de ventas

El sistema continua orientado a la gestión de una verduleria minorista, con el objetivo de mantener un registro organizado y seguro de todos los movimientos, clientes, empleados y ventas.

Nuevas mejoras implementadas

Se añadio la tabla detalle_producto, relacionada 1:1 con la tabla productos.
Se crearon triggers para actualizar el stock automáticamente después de cada venta.
Se añadieron vistas para consultar información consolidada (por ejemplo, ventas totales por cliente y productos con bajo stock).
Se implementaron funciones y procedimientos almacenados (Stored Procedures) para automatizar tareas comunes y mejorar la consistencia de los datos.

[Diagrama actualizado](Desktop/Docs%20SegundaEntrega/Diagrama-SegundaEntrega.png)

Listado de Tablas
Productos
| Campo       | Tipo               | Clave  |
| ----------- | ------------------ | ------ |
| id_producto | INT AUTO_INCREMENT | PK     |
| codigo      | VARCHAR(30)        | UNIQUE |
| nombre      | VARCHAR(100)       |        |
| precio      | DECIMAL(10,2)      |        |
| stock       | DECIMAL(10,3)      |        |
| categoria   | VARCHAR(50)        |        |
| activo      | TINYINT(1)         |        |
| created_at  | TIMESTAMP          |        |
| updated_at  | TIMESTAMP          |        |


Detalle_Producto
| Campo                                                                                                                              | Tipo               | Clave                        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ------------------ | ---------------------------- |
| id_detalle                                                                                                                         | INT AUTO_INCREMENT | PK                           |
| id_producto                                                                                                                        | INT                | FK -> productos(id_producto) |
| origen                                                                                                                             | VARCHAR(100)       |                              |
| proveedor                                                                                                                          | VARCHAR(100)       |                              |
| unidad_medida                                                                                                                      | VARCHAR(30)        |                              |
| descripcion                                                                                                                        | TEXT               |                              |
| fecha_registro                                                                                                                     | TIMESTAMP          |                              |
Descripcion:
| La tabla `detalle_producto` almacena informacion complementaria sobre los productos, como su origen, proveedor y unidad de medida. |                    |                              |
| Esta vinculada directamente a `productos` mediante una relacion 1:1.                                                               |                    |                              |



Cliente
| Campo      | Tipo               | Clave |
| ---------- | ------------------ | ----- |
| id_cliente | INT AUTO_INCREMENT | PK    |
| nombre     | VARCHAR(100)       |       |
| apellido   | VARCHAR(100)       |       |
| telefono   | VARCHAR(30)        |       |
| direccion  | VARCHAR(200)       |       |
| email      | VARCHAR(100)       |       |
| created_at | TIMESTAMP          |       |


Empleados
| Campo         | Tipo               | Clave |
| ------------- | ------------------ | ----- |
| id_empleado   | INT AUTO_INCREMENT | PK    |
| nombre        | VARCHAR(100)       |       |
| apellido      | VARCHAR(100)       |       |
| puesto        | VARCHAR(50)        |       |
| fecha_ingreso | DATE               |       |
| activo        | TINYINT(1)         |       |
| created_at    | TIMESTAMP          |       |


Ventas
| Campo         | Tipo                                              | Clave                        |
| ------------- | ------------------------------------------------- | ---------------------------- |
| id_venta      | INT AUTO_INCREMENT                                | PK                           |
| fecha         | DATETIME                                          |                              |
| cliente_id    | INT                                               | FK -> clientes(id_cliente)   |
| empleado_id   | INT                                               | FK -> empleados(id_empleado) |
| total         | DECIMAL(12,2)                                     |                              |
| metodo_pago   | ENUM('EFECTIVO','TARJETA','TRANSFERENCIA','OTRO') |                              |
| detalle       | JSON                                              |                              |
| observaciones | TEXT                                              |                              |


Vistas
| Vista                      | Tablas involucradas                 | Objetivo                                             |
| -------------------------- | ----------------------------------- | ---------------------------------------------------- |
| vista_ventas_cliente       | ventas, clientes                    | Mostrar total de ventas por cada cliente             |
| vista_productos_bajo_stock | productos                           | Listar productos cuyo stock sea menor a 10           |
| vista_detalle_ventas       | ventas, productos, detalle_producto | Consultar ventas con detalle de producto y proveedor |


Funciones
| Funcion                             | Tablas involucradas | Objetivo                                              |
| ----------------------------------- | ------------------- | ----------------------------------------------------- |
| fn_total_ventas_cliente(cliente_id) | ventas              | Devuelve el total de ventas realizadas por un cliente |
| fn_stock_producto(producto_id)      | productos           | Devuelve el stock actual de un producto               |


Triggers
| Trigger             | Tabla afectada | Objetivo                                                                   |
| ------------------- | -------------- | -------------------------------------------------------------------------- |
| trg_actualiza_stock | ventas         | Reduce automaticamente el stock de los productos segun la venta registrada |


Stored Precedure
| Stored Procedure          | Tablas involucradas | Objetivo                                                                        |
| ------------------------- | ------------------- | ------------------------------------------------------------------------------- |
| sp_registrar_venta        | ventas, productos   | Registrar una venta con detalle de productos y actualizar stock automáticamente |
| sp_reporte_ventas_cliente | ventas, clientes    | Generar un reporte de ventas de un cliente en un rango de fechas                |

Paso a paso de ejecucion de scripts

1.Abrir el cliente MySQL.

2.Ejecutar [Create-Verduleria-v2.sql](Desktop/Docs%20SegundaEntrega/Create-Verduleria-v2.sql)   para crear la base de datos y tablas. ( Teniendo como base la [Primera creación de la entrega uno](Desktop/Docs%20PrimeraEntrega/Create-Verduleria.sql) )

3.Ejecutar [Create-Objetos.sql](Desktop/Docs%20SegundaEntrega/Create-Objetos.sql) para crear triggers, vistas, funciones y stored procedures.

4.Ejecutar [Insertar-Verduleria.sql](Desktop/Docs%20SegundaEntrega/Insertar-Verduleria.sql)   para insertar datos iniciales en las tablas.

5.Ejecutar [Prueba-Funcionamiento-v2.sql](Desktop/Docs%20SegundaEntrega/Prueba-Funcionamiento-v2.sql) para verificar que todo funciona correctamente y probar triggers, vistas y funciones.

Toda la aplicacion fue creada con referencias y ayuda de cursos online, principalmente siguiendo el canal MoureDev en Youtube, y aplicando algunos consejos y buenas practicas de informacion obtenida en cursos de Platzi y Udemy.

Si bien esta segunda entrega no esta completa ni tan prolija como la primera, no pude finalizarla totalmente por falta de tiempo debido al trabajo. De todas formas, se incluyen todas las mejoras que alcance a implementar, como la tabla detalle_producto, los triggers de stock automatico, vistas, funciones y procedimientos almacenados.

El proyecto todavia esta en desarrollo y puede seguir mejorandose. En la tercera entrega se podran completar y pulir todas las funcionalidades para dejarlo mas prolijo y completo.
