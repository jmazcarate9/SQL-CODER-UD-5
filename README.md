# SQL-CODER-UD-5

### 1. ¿Por qué usaste `LEFT JOIN` para la Consulta 1 y no `INNER JOIN`? ¿Qué se perdería si usaras `INNER JOIN`?

Utilicé `LEFT JOIN` porque en la Consulta 1 necesitábamos mostrar **todos los productos del catálogo**, incluso aquellos que nunca fueron vendidos.

Con `LEFT JOIN`, la tabla `productos` queda a la izquierda y se conservan todos sus registros. Cuando un producto no tiene una venta asociada, las columnas correspondientes a `ventas` aparecen con `NULL`.

Si utilizáramos `INNER JOIN`, solamente aparecerían los productos que tienen al menos una venta. En este caso, se perderían los productos **108 (Hub USB-C 7p)** y **109 (Parlante Bluetooth)**, ya que nunca fueron vendidos.

---

### 2. ¿Por qué usaste `RIGHT JOIN` para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha en tu consulta?

Utilicé `RIGHT JOIN` porque en la Consulta 2 necesitábamos conservar **todas las ventas**, incluso aquellas cuyo producto no figura en el catálogo.

En la consulta, la tabla que está a la izquierda es `productos` y la tabla que está a la derecha es `ventas`:

```sql
FROM productos
RIGHT JOIN ventas
    ON productos.producto_id = ventas.producto_id
```

Por lo tanto, `RIGHT JOIN` garantiza que todas las filas de `ventas` aparezcan en el resultado. Si una venta no tiene un producto correspondiente en el catálogo, las columnas de `productos` aparecen como `NULL`.

En nuestros datos, esto ocurre con la venta `10`, que tiene `producto_id = 999`, un producto que no existe en la tabla `productos`.

---

### 3. ¿Qué representan los valores `NULL` en cada resultado?

Los `NULL` representan que **no existe un registro coincidente en la otra tabla**.

En la **Consulta 1**, `venta_id = NULL` significa que ese producto existe en el catálogo pero **no tiene ninguna venta asociada**.

Por ejemplo, los productos `108` (Hub USB-C 7p) y `109` (Parlante Bluetooth) nunca fueron vendidos. Por eso aparecen con `NULL` en las columnas de `ventas`.

En la **Consulta 2**, que `productos.producto_id = NULL` significa que existe una venta cuyo producto **no existe en el catálogo**.

Por ejemplo, la venta `10` tiene `producto_id = 999`, pero no existe ningún producto con ese ID en la tabla `productos`. Por eso las columnas correspondientes a `productos` aparecen como `NULL`.

---

### 4. ¿Cuándo usarías `FULL OUTER JOIN` en un caso real de negocio?

Utilizaría `FULL OUTER JOIN` cuando necesitara comparar o auditar dos conjuntos de datos y quisiera **conservar todos los registros de ambas tablas**, incluso aquellos que no tienen coincidencia.

Por ejemplo, en una empresa podría utilizarse para comparar un **catálogo de productos con un sistema de ventas** y detectar simultáneamente:

* Productos que existen en el catálogo pero nunca tuvieron ventas.
* Ventas registradas con productos que no existen en el catálogo.
* Productos que tienen ventas correctamente asociadas.

De esta manera, `FULL OUTER JOIN` permite realizar una **auditoría completa de la información**, sin perder registros de ninguna de las dos tablas.
