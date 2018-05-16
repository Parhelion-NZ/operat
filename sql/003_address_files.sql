CREATE TABLE address_file (
	id INT NOT NULL,
	filename VARCHAR,
	address_field VARCHAR,

	CONSTRAINT pk_address_file PRIMARY KEY (id)
);

CREATE SEQUENCE address_file_seq OWNED BY address_file.id;

ALTER TABLE address_file ALTER COLUMN id SET DEFAULT nextval('address_file_seq');


SELECT AddGeometryColumn ('address_file','bounds',2193,'POLYGON',2);