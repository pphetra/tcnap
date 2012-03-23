create sequence 'ids';


CREATE TABLE location
(
  id integer NOT NULL,
  tambol character varying(50),
  amphor character varying(50),
  province character varying(50),
  CONSTRAINT pk PRIMARY KEY (id )
);

CREATE TABLE person
(
  id integer NOT NULL DEFAULT nextval('ids'::regclass),
  name character varying(100),
  sur_name character varying(100),
  description text,
  tambol character varying(50),
  location_id integer,
  CONSTRAINT person_pkey PRIMARY KEY (id ),
  CONSTRAINT person_location_id_fkey FOREIGN KEY (location_id)
      REFERENCES location (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE "group"
(
  name character varying(100),
  pattern text,
  id integer NOT NULL DEFAULT nextval('ids'::regclass),
  CONSTRAINT group_pkey PRIMARY KEY (id )
);


CREATE TABLE person_group
(
  person_id integer NOT NULL,
  group_id integer NOT NULL,
  CONSTRAINT person_group_pkey PRIMARY KEY (person_id , group_id )
);

        