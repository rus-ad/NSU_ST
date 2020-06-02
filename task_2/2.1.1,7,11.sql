-- first you need to create `client` and `car` tables and then import the data

-- defining schema

create table model (
	model_id     SERIAL  NOT NULL,
	brand_id     integer      not null,
	name         varchar(128) not null,
	drive        varchar(128),
	transmission varchar(128),
	cityMPG      float(8),
	highwayMPG   float(8),
	primary key (model_id)
);

create table brand (
	brand_id     SERIAL NOT NULL, 
	name         varchar(128) not null,
	primary key (brand_id)
);

create table rent (
	date_since timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp,
	date_till  timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp,
	vin        varchar(128) not null,
	client_id  integer      not null,
  sum        float(8)     not null default 0.0,
	primary key (date_since, date_till, vin)
);

create table car (
	car_id     SERIAL NOT NULL,
	vin        varchar(128) not null,
	model_id   SERIAL NOT NULL,
	color      varchar(128),
	year       timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp,
	rate       float(8),
	primary key (car_id),
	FOREIGN KEY (model_id) REFERENCES model (model_id)
);


create table client (
	client_id     SERIAL NOT NULL,
	firstName     varchar(128) not null,
	lastName      varchar(128) not null,
	gender        varchar(128) not null,
	birthday      timestamp without time zone not null DEFAULT NULLIF('0000-00-00 00:00:00','0000-00-00 00:00:00')::timestamp,
	primary key (client_id)
);

-- defining data
