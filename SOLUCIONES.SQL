-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: José Azcarate
-- Fecha: 05/09/2026
-- ══════════════════════════════════════════

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: 
-- ¿Qué productos del catálogo nunca fueron vendidos?
-- Mostrá todos los productos y sus ventas asociadas.
-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.

SELECT 
    productos.producto_id,
    productos.nombre,
    productos.categoria,
    productos.precio,
	ventas.venta_id
FROM productos
LEFT JOIN ventas
    ON productos.producto_id = ventas.producto_id
WHERE ventas.venta_id IS NULL;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)
-- Los registros huérfanos aparecerán con NULL en las columnas de productos.

SELECT 
    ventas.venta_id,
    ventas.producto_id,
    ventas.cliente_id,
    ventas.cantidad,
    ventas.fecha_venta,
    productos.nombre,
    productos.categoria,
    productos.precio
FROM productos
RIGHT JOIN ventas
   ON ventas.producto_id = productos.producto_id
WHERE productos.nombre IS NULL;

-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila,
-- identificando tanto productos sin ventas como ventas sin producto.
SELECT 
    productos.producto_id,
    productos.nombre,
    productos.categoria,
    productos.precio,
    ventas.venta_id,
    ventas.cliente_id,
    ventas.cantidad,
    ventas.fecha_venta
FROM productos
FULL OUTER JOIN ventas
    ON productos.producto_id = ventas.producto_id;
