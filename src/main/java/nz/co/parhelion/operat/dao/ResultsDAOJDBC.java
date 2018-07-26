package nz.co.parhelion.operat.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.geotools.geometry.jts.JTSFactoryFinder;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.opengis.referencing.FactoryException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.Point;
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;

import nz.co.parhelion.operat.model.DisplayResult;
import nz.co.parhelion.operat.model.Meshblock;
import nz.co.parhelion.operat.model.OperatForm;

@Repository
public class ResultsDAOJDBC implements ResultsDAO {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	@Override
	public int insertForm(OperatForm form, Meshblock block, float naturalElements, float incivilities, float navigation,
			float territorial) {

		SimpleJdbcInsert insert = new SimpleJdbcInsert(jdbcTemplate);
		
		String[] columnNames = {
				"meshblock_id", 
				"public_grass", "sounds_nature","clear_road_signs", "street_lights", "unlit_alleyways", "littering", "loud_traffic", 
				"number_vehicles", "parking", "pavement", "gradient", "road_maintenance", "outlook", 
				"trees", "external_beautification", "garden", "outside_property", 
				"natural_elements_score", "incivilities_and_nuisance_score", "navigation_and_mobility_score", "territorial_score",
				"operat_score", 
				"whole_area", 
				"trees_total_no", 
				"external_beautification_none", "external_beautification_na",
				"garden_moderate", "garden_poor", "garden_na",
				"outside_property_moderate", "outside_property_poor",
				"i_feel_safe", "people_friendly", "talk_people", "bus_stop"

		};
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("meshblock_id", block.getId());
		args.put("public_grass", form.q1 ? 1 : 0);
		args.put("sounds_nature", form.q2 ? 1 : 0);
		args.put("clear_road_signs", form.q3 ? 1 : 0);
		args.put("street_lights", form.q4 ? 1 : 0);
		args.put("unlit_alleyways", form.q5 ? 1 : 0);
		args.put("littering", form.q6 ? 1 : 0);
		args.put("loud_traffic", form.q7 ? 1 : 0);
		
		switch (form.q8) {
		case NONE: args.put("number_vehicles", 0); break;
		case ONE_TO_ELEVEN: args.put("number_vehicles", 1); break;
		case TWELVE_OR_MORE: args.put("number_vehicles", 2); break;
		}
		switch (form.q9) {
		case NOT_RESIDENTS: args.put("parking", 0); break;
		case RESIDENTS: args.put("parking", 1); break;
		}
		switch (form.q10) {
		case NO_PAVEMENT: args.put("pavement", 0); break;
		case NOT_CONTINUOUS: args.put("pavement", 1); break;
		case CONTINUOUS: args.put("pavement", 2); break;
		}
		switch (form.q11) {
		case FLAT: args.put("gradient", 0); break;
		case MEDIUM: args.put("gradient", 1); break;
		case STEEP: args.put("gradient", 2); break;
		}
		switch (form.q12) {
		case POOR: args.put("road_maintenance", 0); break;
		case MODERATE: args.put("road_maintenance", 1); break;
		case WELL: args.put("road_maintenance", 2); break;
		}
		switch (form.q13) {
		case RESIDENTIAL: args.put("outlook", 0); break;
		case GREEN: args.put("outlook", 1); break;
		case INDUSTRIAL: args.put("outlook", 2); break;
		}
		
		args.put("trees", form.q18);
		args.put("external_beautification", form.q19);
		args.put("garden", form.q20);
		args.put("outside_property", form.q21);

		args.put("natural_elements_score", naturalElements);
		args.put("incivilities_and_nuisance_score", incivilities);
		args.put("navigation_and_mobility_score", navigation);
		args.put("territorial_score", territorial);
		
		args.put("operat_score", naturalElements + incivilities + navigation + territorial);

		args.put("whole_area", form.wholeArea ? 1 : 0);
		
		args.put("trees_total_no", form.q18No);
		args.put("external_beautification_none", form.q19No);
		args.put("external_beautification_na", form.q19Na);
		args.put("garden_moderate", form.q20Mod);
		args.put("garden_poor", form.q20Poor);
		args.put("garden_na", form.q20Na);
		args.put("outside_property_moderate", form.q21Mod);
		args.put("outside_property_poor", form.q21Poor);

		args.put("i_feel_safe", form.q14 ? 1 : 0);
		args.put("people_friendly", form.q15 ? 1 : 0);
		args.put("talk_people", form.q16 ? 1 : 0);
		args.put("bus_stop", form.q17 ? 1 : 0);
		
		Number genkey = insert.withTableName("result").usingColumns(columnNames).usingGeneratedKeyColumns("id").executeAndReturnKey(args);
		System.out.println("Generated an id of "+genkey.intValue());
		final int id = genkey.intValue();


		String wkt = block.getGeometry().getCentroid().toString();
		Integer epsg = 2193;
		
		try {
			epsg = CRS.lookupEpsgCode(block.getCrs(), true);
		} catch (FactoryException e) {
			e.printStackTrace();
		}
		if (epsg == null) {
			epsg = 2193;
		}
		
		
		jdbcTemplate.update("UPDATE result SET centroid = ST_GeomFromText('"+wkt+"', "+epsg+") WHERE id = "+id);

		System.out.println(block.getGeometry().toString());
		jdbcTemplate.update("UPDATE result SET geom = ST_GeomFromText('"+block.getGeometry().toString()+"', "+epsg+") WHERE id = "+id);

		return id;
	}

