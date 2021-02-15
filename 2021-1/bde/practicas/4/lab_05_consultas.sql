---@Autor(es): 					Néstor Martínez Ostoa
---@Fecha de creación: 	19/10/2020
---@Descripción: 				Consultas a las tablas empleados y proyectos
---@Práctica:           Práctica 4 - Actividad 5
---@Equipo:             003
---@Materia:            Bases de Datos Estructuradas - Ciencia de Datos
---@Institución:        IIMAS - UNAM

---
--- 1: Obtener todos los Empleados que tienen Proyectos asignados
---
select e.*, p.Nombre_Proyecto
from empleados e join proyectos p
on e.id_Proy = p.id_Proy
where e.id_Proy is not null;
  
---
--- 2: De todos los Empleados, quienes tienen Proyecto y quienes no
---
select * from empleados
order by id_Proy;

---
--- 3: Obtener todos los Empleados y los Proyectos, así como los Empleados sin 
---    Proyecto y los Proyectos sin Empleado
--- 
select e.*, p.*
from empleados e full outer join proyectos p 
on e.id_Proy = p.id_Proy;

---
--- 4: Obtener los Empleados sin Proyecto y los Proyectos sin Empleados
---
select e.*, p.*
from empleados e full outer join proyectos p
on e.id_Proy = p.id_Proy
where e.id_Proy is null;

---
--- 5: Obtener los Empleados que no tienen Proyecto asignado
---
select *
from empleados
where id_Proy is null;

---
--- 6: Obtener los Proyectos que no tienen Empleado asignado
--- 
select p.*
from empleados e right join proyectos p
on e.id_Proy = p.id_Proy
where e.id_Proy is null;
