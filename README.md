
  Primera entrega - SQL CODERHOUSE
  Alumno: Facundo Gastón Altamirano
  Fecha de entrega: 07/10/2025
  Base de datos: Verdulería


  En este proyecto se aplicaron prácticas aprendidas durante el curso,
  complementadas con material de apoyo como el curso 
  "Curso COMPLETO de SQL y BASES DE DATOS Desde Cero para PRINCIPIANTES"
  de Mouredev (YouTube), así como contenido adicional sobre
  motores de almacenamiento y el uso de DrawSQL para la creación de diagramas y aplicaccion de buenas practicas.
  Ademas, se practico documentacion en Markdraw, aplicando buenas tecnicas en la presentacion del proyecto.

Sistema de ventas

Introduccion
Desarrollar una base de datos para registrar productos, clientes, empleados y ventas de una verduleria.  
Permite llevar control de stock, registrar ventas y generar reportes simples de forma confiable.

Situacion Problemática
Actualmente, el registro de ventas y stock se hace de forma manual. Esto puede provocar errores, perdida de informacion y dificultad para analizar ventas y stock disponible.  

Implementar una base de datos permite:

- Evitar errores en ventas y stock.
- Consultar historial de ventas por cliente o empleado.
- Identificar productos con bajo stock.
  
Modelo de Negocio
La base de datos sirve a una verduleria pequeña:
- Productos: frutas y verduras.
- Clientes: particulares que compran en la verduleria.
- Empleados: quienes registran las ventas.
- Ventas: registro de cada venta, con cliente, empleado, total y detalle de productos (JSON).
- Detalle de producto: Para esta entrega, se optó por registrar el detalle de los productos directamente en formato JSON dentro de la tabla ventas. Esto simplifica el funcionamiento del sistema y evita la complejidad de manejar una tabla adicional para el detalle de venta, manteniendo la informacion suficiente para controlar los productos vendidos y sus cantidades.

 Diagrama
 
![Diagrama](Desktop/Docs/Diagrama%20DrawSQL.png)


 Listado de Tablas

 Productos
| Campo | Tipo | Clave |
|-------------|--------------------|--------|
| id_producto | INT AUTO_INCREMENT | PK     |
| codigo      | VARCHAR(30)        | UNIQUE |
| nombre      | VARCHAR(100)       |        |
| precio      | DECIMAL(10,2)      |        |
| stock       | DECIMAL(10,3)      |        |
| categoria   | VARCHAR(50)        |        |
| activo      | TINYINT(1)         |        |
| created_at  | TIMESTAMP          |        |
| updated_at  | TIMESTAMP          |        |

Clientes
| Campo | Tipo | Clave |
|------------|--------------------|----|
| id_cliente | INT AUTO_INCREMENT | PK |
| nombre     | VARCHAR(100)       |    |
| apellido   | VARCHAR(100)       |    |
| telefono   | VARCHAR(30)        |    |
| direccion  | VARCHAR(200)       |    |
| email      | VARCHAR(100)       |    |
| created_at | TIMESTAMP          |    |

Empleados
| Campo | Tipo | Clave |
|---------------|--------------------|----|
| id_empleado   | INT AUTO_INCREMENT | PK |
| nombre        | VARCHAR(100)       |    |
| apellido      | VARCHAR(100)       |    |
| puesto        | VARCHAR(50)        |    |
| fecha_ingreso | DATE               |    |
| activo        | TINYINT(1)         |    |
| created_at    | TIMESTAMP          |    |

Ventas
| Campo | Tipo | Clave |
|---------------|---------------------------------------------------|-----------------------------|
| id_venta      | INT AUTO_INCREMENT                                | PK                          |
| fecha         | DATETIME                                          |                             |
| cliente_id    | INT                                               | FK → clientes(id_cliente)   |
| empleado_id   | INT                                               | FK → empleados(id_empleado) |
| total         | DECIMAL(12,2)                                     |                             |
| metodo_pago   | ENUM('EFECTIVO','TARJETA','TRANSFERENCIA','OTRO') |                             |
| detalle       | JSON                                              |                             |
| observaciones | TEXT                                              |                             |


[Script SQL](Desktop/Docs/Create-Verduleria.sql)

Prueba funcionamiento
En el siguiente script se agrega un cliente y un empleado, luego se crea un pedido usando esos registros y finalmente se consultan los pedidos para verificar que se hayan registrado correctamente.

[Script SQL](Desktop/Docs/Prueba-Funcionamiento.sql)





