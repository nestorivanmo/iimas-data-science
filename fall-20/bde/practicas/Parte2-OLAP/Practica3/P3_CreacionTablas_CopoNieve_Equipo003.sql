--@Autores:               Barrero Olguín Patricio
--                        Martínez Ostoa Néstor
--                        Ramírez Bondi Alejandro
--@Fecha de creación:     29/11/2020
--@Descripción:           Creación de base de datos y atributos - Copo de Nieve

drop database if exists serv_financieros_copo_equipo003;
create database serv_financieros_copo_equipo003;
\c serv_financieros_copo_equipo003;

CREATE TABLE Sucursal (
    Sucursal_id NUMERIC(10, 0) NOT NULL,
    nombre_suc VARCHAR(50) NOT NULL,
    CONSTRAINT Sucursal_pk
        PRIMARY KEY (Sucursal_id)
);

CREATE TABLE Estado(
    estado_id  NUMERIC(10, 0) PRIMARY KEY,
    estado_descripcion VARCHAR(50) NOT NULL
);

CREATE TABLE Ciudad(
    Ciudad_id  NUMERIC(10, 0) PRIMARY KEY,
    ciudad_descripcion VARCHAR(50) NOT NULL,
    estado_id NUMERIC(10, 0) NOT NULL,
    CONSTRAINT  Ciudad_estado_id_fk
        FOREIGN KEY (estado_id)
        REFERENCES Estado(Estado_id)
);

CREATE TABLE Direccion(
    Direccion_id  NUMERIC(10, 0) PRIMARY KEY,
    direccion_descripcion VARCHAR(50) NOT NULL,
    ciudad_id NUMERIC(10, 0) NOT NULL,
    CONSTRAINT  Direccion_Ciudad_id_fk
        FOREIGN KEY (ciudad_id)
        REFERENCES Ciudad(Ciudad_id)
);

--CLIENTE

CREATE TABLE Household(
    GRUPO_ID NUMERIC(10, 0) NOT NULL,
    Grupo_Desc VARCHAR(50) NOT NULL,
    CONSTRAINT Grupo_pk
        PRIMARY KEY(GRUPO_ID)
);

CREATE TABLE Ingreso(
    ingreso_id NUMERIC(10, 0) NOT NULL,
    ingreso_desc VARCHAR(50) NOT NULL,
    CONSTRAINT Ingreso_pk 
        PRIMARY KEY (ingreso_id)
);

CREATE TABLE Edad(
    edad_id NUMERIC(10, 0) NOT NULL,
    edad_desc NUMERIC(3, 0) NOT NULL,
    CONSTRAINT Edad_pk 
        PRIMARY KEY (edad_id)
);

CREATE TABLE Genero (
    genero_id NUMERIC(10, 0) NOT NULL,
    genero_desc VARCHAR(20) NOT NULL,
    CONSTRAINT Genero_pk
        PRIMARY KEY genero_id
);

CREATE TABLE EstadoCivil(
    estado_civil_id NUMERIC(10, 0) NOT NULL,
    estado_civil_desc VARCHAR(50) NOT NULL,
    CONSTRAINT EstadoCivil_pk
        PRIMARY KEY estado_civil_id
);

CREATE TABLE Cliente (
    Cliente_id NUMERIC(10, 0) NOT NULL,
    Nombre_cliente VARCHAR(50) NOT NULL,
    household_id NUMERIC(10, 0) NOT NULL,
    ingreso_id NUMERIC(10, 0) NOT NULL,
    edad_id NUMERIC(10, 0) NOT NULL,
    genero_id NUMERIC(10, 0) NOT NULL,
    estado_civil_id NUMERIC(10, 0) NOT NULL,
    CONSTRAINT Cliente_pk 
        PRIMARY KEY (Cliente_id),
    CONSTRAINT Cliente_household_id_fk
        FOREIGN KEY (household_id)
        REFERENCES Household(GRUPO_ID),
    CONSTRAINT Cliente_ingreso_id_fk
        FOREIGN KEY (ingreso_id)
        REFERENCES Ingreso(ingreso_id),
    CONSTRAINT Cliente_edad_id_fk
        FOREIGN KEY (edad_id)
        REFERENCES Edad(edad_id),
    CONSTRAINT Cliente_genero_id_fk
        FOREIGN KEY (genero_id)
        REFERENCES Genero(genero_id),
    CONSTRAINT Cliente_estado_civil_id_fk
        FOREIGN KEY (estado_civil_id)
        REFERENCES EstadoCivil(estado_civil_id)
);

