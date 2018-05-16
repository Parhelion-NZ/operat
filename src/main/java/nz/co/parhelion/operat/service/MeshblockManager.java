package nz.co.parhelion.operat.service;

import java.awt.Rectangle;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.geotools.data.FileDataStore;
import org.geotools.data.FileDataStoreFinder;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.factory.CommonFactoryFinder;
import org.geotools.feature.FeatureCollection;
import org.geotools.feature.FeatureIterator;
import org.geotools.filter.text.cql2.CQL;
import org.geotools.filter.text.cql2.CQLException;
import org.geotools.geometry.GeometryBuilder;
import org.geotools.geometry.jts.JTS;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.geotools.referencing.crs.DefaultGeographicCRS;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;
import org.opengis.feature.type.AttributeDescriptor;
import org.opengis.filter.Filter;
import org.opengis.filter.FilterFactory2;
import org.opengis.geometry.MismatchedDimensionException;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.opengis.referencing.operation.MathTransform;
import org.opengis.referencing.operation.TransformException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.Geometry;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.io.WKTWriter;

import nz.co.parhelion.operat.dao.ResultsDAO;
import nz.co.parhelion.operat.model.Meshblock;

@Service
public class MeshblockManager {
	
	@Value("${operat.meshshapefile}")
    private String meshShapeFile;
	
	@Value("${operat.streetshapefile}")
	private String streetShapeFile;
	
	@Value("${operat.streetshapefiles}")
	private String streetShapeFiles;
	
	@Autowired ResultsDAO dao;
	
	public void setMeshShapeFile(String file) {
		this.meshShapeFile = file;
	}

	public void setStreetShapeFile(String file) {
		this.streetShapeFile = file;
	}
	public Meshblock getContainingMeshblock(double lat, double lng) throws IOException {
		
		FileDataStore meshblocks = FileDataStoreFinder.getDataStore(new File(meshShapeFile));
		SimpleFeatureSource featureSource = meshblocks.getFeatureSource();
		
		CoordinateReferenceSystem meshCRS = featureSource.getSchema().getCoordinateReferenceSystem();

		CoordinateReferenceSystem latLng = DefaultGeographicCRS.WGS84;
		
		GeometryFactory factory = new GeometryFactory();
		Geometry point = factory.createPoint(new Coordinate(lng, lat));
		Geometry transformedPoint = null;
		try {
			MathTransform transform = CRS.findMathTransform(latLng, meshCRS, true);
			transformedPoint = JTS.transform(point, transform);
			
		} catch (FactoryException | MismatchedDimensionException | TransformException e) {
			e.printStackTrace();
		}
		System.out.println("Transformed point to: "+transformedPoint);
		
		FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
		Filter meshFilter = ff.intersects(ff.property("the_geom"), ff.literal(transformedPoint));

		FeatureCollection<SimpleFeatureType, SimpleFeature> meshCollection = featureSource.getFeatures(meshFilter);


		Geometry geom = null;

		SimpleFeature chosenMeshblock = null;
		Meshblock meshblock = new Meshblock();

		try (FeatureIterator<SimpleFeature> features = meshCollection.features()) {
			if (features.hasNext()) {
				SimpleFeature feature = features.next();
				meshblock.setGeometry((Geometry) feature.getDefaultGeometry());
				meshblock.setCrs(feature.getFeatureType().getCoordinateReferenceSystem());
				meshblock.setId((String)feature.getAttribute("MB2017"));
				return meshblock;
			}
		}

		return null;
	}
	
	public String getMeshblockOutlineWkt(Meshblock meshblock) {
		CoordinateReferenceSystem latLng = DefaultGeographicCRS.WGS84;
		CoordinateReferenceSystem meshCRS = meshblock.getCrs();
		Geometry meshGeom = meshblock.getGeometry();
		
		
		try {
			MathTransform transform = CRS.findMathTransform(meshCRS, latLng, true);
			meshGeom = JTS.transform(meshGeom, transform);
			
		} catch (FactoryException | MismatchedDimensionException | TransformException e) {
			e.printStackTrace();
		}
		
		return meshGeom.toString();
	}

	public List<String> getAddresses(Meshblock block) throws IOException {
		List<String> addressesInBlock = new ArrayList<String>();
		
		CoordinateReferenceSystem meshCRS = block.getCrs();

		Map<String, String> addressFiles = dao.getAddressFiles(block);
		
		File baseDir = new File(streetShapeFiles);
		
		for (String key : addressFiles.keySet()) {
		
			FileDataStore addresses = FileDataStoreFinder.getDataStore(new File(baseDir, key));
			SimpleFeatureSource featureSource = addresses.getFeatureSource();
	
			CoordinateReferenceSystem addressCRS = featureSource.getSchema().getCoordinateReferenceSystem();
			Geometry transformedMesh = null;
			try {
				MathTransform transform = CRS.findMathTransform(meshCRS, addressCRS);
				transformedMesh = JTS.transform(block.getGeometry(), transform);
			} catch (FactoryException | MismatchedDimensionException | TransformException e) {
				e.printStackTrace();
			}
	
			FilterFactory2 ff = CommonFactoryFinder.getFilterFactory2();
	
			Filter addressFilter = ff.intersects(ff.property("the_geom"), ff.literal(transformedMesh));
	
			FeatureCollection<SimpleFeatureType, SimpleFeature> addressCollection = featureSource.getFeatures(addressFilter);
	
			try (FeatureIterator<SimpleFeature> features = addressCollection.features()) {
				while (features.hasNext()) {
					SimpleFeature feature = features.next();
					addressesInBlock.add((String)feature.getAttribute(addressFiles.get(key)));
				}
	
			}
	
			addresses.dispose();
			
			addressesInBlock.sort(MeshblockManager::compareAddresses);
			if (!addressesInBlock.isEmpty()) {
				return addressesInBlock;
			}
		}
		return Collections.emptyList();
	}
	
