CREATE USER operat WITH password '0ld3rPeop1e';
CREATE DATABASE operat WITH OWNER operat;

\c operat
-- Enable PostGIS (includes raster)
CREATE EXTENSION postgis;
-- Enable Topology
CREATE EXTENSION postgis_topology;