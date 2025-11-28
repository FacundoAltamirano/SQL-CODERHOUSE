Proyecto Final - Tercera Entrega
Alumno: Facundo Gastón Altamirano
Fecha de entrega: 28/11/2025
Base de datos: Verdulería

1. Introducción

La tercera entrega representa el cierre del proyecto final del curso de SQL.
En esta instancia se consolidó la base de datos completa de una verdulería, incorporando nuevas entidades, procesos internos, automatización de stock y consultas analíticas.
El objetivo principal fue transformar un modelo inicial simple en un sistema robusto, escalable y preparado para cubrir operaciones reales: compras, ventas, control de inventario, proveedores, reportes y auditoría de datos.

2. Objetivo

Los objetivos específicos de esta entrega fueron:
Completar el modelo relacional incorporando todas las áreas del negocio.
Implementar tablas transaccionales y una tabla de hechos para análisis posterior.
Crear triggers avanzados que automaticen movimientos y control de stock.
Agregar stored procedures y funciones para estandarizar operaciones.
Construir vistas para reportes rápidos y análisis de ventas.
Documentar todo el proceso en un repositorio ordenado y auditable.
Generar un informe analítico en Excel / Power BI.

3. Situación problemática
En el día a día de la verdulería, gestionar todas las operaciones de forma manual resultaba complicado y propenso a errores. 
Entre los principales problemas estaban:
El control del stock se hacía manualmente, lo que generaba errores y pérdidas de información.
No existía un registro completo de compras ni de proveedores, dificultando la reposición de productos.
No se llevaba un historial de cambios en el inventario, lo que complicaba identificar errores o faltantes.
Las ventas no estaban completamente normalizadas, y el detalle de los productos vendidos no se registraba de manera estructurada, dificultando la obtención de reportes confiables.
Los métodos de pago no estaban estandarizados, complicando el seguimiento financiero.
Por estas razones, se desarrolló esta base de datos, que permite automatizar la actualización de stock, registrar proveedores y ventas de manera organizada, auditar cambios en los productos y generar reportes confiables, facilitando así la gestión diaria de la verdulería.

4. Modelo de negocio

El sistema final administra:
Inventario (entrada, salida y stock disponible).
Compras a proveedores.
Ventas detalladas a clientes, asociadas a empleados.
Descuento automático de stock.
Historial de movimientos por cada operación.
Reportes analíticos de ventas, productos y rendimiento.
El modelo abarca todo el ciclo comercial de una verdulería real.

5. Diagrama

![Diagrama ER Verdulería](Desktop/Docs%20TerceraEntrega/Diagrama-TerceraEntrega.png)

6. Listado de tablas y objetos

Tablas principales
productos: almacena información general de los productos.
detalle_producto: información de proveedores, origen y descripción.
clientes: datos de clientes para ventas.
empleados: datos de los vendedores y repositores.
ventas: registra ventas, relacionando clientes, empleados y detalle de productos.
auditoria_productos: historial de cambios en productos (insert, update, delete).

Objetos adicionales

Vistas:
vista_ventas_cliente → total de ventas por cliente.
vista_productos_bajo_stock → productos con stock menor a 10.
vista_detalle_ventas → detalle de ventas incluyendo cliente, empleado y productos.
Funciones:
fn_total_ventas_cliente → suma total de ventas por cliente.
fn_stock_producto → devuelve stock actual de un producto.
fn_ganancia_total → suma total de ventas en un rango de fechas.
fn_promedio_compra_cliente → promedio de compra por cliente.
fn_cantidad_ventas_empleado → cantidad de ventas realizadas por un empleado.

Stored Procedures:

sp_registrar_venta → inserta una venta nueva.
sp_reporte_ventas_cliente → reporte de ventas por cliente y rango de fechas.
sp_top_productos → top N productos vendidos.
sp_reporte_ganancias → ganancias totales en un rango de fechas.
sp_resumen_empleado → resumen de ventas por empleado.

Triggers:

Auditoría de productos (INSERT, UPDATE, DELETE).

7. Creación (scripts)

Scripts disponibles en orden recomendado:

create-verduleria.sql → crea la base de datos y todas las tablas principales.
create-objetos.sql → crea vistas, funciones, stored procedures y triggers.
insertar-verduleria.sql → inserta datos iniciales de prueba.
prueba-funcionamiento.sql → verifica vistas, funciones, SPs y triggers.

8. Prueba de funcionamiento

Se realizaron pruebas para verificar que todos los elementos del sistema funcionan correctamente. Estas incluyen:
Consultas a las vistas: vista_ventas_cliente, vista_productos_bajo_stock y vista_detalle_ventas.
Llamadas a las funciones: fn_ganancia_total, fn_promedio_compra_cliente y fn_cantidad_ventas_empleado.
Ejecución de los procedimientos almacenados: sp_top_productos, sp_reporte_ganancias y sp_resumen_empleado.
Validación de los triggers de auditoría al insertar, actualizar y eliminar productos.

