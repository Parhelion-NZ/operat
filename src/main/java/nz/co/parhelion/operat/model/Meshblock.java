package nz.co.parhelion.operat.model;

import org.opengis.referencing.crs.CoordinateReferenceSystem;

import com.vividsolutions.jts.geom.Geometry;

public class Meshblock {

	private Geometry geometry;
	private CoordinateReferenceSystem crs;
	private String id;
	
	public Geometry getGeometry() {
		return geometry;
	}
	
	public void setGeometry(Geometry geometry) {
		this.geometry = geometry;
	}
	
	public CoordinateReferenceSystem getCrs() {
		return crs;
	}
	public void setCrs(CoordinateReferenceSystem crs) {
		this.crs = crs;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
}
