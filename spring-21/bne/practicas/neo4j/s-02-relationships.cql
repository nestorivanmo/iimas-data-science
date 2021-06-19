// Name: s-02-relationships.cql
// Description: Script for creating relationships between nodes
// Author: @nestorivanmo

// -----------------------------------------------------------------------------
// Store ---> State
// -----------------------------------------------------------------------------
MATCH (store:Store),(state:State)
WHERE store.state_id = state.state_id
CREATE (store)-[:LOCATED_IN]->(state)


// -----------------------------------------------------------------------------
// Store ---> Product
// -----------------------------------------------------------------------------
MATCH (s:Store),(p:Product),(ps:ProductStore)
WHERE ps.store_id = s.store_id AND ps.product_id = p.product_id
CREATE (s)-[:SELLS {missing: ps.missing}]->(p)


// -----------------------------------------------------------------------------
// Client ---> Product
// -----------------------------------------------------------------------------
MATCH (c:Client),(p:Product),(s:Store),(pu:Purchase)
WHERE pu.client_id = c.client_id AND
    pu.product_id = p.product_id AND
    pu.store_id = s.store_id
CREATE (c)-[:BUYS {in_store: s.store_id}]->(p)