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

select Tp.tipo_producto_desc as grupo_desc, Cl.nombre_cliente as nombre_titular, 
    C.ciudad_descripcion as ciudad, S.nombre_suc as sucursal, H.saldo, Di.fecha
from hecho H
join sucursal S on H.sucursal_id = S.sucursal_id
join direccion D on H.direccion_id = D.direccion_id
join ciudad C on D.ciudad_id = C.ciudad_id
join cuenta Ct on H.cuenta_id = Ct.cuenta_id
join producto P on Ct.producto_id = P.producto_id
join tipoproducto Tp on P.tipo_producto_id = Tp.tipo_producto_id
join cliente Cl on H.cliente_id = Cl.cliente_id
join dia Di on H.dia_id = Di.dia_id
where Tp.tipo_producto_desc = 'Checking' and (Di.fecha::text = '2018-12-31'
    or Di.fecha::text = '2019-12-31' or Di.fecha::text = '2020-12-31'
    or Di.fecha::text = '2017-12-31'
);

--
-- Actividad 2: generar un reporte que presente la sucursal que más cuentas de 
-- hipoteca (15,30,etc. cualquiertipo de Mortgage) tiene en los últimos tres años
--

select S.nombre_suc as nombre_suc, count(*) as numero_cuentas
from hecho H
join sucursal S on H.sucursal_id = S.sucursal_id
join cuenta Ct on H.cuenta_id = Ct.cuenta_id
join producto P on Ct.producto_id = P.producto_id
join tipoproducto Tp on P.tipo_producto_id = Tp.tipo_producto_id
join dia D on H.dia_id = D.dia_id
where Tp.tipo_producto_desc = 'Mortgage' and D.fecha between '2017-01-01' and
   '2020-12-31'
group by S.nombre_suc;

-- Actividad 3



-- Actividad 4

SELECT 
FROM cliente c
INNER JOIN hecho c
USING (llave_cliente)
INNER JOIN producto p
USING (llave_producto)
HAVING max(c.ingreso) = (SELECT max(ingreso) from cliente);