	@Override
	public int addAddressFile(String addressFile, String field, Geometry bounds) {
		SimpleJdbcInsert insert = new SimpleJdbcInsert(jdbcTemplate);
		
		String[] columnNames = {
			"filename", 
			"address_field"
		};
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("filename", addressFile);
		args.put("address_field", field);

		Number genkey = insert.withTableName("address_file").usingColumns(columnNames).usingGeneratedKeyColumns("id").executeAndReturnKey(args);
		System.out.println("Generated an id of "+genkey.intValue());
		final int id = genkey.intValue();
		
		String epsg = "2193";

		String wkt = bounds.toString();
		jdbcTemplate.update("UPDATE address_file SET bounds = ST_GeomFromText('"+wkt+"', "+epsg+") WHERE id = "+id);


		return id;
	}
	
	@Override
	public Map<String, String> getAddressFiles(Meshblock block) {
		
		Geometry geom = block.getGeometry();
		
		String query = "SELECT * FROM address_file WHERE ST_Contains(bounds, 'SRID=2193;"+geom.toString()+"')";
		System.out.println(query);

		Map<String, String> addressFiles = new HashMap<>();
		jdbcTemplate.query(query, rs -> {addressFiles.put(rs.getString("filename"), rs.getString("address_field"));});
		System.out.println("Address files: "+addressFiles);
		return addressFiles;
	}
	
	@Override
	public List<DisplayResult> getResults(ReferencedEnvelope bounds) {

//		String query = "SELECT id, meshblock_id, operat_score, st_astext(st_transform(centroid, 4326)) FROM result";
		
//		WHERE ST_Transform(geom,4326) && ST_MakeEnvelope(174.85434354888253, -41.21126571507782, 174.93674100982003, -41.18995441845707, 4326)
		
		String whereClause = bounds != null ? "WHERE ST_Transform(geom, 4326) && ST_MakeEnvelope("+bounds.getMinX()+","+bounds.getMinY()+","+bounds.getMaxX()+","+bounds.getMaxY()+") " : "";
		
		//Only latest results
		String query = "SELECT DISTINCT ON (meshblock_id) id, meshblock_id, operat_score, date_entered, ST_AsText(ST_Transform(centroid,4326)), ST_AsText(ST_Transform(geom,4326)), "
				+ "natural_elements_score, incivilities_and_nuisance_score, navigation_and_mobility_score, territorial_score "
				+ "FROM result "
				+ whereClause
				+ "ORDER BY meshblock_id, date_entered DESC;";

		System.out.println(query);
	    GeometryFactory geometryFactory = JTSFactoryFinder.getGeometryFactory();

	    WKTReader reader = new WKTReader(geometryFactory);
	    
		RowMapper<DisplayResult> rowMapper = (rs, rowNum) -> {
			
			DisplayResult result = new DisplayResult();
			result.setResultId(rs.getInt(1));
			result.setMeshblockId(rs.getInt(2));
			result.setOperatScore(rs.getDouble(3));
				
			result.setNaturalElementsScore(rs.getDouble(7));
			result.setIncivilitiesScore(rs.getDouble(8));
			result.setNavigationScore(rs.getDouble(9));
			result.setTerritorialScore(rs.getDouble(10));
			Point point;
			try {
				point = (Point) reader.read(rs.getString(5));
				result.setCentroid(point.toString());
				result.setLat(point.getCoordinate().y);
				result.setLng(point.getCoordinate().x);
					
				result.setGeom(rs.getString(6));
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			return result;
		};
		
		return jdbcTemplate.query(query, rowMapper);
		
	}
	
	@Override
	public DisplayResult getResults(Meshblock block) {

		String whereClause = "WHERE meshblock_id = "+block.getId();
		
		//Only latest results
		String query = "SELECT DISTINCT ON (meshblock_id) id, meshblock_id, operat_score, date_entered, ST_AsText(ST_Transform(centroid,4326)), ST_AsText(ST_Transform(geom,4326)), "
				+ "natural_elements_score, incivilities_and_nuisance_score, navigation_and_mobility_score, territorial_score "
				+ "FROM result "
				+ whereClause
				+ "ORDER BY meshblock_id, date_entered DESC;";

		System.out.println(query);
	    GeometryFactory geometryFactory = JTSFactoryFinder.getGeometryFactory();

	    WKTReader reader = new WKTReader(geometryFactory);
	    
		RowMapper<DisplayResult> rowMapper = (rs, rowNum) -> {
			
			DisplayResult result = new DisplayResult();
			result.setResultId(rs.getInt(1));
			result.setMeshblockId(rs.getInt(2));
			result.setOperatScore(rs.getDouble(3));
				
			result.setNaturalElementsScore(rs.getDouble(7));
			result.setIncivilitiesScore(rs.getDouble(8));
			result.setNavigationScore(rs.getDouble(9));
			result.setTerritorialScore(rs.getDouble(10));
			Point point;
			try {
				point = (Point) reader.read(rs.getString(5));
				result.setCentroid(point.toString());
				result.setLat(point.getCoordinate().y);
				result.setLng(point.getCoordinate().x);
					
				result.setGeom(rs.getString(6));
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			return result;
		};
		
		return jdbcTemplate.queryForObject(query, rowMapper);
	}
	
}

/*
SELECT DISTINCT ON (meshblock_id) id, meshblock_id, operat_score, date_entered, ST_AsText(ST_Transform(centroid,4326)),
natural_elements_score, incivilities_and_nuisance_score, navigation_and_mobility_score, territorial_score 
FROM result 
WHERE ST_Transform(geom,4326) && ST_MakeEnvelope(174.85434354888253, -41.21126571507782, 174.93674100982003, -41.18995441845707, 4326)
ORDER BY meshblock_id, date_entered DESC;


-41.21126571507782, 174.85434354888253), (-41.18995441845707, 174.93674100982003

*/