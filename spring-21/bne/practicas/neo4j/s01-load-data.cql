// Name: s-01-load-data.cql
// Description: Script for loading data into Neo4j
// Author: @nestorivanmo

// -----------------------------------------------------------------------------
// Load State nodes
// -----------------------------------------------------------------------------
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nestorivanmo/iimas-data-science/master/spring-21/bne/practicas/neo4j/data/states.csv" AS row
CREATE (n:State)
SET n = row

// -----------------------------------------------------------------------------
// Load Store nodes
// -----------------------------------------------------------------------------
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nestorivanmo/iimas-data-science/master/spring-21/bne/practicas/neo4j/data/stores.csv" AS row
CREATE (n:Store)
SET n = row


// -----------------------------------------------------------------------------
// Load Product nodes
// -----------------------------------------------------------------------------
LOAD CSV WITH HEADERS FROM "https://raw.githubusercontent.com/nestorivanmo/iimas-data-science/master/spring-21/bne/practicas/neo4j/data/products.csv" AS row
CREATE (n:Product)
SET n = row