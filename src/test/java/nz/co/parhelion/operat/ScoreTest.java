package nz.co.parhelion.operat;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

import nz.co.parhelion.operat.model.OperatForm;
import nz.co.parhelion.operat.model.OperatForm.Q10;
import nz.co.parhelion.operat.model.OperatForm.Q11;
import nz.co.parhelion.operat.model.OperatForm.Q12;
import nz.co.parhelion.operat.model.OperatForm.Q13;
import nz.co.parhelion.operat.model.OperatForm.Q8;
import nz.co.parhelion.operat.model.OperatForm.Q9;
import nz.co.parhelion.operat.service.AssessmentSheetManager;

public class ScoreTest {

	@Test
	public void TestScoresAllTrue() {
		
		OperatForm form = new OperatForm();
		form.q1 = true;
		form.q2 = true;
		form.q3 = true;
		form.q4 = true;
		form.q5 = true;
		form.q6 = true;
		form.q7 = true;
		form.q8 = Q8.NONE;
		form.q9 = Q9.NOT_RESIDENTS;
		form.q10 = Q10.NO_PAVEMENT;
		form.q11 = Q11.FLAT;
		form.q12 = Q12.WELL;
		form.q13 = Q13.RESIDENTIAL;
		form.q18 = 20;
		form.q19 = 20;
		form.q20 = 20;
		form.q21 = 20;
		
		form.numberOfProperties = 20;
		
		AssessmentSheetManager mgr = new AssessmentSheetManager();
		
		assertEquals(0, mgr.calculateNaturalElements(form), 0.01);
		assertEquals(14, mgr.calculateIncivilities(form), 0.01);
		assertEquals(18.46, mgr.calculateNavigation(form), 0.01);
		assertEquals(2.86, mgr.calculateTerritorial(form), 0.01);
			
		
	}
	
	@Test
	public void TestScoresAllFalse() {
		
		OperatForm form = new OperatForm();
		form.q1 = false;
		form.q2 = false;
		form.q3 = false;
		form.q4 = false;
		form.q5 = false;
		form.q6 = false;
		form.q7 = false;
		form.q8 = Q8.TWELVE_OR_MORE;
		form.q9 = Q9.RESIDENTS;
		form.q10 = Q10.CONTINUOUS;
		form.q11 = Q11.STEEP;
		form.q12 = Q12.POOR;
		form.q13 = Q13.INDUSTRIAL;
		form.q18 = 0;
		form.q19 = 0;
		form.q20 = 0;
		form.q21 = 0;
		
		form.numberOfProperties = 20;
		
		AssessmentSheetManager mgr = new AssessmentSheetManager();
		
		assertEquals(20, mgr.calculateNaturalElements(form), 0.01);
		assertEquals(6, mgr.calculateIncivilities(form), 0.01);
		assertEquals(30.77, mgr.calculateNavigation(form), 0.01);
		assertEquals(17.14, mgr.calculateTerritorial(form), 0.01);
			
		
	}
	
	@Test
	public void TestScoresRandom1() {
		
		OperatForm form = new OperatForm();
		form.q1 = false;
		form.q2 = true;
		form.q3 = false;
		form.q4 = true;
		form.q5 = true;
		form.q6 = true;
		form.q7 = true;
		form.q8 = Q8.ONE_TO_ELEVEN;
		form.q9 = Q9.NOT_RESIDENTS;
		form.q10 = Q10.NO_PAVEMENT;
		form.q11 = Q11.STEEP;
		form.q12 = Q12.WELL;
		form.q13 = Q13.GREEN;
		form.q18 = 20;
		form.q19 = 20;
		form.q20 = 20;
		form.q21 = 20;
		
		form.numberOfProperties = 41;
		
		AssessmentSheetManager mgr = new AssessmentSheetManager();
		
		assertEquals(7.78, mgr.calculateNaturalElements(form), 0.01);
		assertEquals(17, mgr.calculateIncivilities(form), 0.01);
		assertEquals(30.77, mgr.calculateNavigation(form), 0.01);
		assertEquals(9.29, mgr.calculateTerritorial(form), 0.01);
			
		
	}
	
	
}
