--@Autores:               Barrero Olguín Patricio
--                        Martínez Ostoa Néstor
--                        Ramírez Bondi Alejandro
--@Fecha de creación:     11/01/2021
--@Descripción:           Consultas OLAP para ServiciosFinacieros Copo de nieve

--
-- Actividad 1: generar  un  reporte para  saber  los saldos  de  los grupos de
-- cuentas  de cheques por sucursal por ciudad el último día de diciembre de 
-- cada año. La salida deberá presentar el siguiente formato: Grupo_desc, 
-- nombre_titular, saldo  para tipo_producto:”Checking”en 31/12/20XX
--

select LP.tipo_producto_desc as grupo_desc, LC.nombre_cliente as cliente,
    FSF.saldo as saldo, Lt.fecha
from fact_serv_financieros FSF
join lookup_cliente LC on FSF.llave_cliente = LC.llave_cliente
join lookup_producto LP on FSF.llave_producto = LP.llave_producto
join lookup_tiempo LT on FSF.llave_tiempo = LT.llave_tiempo
where LP.tipo_producto_desc = 'Checking' and (Lt.fecha::text = '2018-12-31'
    or Lt.fecha::text = '2019-12-31' or Lt.fecha::text = '2020-12-31'
    or Lt.fecha::text = '2017-12-31'
);

--
-- Actividad 2: Utilizar programación SQL para generar un reporte que presente la 
-- sucursal que más cuentas de hipoteca (15,30, etc. cualquier tipo de Morgage) 
-- tiene en los últimos tres años
-- La salida deberá presentar el siguiente formato:
-- Nombre_suc, número cuentas(30..Mortgage+15..Mortgage+..a lo largo de los tres 
-- años)
-- ¿Qué puede concluir, recomendar o decisión tomar a partir de esta información?
--

select LO.nombre_suc as nombre_suc, count(*) as numero_cuentas
from fact_serv_financieros FSF
join lookup_organizacion LO on FSF.llave_org = LO.llave_org
join lookup_producto LP on FSF.llave_producto = LP.llave_producto
join lookup_tiempo LT on FSF.llave_tiempo = LT.llave_tiempo
where LP.tipo_producto_desc = 'Mortgage' and LT.fecha between '2017-01-01' and 
    '2020-12-31'
group by LO.nombre_suc;

--
-- Actividad 3: Generar un reporte que presente el estado que tiene más préstamos 
-- personales y lo desglose por ciudad La salida deberá presentar el siguiente 
-- formato: (solo un estado, el de mas cuentas, a menos que el máximo se repita) 
-- Estado_desc1, numero de prestamos personales, null
-- Estado_desc1, numero de prestamos personales1, ciudad1				
-- Estado_desc1, numero de prestamos personales2, ciudad2
-- (Donde prestamos personales1+prestamos personales2 me da el del Estado) 
-- ¿Qué puede concluir, recomendar o decisión tomar a partir de esta información?
--

SELECT
	estado_desc, ciudad_desc, count(llave_producto)
FROM
	fact_serv_financieros
	INNER JOIN lookup_geografia ON fact_serv_financieros.llave_geografia = lookup_geografia.llave_geografia
WHERE
	llave_producto IN (
		SELECT
			llave_producto
		FROM
			lookup_producto
		WHERE
			tipo_producto_desc = 'Personal Loan'
	) group by estado_desc, ciudad_desc;

--
-- Actividad 4: Se requiere saber qué cliente es el que tiene más cuentas 
-- actualmente en todo el Sistema Financiero, su edad, estado civil y los ingresos 
-- que tiene.
-- La salida deberá presentar el siguiente formato: (solo un registro, el de máximo 
-- numero de cuentas, a menos que el máximo se repita)
-- nombre_cliente, producto_desc1,edad,genero,estado_civil
--

SELECT
	nombre_cliente,
	edad,
	genero,
	estadocivil,
	COUNT(cliente_id)
FROM
	lookup_cliente
	INNER JOIN fact_serv_financieros ON lookup_cliente.llave_cliente = fact_serv_financieros.llave_cliente
GROUP BY
	nombre_cliente,
	edad,
	genero,
	estadocivil;
HAVING
	COUNT(cliente_id)=(
		SELECT
			MAX(cuenta_cli)
		FROM
			(
				SELECT
					COUNT(cliente_id) cuenta_cli
				FROM
					lookup_cliente
				GROUP BY
					nombre_cliente
			) AS count_cliente
	);

--
-- Actividad 5: ¿Cuáles son los pares de productos que por lo general tienen los 
-- clientes? La salida deberá presentar el siguiente formato:
-- nombre_cliente, producto_desc1, producto_desc2
-- nombre_cliente, prooducto_desc2, producto_desc3
--

SELECT
	nombre_cliente,
	STRING_AGG(producto_desc, ', ') AS Productos
FROM
	(
		SELECT
			nombre_cliente,
			lookup_producto.producto_desc
		FROM
			fact_serv_financieros
			JOIN lookup_cliente ON fact_serv_financieros.llave_cliente = lookup_cliente.llave_cliente
			JOIN lookup_producto ON fact_serv_financieros.llave_producto = lookup_producto.llave_producto
		GROUP BY
			lookup_cliente.nombre_cliente,
			lookup_producto.producto_desc
	) AS sub_query
GROUP BY
	nombre_cliente;
