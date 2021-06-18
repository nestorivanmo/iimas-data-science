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
CREATE (s)-[:SELLS {missing: ps.missing_requirement}]->(p)
