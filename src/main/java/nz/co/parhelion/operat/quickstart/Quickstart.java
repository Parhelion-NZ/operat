package nz.co.parhelion.operat.quickstart;


import java.io.File;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.geotools.data.FileDataStore;
import org.geotools.data.FileDataStoreFinder;
import org.geotools.data.simple.SimpleFeatureSource;
import org.geotools.feature.FeatureIterator;
import org.opengis.feature.simple.SimpleFeature;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Prompts the user for a shapefile and displays the contents on the screen in a map frame.
 * <p>
 * This is the GeoTools Quickstart application used in documentationa and tutorials. *
 */
public class Quickstart {

	/**
	 * GeoTools Quickstart demo application. Prompts the user for a shapefile and displays its
	 * contents on the screen in a map frame
	 */
	public static void main(String[] args) throws Exception {
		
//		FileDataStore meshblocks = FileDataStoreFinder.getDataStore(new File("D:\\parhelion\\operat\\street-addresses\\DCC_Property.shp"));
//		SimpleFeatureSource featureSource = meshblocks.getFeatureSource();
//
//		Set<String> diffCategory = new HashSet<>();
//		Set<String> landUse = new HashSet<>();
//		
//		Map<String, Set<String>> map = new HashMap<>();
//		
//		try (FeatureIterator<SimpleFeature> features = featureSource.getFeatures().features()) {
//			while (features.hasNext()) {
//				SimpleFeature feature = features.next();
//				diffCategory.add((String)feature.getAttribute("Diff_Categ"));
//				landUse.add((String)feature.getAttribute("Land_Use_D"));
//				
//				Set<String> diffUsage = map.get((String)feature.getAttribute("Diff_Categ"));
//				if (diffUsage == null) {
//					diffUsage = new HashSet<>();
//					map.put((String)feature.getAttribute("Diff_Categ"), diffUsage);
//				}
//				diffUsage.add((String)feature.getAttribute("Land_Use_D"));
//				
//			}
//
//		}
//		
//		System.out.println(diffCategory);
//		System.out.println(landUse);
//		
//		System.out.println(map);
		
		System.out.println("HJRowse: "+sha1("HJRowse"));
		System.out.println("S4v4nn4h: "+sha1("S4v4nn4h"));

	}
	
	static String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }
         
        return sb.toString();
    }
	 

}
