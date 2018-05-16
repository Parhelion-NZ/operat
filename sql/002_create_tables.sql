--EPSG 2193

CREATE TABLE result (
	id INT NOT NULL,
	meshblock_id INT NOT NULL,
	public_grass INT,
	sounds_nature INT,
	clear_road_signs INT,
	street_lights INT,
	unlit_alleyways INT,
	littering INT,
	loud_traffic INT,
	number_vehicles INT,
	parking INT,
	pavement INT,
	gradient INT,
	road_maintenance INT,
	outlook INT,
	trees INT,
	external_beautification INT,
	garden INT,
	outside_property INT,
	natural_elements_score float,
	incivilities_and_nuisance_score float,
	navigation_and_mobility_score float,
	territorial_score float,
	operat_score float,
	CONSTRAINT pk_result PRIMARY KEY (id)
);

CREATE SEQUENCE result_seq OWNED BY result.id;

ALTER TABLE result ALTER COLUMN id SET DEFAULT nextval('result_seq');


SELECT AddGeometryColumn ('result','centroid',2193,'POINT',2);

SELECT AddGeometryColumn ('result','geom',2193,'MULTIPOLYGON',2);

ALTER TABLE result ADD COLUMN date_entered TIMESTAMP DEFAULT now();

ALTER TABLE result ADD COLUMN whole_area INT;
ALTER TABLE result ADD COLUMN trees_total_no INT;
ALTER TABLE result ADD COLUMN external_beautification_none INT;
ALTER TABLE result ADD COLUMN external_beautification_na INT;
ALTER TABLE result ADD COLUMN garden_moderate INT;
ALTER TABLE result ADD COLUMN garden_poor INT;
ALTER TABLE result ADD COLUMN garden_na INT;
ALTER TABLE result ADD COLUMN outside_property_moderate INT;
ALTER TABLE result ADD COLUMN outside_property_poor INT;

