CREATE KEYSPACE IF NOT EXISTS "books_keyspace" 
  WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 1
  }
AND DURABLE_WRITES = false; 

USE "books_keyspace";

CREATE TABLE IF NOT EXISTS "books_keyspace"."books_by_title" (
  "book_title" text,
  "book_category" text,
  "authors" set<text>,
  PRIMARY KEY ("book_title")
);

CREATE TABLE IF NOT EXISTS "books_keyspace"."books_by_username" (
  "username" text,
  "book_title" text,
  "book_category" text,
  "book_authors" set<text>,
  "score" smallint,
  PRIMARY KEY ("username", "book_title", "book_category")
)
WITH CLUSTERING ORDER BY ("book_title" ASC, "book_category" ASC);

CREATE TABLE IF NOT EXISTS "books_keyspace"."books_by_score" (
  "score" smallint,
  "book_title" text,
  "book_category" text,
  "authors" set<text>,
  PRIMARY KEY ("score", "book_title", "book_category")
)
WITH CLUSTERING ORDER BY ("book_title" ASC, "book_category" ASC);