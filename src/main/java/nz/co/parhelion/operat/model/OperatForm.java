package nz.co.parhelion.operat.model;

public class OperatForm {

	public long meshblockId;
	public int numberOfProperties;
	
	public boolean wholeArea;
	
	public boolean q1, q2, q3, q4, q5, q6, q7;

	public enum Q8 { NONE, ONE_TO_ELEVEN, TWELVE_OR_MORE; }
	public Q8 q8;	// {0 == x = 0, 1 == 1 <= x <= 11, 2 == x >= 12}

	public enum Q9 { RESIDENTS, NOT_RESIDENTS };
	public Q9 q9;
	
	public enum Q10 { NO_PAVEMENT, NOT_CONTINUOUS, CONTINUOUS };
	public Q10 q10;
	
	public enum Q11 { FLAT, MEDIUM, STEEP };
	public Q11 q11;
	
	public enum Q12 { WELL, MODERATE, POOR };
	public Q12 q12;
	
	public enum Q13 { RESIDENTIAL, GREEN, INDUSTRIAL };
	public Q13 q13;
	
	public boolean q14, q15, q16;
	
	//actual numbers
	public int q17, q18, q19, q20;
	
	public int q17No, q18No, q18Na, q19Mod, q19Poor, q19Na, q20Mod, q20Poor;
	

}
