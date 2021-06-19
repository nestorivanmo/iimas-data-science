// Name: s-03-queries.cql
// Description: Script for graph queries
// Author: @nestorivanmo

// -----------------------------------------------------------------------------
// 1. Dado un estado y un producto, buscar lugares donde pueda encontrarlo
// Nota: en lugar de usar producto estoy usando la categoría de producto, ofrece
// mejores resultados
// -----------------------------------------------------------------------------
MATCH (p:Product {product_category:"ropa"})<-[r:SELLS]-(s:Store)--(st:State {state_name:'distrito federal'})
RETURN st.state_name, s.store_county, s.store_name, p.product_name, r.description


// -----------------------------------------------------------------------------
// 2. Dado un estado y una tienda, verificar si tiene algun incumplimiento con 
// un producto.
// -----------------------------------------------------------------------------
MATCH (st:State {state_name:'distrito federal'})<-[r:LOCATED_IN]-(s:Store {store_name:'cadena comercial oxxo s.a. de c.v.'})-[r2:SELLS]->(p:Product) 
WHERE r2.missing <> "no se detecto incumplimiento"
RETURN st.state_name, s.store_name, p.product_category, p.product_name, r2.missing


// -----------------------------------------------------------------------------
// 3. Dado un estado y un producto, buscar alternativas sin incumplimiento de ese
// producto o categoría.
// Nota: en lugar de usar producto estoy usando la categoría de producto, ofrece
// mejores resultados
// -----------------------------------------------------------------------------

MATCH (state:State {state_name:'distrito federal'})<-[:LOCATED_IN]-(store:Store)-[r:SELLS]->(p:Product) 
WHERE r.missing <> 'no se detecto incumplimiento' 
RETURN state.state_name, store.store_name, p.product_category, p.product_name, r.missing


MATCH (state:State {state_name:'distrito federal'})<-[:LOCATED_IN]-(store:Store)-[r:SELLS]->(p:Product {product_category:'telefonos'}) 
WHERE r.missing = 'no se detecto incumplimiento' 
RETURN state.state_name, store.store_name, p.product_category, p.product_name, r.missing


// -----------------------------------------------------------------------------
// 4. Encontrar los estados con mayor y menor incumplimiento relativo al número 
// de tiendas que tiene.
// -----------------------------------------------------------------------------
match (s:Store)-[r:SELLS]->(p:Product)
call {
    with s
    match (s)-[r:SELLS]->(p:Product)
    where r.missing <> 'no se detecto incumplimiento'
    return count(p) as A
}
return s.store_name, A, count(p)