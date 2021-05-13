#-------------------------------------------------------------------------------
# Query:
# Obtener la categoría preferida de un cliente dado
#-------------------------------------------------------------------------------
SELECT username, category, category_frequency AS frequency FROM
    favorite_category_by_client WHERE username = 'néstor' GROUP BY username;

#-------------------------------------------------------------------------------
# Query:
# Obtener los clientes que más disfrutaron un libro dado
# Libro: Cien años de soledad
#-------------------------------------------------------------------------------
SELECT * FROM most_satisfied_clients_by_book WHERE score IN (8, 9, 10) AND 
    book_title = 'Cien años de soledad';


#-------------------------------------------------------------------------------
# Query:
# Obtener los mejores libros de una categoría dada
# Categoría: novela
#-------------------------------------------------------------------------------
SELECT * FROM best_books_by_category WHERE score IN (9,10) AND 
    book_category = 'politica' LIMIT 10;
