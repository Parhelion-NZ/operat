package nz.co.parhelion.operat.dao;

import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.geotools.referencing.CRS;
import org.opengis.referencing.FactoryException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import com.vividsolutions.jts.geom.Geometry;

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
				"outside_property_moderate", "outside_property_poor"

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
		
		args.put("trees", form.q17);
		args.put("external_beautification", form.q18);
		args.put("garden", form.q19);
		args.put("outside_property", form.q20);

		args.put("natural_elements_score", naturalElements);
		args.put("incivilities_and_nuisance_score", incivilities);
		args.put("navigation_and_mobility_score", navigation);
		args.put("territorial_score", territorial);
		
		args.put("operat_score", naturalElements + incivilities + navigation + territorial);

		args.put("whole_area", form.wholeArea ? 1 : 0);
		
		args.put("trees_total_no", form.q17No);
		args.put("external_beautification_none", form.q18No);
		args.put("external_beautification_na", form.q18Na);
		args.put("garden_moderate", form.q19Mod);
		args.put("garden_poor", form.q19Poor);
		args.put("garden_na", form.q19Na);
		args.put("outside_property_moderate", form.q20Mod);
		args.put("outside_property_poor", form.q20Poor);

		
		Number genkey = insert.withTableName("result").usingColumns(columnNames).usingGeneratedKeyColumns("id").executeAndReturnKey(args);
		System.out.println("Generated an id of "+genkey.intValue());
		final int id = genkey.intValue();


		String wkt = block.getGeometry().getCentroid().toString();
		String epsg = "2193";
		try {
			epsg = CRS.lookupIdentifier(block.getCrs(), true);
		} catch (FactoryException e) {
			e.printStackTrace();
		}
		if (epsg == null) {
			epsg = "2193";
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
	
}
