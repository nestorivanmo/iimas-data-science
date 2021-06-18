CREATE KEYSPACE IF NOT EXISTS "queries_keyspace" 
  WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
  }
AND DURABLE_WRITES = false; 

USE "queries_keyspace";

CREATE TABLE IF NOT EXISTS "queries_keyspace"."best_books_by_category" (
  "book_category" text,
  "book_title" text,
  "score" smallint,
  "authors" set<text>,
  PRIMARY KEY (("book_category", "score"), "book_title")
)
WITH CLUSTERING ORDER BY ("book_title" ASC);

CREATE TABLE IF NOT EXISTS "queries_keyspace"."most_satissfied_clients_by_book" (
  "book_title" text,
  "score" smallint,
  "username" text,
  "country" text,
  "membership" text,
  "authors" set<text>,
  PRIMARY KEY (("book_title", "score"), "username", "country")
)
WITH CLUSTERING ORDER BY ("username" ASC, "country" ASC);

CREATE TABLE IF NOT EXISTS "queries_keyspace"."favorite_category_by_client" (
  "username" text,
  "category_frequency" int,
  "category" text,
  PRIMARY KEY ("username", "category_frequency")
)
WITH CLUSTERING ORDER BY ("category_frequency" DESC);