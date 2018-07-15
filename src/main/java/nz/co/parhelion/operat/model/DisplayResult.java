package nz.co.parhelion.operat.model;

public class DisplayResult {

	private int resultId;
	
	private int meshblockId;
	
	private double operatScore;
	
	private double naturalElementsScore;
	private double incivilitiesScore;
	private double navigationScore;
	private double territorialScore;
	
	private String centroid;
	private String geom;
	
	private double lat;
	
	private double lng;

	public int getResultId() {
		return resultId;
	}

	public void setResultId(int resultId) {
		this.resultId = resultId;
	}

	public int getMeshblockId() {
		return meshblockId;
	}

	public void setMeshblockId(int meshblockId) {
		this.meshblockId = meshblockId;
	}

	public double getOperatScore() {
		return operatScore;
	}

	public void setOperatScore(double operatScore) {
		this.operatScore = operatScore;
	}

	public String getCentroid() {
		return centroid;
	}
	
	public void setCentroid(String centroid) {
		this.centroid = centroid;
	}
	
	public double getLat() {
		return lat;
	}
	
	public void setLat(double lat) {
		this.lat = lat;
	}
	
	public double getLng() {
		return lng;
	}
	
	public void setLng(double lng) {
		this.lng = lng;
	}
	
	public double getIncivilitiesScore() {
		return incivilitiesScore;
	}
	
	public double getNaturalElementsScore() {
		return naturalElementsScore;
	}
	 
	public double getNavigationScore() {
		return navigationScore;
	}
	
	public double getTerritorialScore() {
		return territorialScore;
	}
	
	public void setIncivilitiesScore(double incivilitiesScore) {
		this.incivilitiesScore = incivilitiesScore;
	}
	
	public void setNaturalElementsScore(double naturalElementsScore) {
		this.naturalElementsScore = naturalElementsScore;
	}
	
	public void setNavigationScore(double navigationScore) {
		this.navigationScore = navigationScore;
	}
	
	public void setTerritorialScore(double territorialScore) {
		this.territorialScore = territorialScore;
	}
	
	public String getGeom() {
		return geom;
	}
	
	public void setGeom(String geom) {
		this.geom = geom;
	}
}
