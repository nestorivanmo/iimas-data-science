CREATE KEYSPACE IF NOT EXISTS "clients_keyspace" 
  WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
  }
AND DURABLE_WRITES = false; 

USE "clients_keyspace";

CREATE TABLE IF NOT EXISTS "clients_keyspace"."clients_by_username" (
  "username" text,
  "first_name" text,
  "last_name" text,
  "country" text,
  "membership" text,
  PRIMARY KEY ("username", "last_name", "country")
)
WITH CLUSTERING ORDER BY ("last_name" ASC, "country" ASC);

CREATE TABLE IF NOT EXISTS "clients_keyspace"."clients_by_country" (
  "country" text,
  "username" text,
  "first_name" text,
  "last_name" text,
  "membership" text,
  PRIMARY KEY ("country", "username")
)
WITH CLUSTERING ORDER BY ("username" ASC);

CREATE TABLE IF NOT EXISTS "clients_keyspace"."clients_by_membership" (
  "membership" text,
  "username" text,
  "first_name" text,
  "last_name" text,
  "country" text,
  PRIMARY KEY ("membership", "username")
)
WITH CLUSTERING ORDER BY ("username" ASC);