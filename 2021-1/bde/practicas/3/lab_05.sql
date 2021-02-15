drop database pacientes_003;
create database pacientes_003;

\c pacientes_003;

create table domicilio(
  id_domicilio integer,
  calle varchar(100) not null,
  no_ext varchar(5) not null,
  colonia varchar(100) not null,
  primary key (id_domicilio)
);

create table paciente (
  id_paciente integer, 
  nombre_paciente varchar(50) not null,
  id_domicilio_paciente integer,
  primary key (id_paciente),
  constraint fk_domicilio foreign key (id_domicilio_paciente)
    references domicilio(id_domicilio)
);

create table enfermedad (
  id_enfermedad integer,
  nombre_enferemedad varchar(40) not null,
  tipo_enferemedad varchar(40) not null,
  primary key (id_enfermedad)
);

create table padece (
  id_enfermedad integer,
  id_paciente integer,
  primary key (id_enfermedad, id_paciente), 
  constraint fk_paciente foreign key (id_paciente)
    references paciente(id_paciente),
  constraint fk_enfermedad foreign key (id_enfermedad)
    references enfermedad(id_enfermedad)
);

create table familiar (
  id_familiar integer,
  id_paciente integer,
  parentesco varchar(40) not null,
  primary key (id_familiar, id_paciente),
  constraint fk_paciente foreign key (id_paciente)
    references paciente(id_paciente)
);
