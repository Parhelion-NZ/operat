package nz.co.parhelion.operat.dao;

import java.util.List;
import java.util.Map;

import org.geotools.geometry.jts.ReferencedEnvelope;

import com.vividsolutions.jts.geom.Geometry;

import nz.co.parhelion.operat.model.DisplayResult;
import nz.co.parhelion.operat.model.Meshblock;
import nz.co.parhelion.operat.model.OperatForm;

public interface ResultsDAO {

	public int insertForm(OperatForm form, Meshblock block, float naturalElements, float incivilities, float navigation, float territorial);

	public int addAddressFile(String addressFile, String field, Geometry bounds);

	public Map<String, String> getAddressFiles(Meshblock block);
	
	List<DisplayResult> getResults(ReferencedEnvelope bounds);
	
}
