// Name: s-03-queries.cql
// Description: Script for graph queries
// Author: @nestorivanmo

// -----------------------------------------------------------------------------
// 1. Dado un estado y un producto, buscar lugares donde pueda encontrarlo
// Nota: en lugar de usar producto estoy usando la categoría de producto, ofrece
// mejores resultados
// -----------------------------------------------------------------------------
MATCH (p:Product {product_category:"ropa"})
    <-[r:SELLS]-(s:Store)--(st:State {state_name:'distrito federal'})
RETURN st.state_name, s.store_county, s.store_name, p.product_name


// -----------------------------------------------------------------------------
// 2. Dado un estado y una tienda, verificar si tiene algun incumplimiento con 
// un producto.
// -----------------------------------------------------------------------------
MATCH (st:State {state_name:'distrito federal'})
    <-[r:LOCATED_IN]-(s:Store {store_name:'cadena comercial oxxo s.a. de c.v.'})
    -[r2:SELLS]->(p:Product) 
WHERE r2.missing <> "no se detecto incumplimiento"
RETURN st.state_name, s.store_name, r2.missing


// -----------------------------------------------------------------------------
// 3. Dado un estado y un producto, buscar alternativas sin incumplimiento de ese
// producto o categoría.
// Nota: en lugar de usar producto estoy usando la categoría de producto, ofrece
// mejores resultados
// -----------------------------------------------------------------------------

MATCH (state:State {state_name:'distrito federal'})
    <-[:LOCATED_IN]-(store:Store)-[r:SELLS]->(p:Product) 
WHERE r.missing <> 'no se detecto incumplimiento' 
RETURN state.state_name, store.store_name, p.product_category, p.product_name, r.missing


MATCH (state:State {state_name:'distrito federal'})
    <-[:LOCATED_IN]-(store:Store)-[r:SELLS]->
    (p:Product {product_category:'telefonos'}) 
WHERE r.missing = 'no se detecto incumplimiento' 
RETURN state.state_name, store.store_name, p.product_category, p.product_name, 
    r.missing


// -----------------------------------------------------------------------------
// Registro de compras y lugares visitados por usuario
// -----------------------------------------------------------------------------
MATCH p=()-[r:BUYS]->() RETURN p LIMIT 25


// -----------------------------------------------------------------------------
// 5. Encontrar los estados con mayor y menor incumplimiento relativo al número 
// de tiendas que tiene.
// -----------------------------------------------------------------------------
match (state:State)<-[r:LOCATED_IN]-(store:Store)
call {
    with store
    match (store)-[r:SELLS]->(p:Product)
    where r.missing <> 'no se detecto incumplimiento'
    return count(p) as missing_items
}
return state.state_name, sum(missing_items) as num_productos_sin_cumplir,
    count(store) as num_tiendas, round(toFloat(sum(missing_items))/toFloat(count(store)),3) 
    as indicador_incumplimiento
order by indicador_incumplimiento