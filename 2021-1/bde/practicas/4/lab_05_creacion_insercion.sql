---@Autor(es): 					Néstor Martínez Ostoa
---@Fecha de creación: 	19/10/2020
---@Descripción: 				Contiene creación e inserción de datos
---@Práctica:           Práctica 4 - Actividad 5
---@Equipo:             003
---@Materia:            Bases de Datos Estructuradas - Ciencia de Datos
---@Institución:        IIMAS - UNAM

drop database empleados_003;
create database empleados_003;

\c empleados_003;

---
--- Tabla: proyectos
---
create table proyectos (
  id_Proy varchar(10),
  Nombre_Proyecto varchar(50),
  constraint pk_Proy primary key (id_Proy)
);

---
--- Tabla: empleados
---
create table empleados (
  id_Empleado varchar(10),
  Nombre_Empleado varchar(50) not null,
  id_Proy varchar(10),
  constraint pk_Empleado primary key (id_Empleado),
  constraint fk_Proy foreign key (id_Proy)
    references proyectos(id_Proy)
);

---
--- Inserción de datos en proyectos
---
insert into proyectos(id_Proy, Nombre_Proyecto) values ('PROY001', 
'Inteligencia Negocio');
insert into proyectos(id_Proy, Nombre_Proyecto) values ('PROY002', 
'Big Data');
insert into proyectos(id_Proy, Nombre_Proyecto) values ('PROY003', 
'Aseguramiento Calidad');

---
--- Inserción de datos en empleados
---
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP001', 'Juan Pérez', 'PROY001'
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP002', 'Pedro López', NULL
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP004', 'Armando Contreras', NULL
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP005', 'Elisa Ramírez', 'PROY003'
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP007', 'Laura Rodríguez', 'PROY003'
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP009', 'Esteban Gutiérrez', 'PROY001'
);
insert into empleados(id_Empleado, Nombre_Empleado, id_Proy) values (
  'EMP010', 'Claudia Méndez', 'PROY003'
);