-- PRODUCTO

CREATE TABLE TipoProducto(
    Tipo_Producto_ID NUMERIC(10, 0) NOT NULL,
    Tipo_Producto_Desc VARCHAR(200) NOT NULL,
    CONSTRAINT TipoProducto_pk
        PRIMARY KEY(Tipo_Producto_ID)
);

CREATE TABLE Producto(
    Producto_ID NUMERIC(10, 0) NOT NULL,
    Producto_Desc VARCHAR(200) NOT NULL,
    Tipo_Producto_ID NUMERIC(10, 0) NOT NULL,
    CONSTRAINT Producto_pk
        PRIMARY KEY (Producto_ID),
    CONSTRAINT Producto_tipo_producto_id_fk
        FOREIGN KEY (Tipo_Producto_ID)
        REFERENCES TipoProducto(Tipo_Producto_ID)
);

CREATE TABLE Cuenta(
    Numero_Cuenta NUMERIC(10, 0) NOT NULL,
    Producto_ID NUMERIC(10, 0) NOT NULL,
    CONSTRAINT Cuenta_pk 
        PRIMARY KEY (Numero_Cuenta),
    CONSTRAINT Cuenta_producto_id_fk
        FOREIGN KEY (Producto_ID)
        REFERENCES Producto(Producto_ID)
);

-- TIEMPO

CREATE TABLE Anio(
    anio_id  NUMERIC(10, 0) PRIMARY KEY
);

CREATE TABLE Mes(
    mes_id  NUMERIC(10, 0) PRIMARY KEY,
    mes_descripcion VARCHAR(50) NOT NULL,
    anio_id NUMERIC(10, 0) NOT NULL,
    CONSTRAINT  Mes_anio_id_fk
        FOREIGN KEY (anio_id)
        REFERENCES Anio(anio_id)
);

CREATE TABLE Dia(
    fecha  NUMERIC(10, 0) PRIMARY KEY,
    mes_id NUMERIC(10, 0) NOT NULL,
    CONSTRAINT  Dia_mes_id_fk
        FOREIGN KEY (mes_id)
        REFERENCES Mes(mes_id)
);

-- Hecho

CREATE TABLE hecho(
    sucursal_id  NUMERIC(10, 0) PRIMARY KEY,
    direccion_id  NUMERIC(10, 0) PRIMARY KEY,
    cliente_id  NUMERIC(10, 0) PRIMARY KEY,
    numero_cuenta NUMERIC(10, 0) PRIMARY KEY,
    fecha NUMERIC(10, 0) PRIMARY KEY,
    saldo NUMERIC(20, 5) PRIMARY KEY,
    CONSTRAINT  hecho_sucursal_id_fk
        FOREIGN KEY (sucursal_id)
        REFERENCES Sucursal(sucursal_id),
    CONSTRAINT  hecho_direccion_id_fk
        FOREIGN KEY (direccion_id)
        REFERENCES Direccion(direccion_id),
    CONSTRAINT  hecho_cliente_id_fk
        FOREIGN KEY (cliente_id)
        REFERENCES Cliente(cliente_id),
    CONSTRAINT  hecho_numero_cuenta_fk
        FOREIGN KEY (numero_cuenta)
        REFERENCES Cuenta(numero_cuenta),
    CONSTRAINT  hecho_fecha_fk
        FOREIGN KEY (fecha)
        REFERENCES Dia(fecha),
    CONSTRAINT pk_hecho
        PRIMARY KEY (sucursal_id, direccion_id, cliente_id, numero_cuenta, fecha);
);