	public static int compareAddresses(String s1, String s2) {
		if (s1 == null) {
			return -1;
		} 
		if (s2 == null) {
			return 1;
		}
		Pattern p = Pattern.compile("(\\d*\\/)?(\\d+)([A-z]*)(.*)");
		
		Matcher m1 = p.matcher(s1);
		Matcher m2 = p.matcher(s2);
		
		String s1Street = null;
		Integer s1Number = null;
		Integer s1Flat = null;
		String s1Subdivision = null;

		String s2Street = null;
		Integer s2Number = null;
		Integer s2Flat = null;
		String s2Subdivision = null;

		
		if (m1.find()) {
			String flat = m1.group(1);
			s1Flat = (flat == null || flat.equals("/")) ? 0 : Integer.parseInt(flat.substring(0, flat.length()-1));
			s1Number = Integer.parseInt(m1.group(2));
			s1Subdivision = m1.group(3);
			s1Street = m1.group(4);
		} else {
			System.err.println("Address does not match regex: "+s1);
			return s1.compareTo(s2);
		}
		
		if (m2.find()) {
			String flat = m2.group(1);
			s2Flat = (flat == null || flat.equals("/")) ? 0 : Integer.parseInt(flat.substring(0, flat.length()-1));
			s2Number = Integer.parseInt(m2.group(2));
			s2Subdivision = m2.group(3);
			s2Street = m2.group(4);
		} else {
			System.err.println("Address does not match regex: "+s2);
			return s1.compareTo(s2);
		}
		
		
		
		if (s1Street.equals(s2Street)) {
			if (s1Number.equals(s2Number)) {
				if (s1Flat.equals(s2Flat)) {
					if (s1Subdivision == null && s2Subdivision == null) {
						return 0;
					} else if (s1Subdivision == null) {
						return -1;
					} else {
						return s1Subdivision.compareTo(s2Subdivision);
					}
				} else {
					return s1Flat.compareTo(s2Flat);
				}
				
			} else {
				return s1Number.compareTo(s2Number);
			}
		} else {
			return s1Street.compareTo(s2Street);
		}
		
	}
	
	public List<String> getAllAddresses(String addressFile) throws IOException {
		List<String> addressesInBlock = new ArrayList<String>();
		
		FileDataStore addresses = FileDataStoreFinder.getDataStore(new File(addressFile));
		SimpleFeatureSource featureSource = addresses.getFeatureSource();

		try (FeatureIterator<SimpleFeature> features = featureSource.getFeatures().features()) {
			while (features.hasNext()) {
				SimpleFeature feature = features.next();
				addressesInBlock.add((String)feature.getAttribute("prop_addre"));
			}

		}

		addresses.dispose();
		
		addressesInBlock.sort(MeshblockManager::compareAddresses);
		return addressesInBlock;
	}

	public Meshblock getMeshblockById(int meshblockId) throws IOException {
		FileDataStore meshblocks = FileDataStoreFinder.getDataStore(new File(meshShapeFile));
		SimpleFeatureSource featureSource = meshblocks.getFeatureSource();
		
		try {
			Filter filter = CQL.toFilter("MB2017 = "+meshblockId);
			FeatureCollection<SimpleFeatureType, SimpleFeature> meshCollection = featureSource.getFeatures(filter);
		
			try (FeatureIterator<SimpleFeature> features = meshCollection.features()) {
				if (features.hasNext()) {
					SimpleFeature feature = features.next();
					Meshblock meshblock = new Meshblock();
					meshblock.setGeometry((Geometry) feature.getDefaultGeometry());
					meshblock.setCrs(feature.getFeatureType().getCoordinateReferenceSystem());
					meshblock.setId((String)feature.getAttribute("MB2017"));
					return meshblock;
				}
			}
		
		} catch (CQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public String addAddressesFile(String addressFile, String field) {
		
		File directory = new File(streetShapeFiles);
		File newAddressFile = new File(directory, addressFile);
		
		FileDataStore store;
        try {
        	
        	CoordinateReferenceSystem latLng = DefaultGeographicCRS.WGS84;

        	store = FileDataStoreFinder.getDataStore(newAddressFile);
        	SimpleFeatureSource featureSource = store.getFeatureSource();
        	
        	//check the field exists, if it does we'll assume they know what they're talking about
        	AttributeDescriptor descriptor = featureSource.getSchema().getDescriptor(field);

        	if (descriptor == null) {
        		return null;
        	}
        	
        	
            SimpleFeatureCollection collection = featureSource.getFeatures();
            SimpleFeatureType schema = featureSource.getSchema();
            
            CoordinateReferenceSystem addressCRS = schema.getCoordinateReferenceSystem();
            ReferencedEnvelope env = collection.getBounds();
            Geometry geom = JTS.toGeometry( env );
            
    		try {
    			CoordinateReferenceSystem nzgd2000 = CRS.decode("EPSG:2193");
    			if (!nzgd2000.getName().equals(addressCRS.getName())) {
    			
    				MathTransform transform = CRS.findMathTransform(nzgd2000, latLng, true);
    				geom = JTS.transform(geom, transform);
    			}
    		} catch (FactoryException | MismatchedDimensionException | TransformException e) {
    			e.printStackTrace();
    		}
            
    		
    		dao.addAddressFile(addressFile, field, geom);
            
            return geom.toString();

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        
        
        
	}
	
} 