Resultados esperados:

Las vistas muestran correctamente la información de clientes, productos y ventas.
Las funciones y procedimientos almacenados devuelven totales y resúmenes precisos.
La tabla auditoria_productos registra cada cambio realizado en los productos.

9. Pruebas realizadas

Durante la implementación se realizaron pruebas concretas para asegurar el correcto funcionamiento del sistema:
Inserción de nuevas ventas y verificación de que el stock se actualice automáticamente.
Actualización de productos y confirmación de que los cambios queden registrados en la auditoría.
Eliminación de productos y verificación de que la acción se registre correctamente en la auditoría.
Consultas de los productos más vendidos mediante sp_top_productos.
Generación de reportes de ganancias y resúmenes de ventas por empleado.

10. Mejoras implementadas en la tercera entrega

En esta entrega se lograron importantes mejoras sobre el sistema inicial:
Normalización completa de las tablas de ventas y productos, facilitando la gestión y el análisis de datos.
Implementación de triggers para auditar automáticamente los cambios en los productos.
Creación de vistas que permiten generar reportes y análisis de forma rápida y confiable.
Incorporación de funciones y procedimientos para cálculos automáticos de ventas, stock y resúmenes.
Inclusión de datos de prueba para facilitar el testeo inmediato del sistema.

11. Paso a paso de ejecución de scripts


1. Ejecutar [create-verduleria.sql](Desktop/Docs%20TerceraEntrega/Create-Verduleria-v3.sql) para crear la base de datos y tablas.  
2. Ejecutar [create-objetos.sql](Desktop/Docs%20TerceraEntrega/Create-Objetos-v3.sql) para crear triggers, vistas, funciones y stored procedures.  
3. Ejecutar [insertar-verduleria.sql](Desktop/Docs%20TerceraEntrega/Insertar-Verduleria-v3.sql) para insertar datos iniciales en las tablas.  
4. Ejecutar [prueba-funcionamiento.sql](Desktop/Docs%20TerceraEntrega/Prueba-Funcionamiento-v3.sql) para verificar que todo funciona correctamente y probar triggers, vistas y funciones.


12. Herramientas y referencias

MySQL Workbench 8.0
DrawSQL / dbdiagram.io para diagramas ER
Excel y Power BI para análisis y reportes
Documentación oficial de MySQL (JSON_TABLE, triggers, funciones)


13. Informe Analítico – Verdulería

Periodo analizado: 2024-01-01 a 2025-12-31

Ventas por cliente

| Cliente        | Total Vendido | Promedio de Compra | Cantidad de Ventas |
| -------------- | ------------- | ------------------ | ------------------ |
| María Gómez    | $250          | $250               | 1                  |
| Carlos Gómez   | $200          | $200               | 1                  |
| Lucía Martínez | $300          | $300               | 1                  |


Objetivo: Mostrar el total vendido, promedio de compra y cantidad de ventas por cliente, utilizando vista_ventas_cliente y fn_promedio_compra_cliente.

Productos más vendidos

| Producto  | Cantidad Vendida |
| --------- | ---------------- |
| Tomate    | 4 kg             |
| Papa      | 3 kg             |
| Manzana   | 3 kg             |
| Zanahoria | 2 kg             |
| Lechuga   | 1 kg             |


Objetivo: Identificar los productos con mayor demanda, obtenido a través de sp_top_productos y vista_detalle_ventas.

Productos con bajo stock

| Producto | Stock Actual |
| -------- | ------------ |
| Manzana  | 7            |


Objetivo: Mostrar los productos que requieren reposición, usando vista_productos_bajo_stock.

Rendimiento de empleados

| Empleado      | Cantidad de Ventas | Total Vendido |
| ------------- | ------------------ | ------------- |
| Juan Pérez    | 1                  | $250          |
| Ana López     | 1                  | $200          |
| Diego Ramírez | 1                  | $300          |


Objetivo: Analizar el desempeño de los empleados en ventas, utilizando fn_cantidad_ventas_empleado y sp_resumen_empleado.

Ganancias Totales

| Periodo                 | Ganancia Total |
| ----------------------- | -------------- |
| 2024-01-01 a 2025-12-31 | $750           |


Objetivo: Total de ingresos generados en el periodo, calculado mediante fn_ganancia_total o sp_reporte_ganancias.

Auditoría de Productos

| Acción | Cantidad |
| ------ | -------- |
| INSERT | 1        |
| UPDATE | 1        |
| DELETE | 1        |


Objetivo: Registrar los cambios en los productos (insert, update, delete) usando el trigger trg_auditoria_productos.