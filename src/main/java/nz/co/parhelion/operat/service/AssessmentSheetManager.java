package nz.co.parhelion.operat.service;

import java.awt.Desktop;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

import javax.activation.DataSource;
import javax.mail.internet.MimeMessage;
import javax.mail.util.ByteArrayDataSource;

import org.apache.commons.io.output.WriterOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;

import com.itextpdf.io.font.FontConstants;
import com.itextpdf.io.source.ByteArrayOutputStream;
import com.itextpdf.kernel.color.Color;
import com.itextpdf.kernel.color.DeviceRgb;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.border.Border;
import com.itextpdf.layout.element.AreaBreak;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.renderer.CellRenderer;
import com.itextpdf.layout.renderer.DrawContext;

import nz.co.parhelion.operat.dao.ResultsDAO;
import nz.co.parhelion.operat.model.InvalidResultsException;
import nz.co.parhelion.operat.model.Meshblock;
import nz.co.parhelion.operat.model.MeshblockNotFoundException;
import nz.co.parhelion.operat.model.OperatForm;
import nz.co.parhelion.operat.model.OperatForm.Q10;
import nz.co.parhelion.operat.model.OperatForm.Q11;
import nz.co.parhelion.operat.model.OperatForm.Q12;
import nz.co.parhelion.operat.model.OperatForm.Q13;
import nz.co.parhelion.operat.model.OperatForm.Q8;
import nz.co.parhelion.operat.model.OperatForm.Q9;

@Service
public class AssessmentSheetManager {

	@Autowired MeshblockManager meshManager;
	
	@Autowired ResultsDAO dao;
	
	@Autowired MailHelper mailHelper;
	
	public void createAssessmentSheet(OutputStream out, Meshblock meshblock) throws IOException {
		PdfWriter writer = new PdfWriter(out);
		PdfDocument pdf = new PdfDocument(writer);
		Document document = new Document(pdf);
		
		PdfFont bold = PdfFontFactory.createFont(FontConstants.HELVETICA_BOLD);
		PdfFont normal = PdfFontFactory.createFont(FontConstants.HELVETICA);
		
		document.add(new Paragraph("Older People's External Residential Assessment Tool 2016").setFont(bold).setFontSize(12).setTextAlignment(TextAlignment.CENTER));
		
		Table table = new Table(new float[]{3, 4, 3, 5, 5, 4, 3, 5});
		table.setWidthPercent(100);
		table.setFixedLayout();
		
		List<String> addresses = meshManager.getAddresses(meshblock);
		
		table.addHeaderCell(new Cell(1, 2).setHeight(40).add(new Paragraph("Meshblock")));
		table.addHeaderCell(new Cell(1, 2).add(new Paragraph(meshblock.getId()).setFontColor(Color.BLUE)));
		table.addHeaderCell(new Cell(1, 2).add(new Paragraph("Number of properties")));
		table.addHeaderCell(new Cell(1, 2).add(new Paragraph(Integer.toString(addresses.size())).setFontColor(Color.BLUE)));
		
//		table.addHeaderCell(new Cell(1, 1).add(new Paragraph("Date")));
//		table.addHeaderCell(new Cell(1, 2).setPaddingLeft(80).add(new Paragraph("        ")));
//		table.addHeaderCell(new Cell(1, 1).add(new Paragraph("Time of assessment")));
//		table.addHeaderCell(new Cell(1, 1).add(new Paragraph("        ")));
//		table.addHeaderCell(new Cell(1, 2).add(new Paragraph("Duration of assessment")));
//		table.addHeaderCell(new Cell(1, 1).setPaddingLeft(80).add(new Paragraph("        ")));
		
		document.add(table);

		document.add(new Paragraph());
		
		table = new Table(new float[]{1});
		table.setWidthPercent(100);
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add(new Paragraph("Street Level Observations").setFont(bold)));
		
		document.add(table);

		document.add(new Paragraph());

		
		table = new Table(new float[]{1,20,4,4});
		table.setBorder(Border.NO_BORDER);
		table.setWidthPercent(100);

		table.addHeaderCell(new Cell(1,2).setBorder(Border.NO_BORDER).add(new Paragraph("Tick yes or no for items 1 - 7").setFont(bold)));
		table.addHeaderCell(new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("YES").setFont(bold).setTextAlignment(TextAlignment.CENTER)));
		table.addHeaderCell(new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("NO").setFont(bold).setTextAlignment(TextAlignment.CENTER)));

		String[] questions = {
				"Is there public grass or verges?",
				"Are there sounds of nature (e.g. birdsong, water)?",
				"Are there clear and easy to read road name signs?",
				"Are there street lights?",
				"Are there any unlit alleyways?",
				"Are there instances of littering, dog fouling or broken glass?",
				"Are there loud traffic or industrial noises?"
		};
		
		for (int i = 0; i < questions.length; i++) {			
			table.addCell(new Cell().add((i+1)+".").setBorder(Border.NO_BORDER));
			table.addCell(new Cell().add(questions[i]).setBorder(Border.NO_BORDER));
			table.addCell(createRectangleCell());
			table.addCell(createRectangleCell());
		}

        document.add(table);

		document.add(new Paragraph());

		document.add(new Paragraph("Tick a single box which corresponds to the response for items 8-13 ").setFont(bold));

		document.add(new Paragraph("8.  Approximate number of vehicles that drove past during assessment?"));
		document.add(createTickBoxTable("NONE", "ONE TO ELEVEN", "TWELVE OR MORE"));

		document.add(new Paragraph("9.  What is the nature of parking on the street? "));
		document.add(createTickBoxTable("NOT RESIDENTS ONLY", "RESIDENTS ONLY"));

		document.add(new Paragraph("10.  Is there a continuous pavement, that is wide enough for 2 people or a wheelchair and is well maintained"));
		document.add(createTickBoxTable("NO PAVEMENT", "YES, BUT NOT CONTINUOUS, NARROW OR NOT WELL MAINTAINED", "YES, CONTINUOUS, WIDE/MODERATELY WIDE, WELL MAINTAINED"));

		document.add(new Paragraph("11. How steep is the pavement and/or road? "));
		document.add(createTickBoxTable("FLAT", "MEDIUM: Slight incline, not troublesome to walk up", "STEEP: Substantial incline, taxing to walk up"));

		document.add(new Paragraph("12. How well is the road maintained? "));
		document.add(createTickBoxTable("WELL: Good condition, no maintenance required", "MODERATELY: Only minor repairs required", "POORLY: Lots of pot holes, trip risks, no evidence of repair"));

		document.add(new Paragraph("13. What is the main outlook? "));
		document.add(createTickBoxTable("RESIDENTIAL", "GREEN OR SEA", "AGRICULTURAL INDUSTRIAL, INDUSTRIAL OR COMMERCIAL"));

		
		table = new Table(new float[]{1,20,4,4});
		table.setBorder(Border.NO_BORDER);
		table.setWidthPercent(100);

		table.addHeaderCell(new Cell(1,2).setBorder(Border.NO_BORDER).add(new Paragraph("Tick yes or no for items 14 - 16").setFont(bold)));
		table.addHeaderCell(new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("YES").setFont(bold).setTextAlignment(TextAlignment.CENTER)));
		table.addHeaderCell(new Cell().setBorder(Border.NO_BORDER).add(new Paragraph("NO").setFont(bold).setTextAlignment(TextAlignment.CENTER)));

		questions = new String[]{
				"I feel safe in this area",
				"Most people in this area are friendly",
				"I can talk to people in this area"
		};
		
		for (int i = 0; i < questions.length; i++) {			
			table.addCell(new Cell().add((i+14)+".").setBorder(Border.NO_BORDER));
			table.addCell(new Cell().add(questions[i]).setBorder(Border.NO_BORDER));
			table.addCell(createRectangleCell());
			table.addCell(createRectangleCell());
		}
		
		document.add(table);
		
		document.add(new AreaBreak(PageSize.A4.rotate()));
        pdf.setDefaultPageSize(PageSize.A4.rotate());
		
		
		table = new Table(new float[]{20, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5});
		table.setFixedLayout();
		table.setWidthPercent(100);
		table.setKeepTogether(true);
		
		table.addHeaderCell(new Cell(2,1).setPadding(4).add(new Paragraph("Name or number of property")));
		table.addHeaderCell(new Cell(1,2).setPadding(4).add(new Paragraph("17. Are there trees in the garden?")));
		table.addHeaderCell(new Cell(1,3).setPadding(4).add(new Paragraph("18. Is there any external beautification?")));
		table.addHeaderCell(new Cell(1,4).setPadding(4).add(new Paragraph("19. How well maintained is the garden/front yard?")));
		table.addHeaderCell(new Cell(1,3).setPadding(4).add(new Paragraph("20. How well maintained is the outside of the property?")));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("YES"));
		table.addHeaderCell(new Cell().add("NO"));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("YES"));
		table.addHeaderCell(new Cell().add("NO"));
		table.addHeaderCell(new Cell().add("N/A"));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("WELL"));
		table.addHeaderCell(new Cell().add("MOD"));
		table.addHeaderCell(new Cell().add("POOR"));
		table.addHeaderCell(new Cell().add("N/A"));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("WELL"));
		table.addHeaderCell(new Cell().add("MOD"));
		table.addHeaderCell(new Cell().add("POOR"));

		table.addHeaderCell(new Cell().add("TOTAL (from previous)"));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addHeaderCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		
		table.setSkipFirstHeader(true);
		
		table.addCell(new Cell(2,1).setPadding(4).add(new Paragraph("Name or number of property")));
		table.addCell(new Cell(1,2).setPadding(4).add(new Paragraph("14. Are there trees in the garden?")));
		table.addCell(new Cell(1,3).setPadding(4).add(new Paragraph("15. Is there any external beautification?")));
		table.addCell(new Cell(1,4).setPadding(4).add(new Paragraph("16. How well maintained is the garden/front yard?")));
		table.addCell(new Cell(1,3).setPadding(4).add(new Paragraph("17. How well maintained is the outside of the property?")));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("YES"));
		table.addCell(new Cell().add("NO"));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("YES"));
		table.addCell(new Cell().add("NO"));
		table.addCell(new Cell().add("N/A"));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("WELL"));
		table.addCell(new Cell().add("MOD"));
		table.addCell(new Cell().add("POOR"));
		table.addCell(new Cell().add("N/A"));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)).add("WELL"));
		table.addCell(new Cell().add("MOD"));
		table.addCell(new Cell().add("POOR"));
		
		for (String address : addresses) {
			if (address == null) {
				continue;
			}
			table.addCell(new Cell().setFontColor(Color.BLUE).add(address).setKeepTogether(true));
			table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
			table.addCell(new Cell());
			table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
			table.addCell(new Cell());
			table.addCell(new Cell());
			table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
			table.addCell(new Cell());
			table.addCell(new Cell());
			table.addCell(new Cell());
			table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
			table.addCell(new Cell());
			table.addCell(new Cell());
		}
		
		table.addCell(new Cell().add("GRAND TOTAL").setFont(bold));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		
		table.setSkipLastFooter(true);
		
		table.addFooterCell(new Cell().add("TOTAL").setFont(bold));
		table.addFooterCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(new DeviceRgb(200, 200, 200)));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		table.addFooterCell(new Cell().setBackgroundColor(Color.LIGHT_GRAY));
		document.add(table);
		document.close();
		
	}
	
	private Table createTickBoxTable(String... descriptions) {
		Table table = new Table(new float[]{10,90});
		table.setFixedLayout();
		table.setBorder(Border.NO_BORDER);
		table.setWidthPercent(100);
		
		for (String description : descriptions) {
			table.addCell(createRectangleCell());
			table.addCell(new Cell().setPaddingLeft(20).add(description).setBorder(Border.NO_BORDER));
		}
		return table;
	}
	
	private Cell createRectangleCell() {
		Cell cell = new Cell().setHeight(20).setWidth(50);
		cell.setNextRenderer(new CellRectangleRenderer(cell));
		cell.setBorder(Border.NO_BORDER);
		return cell;
	}
	
	/**
	 * Renders the cell with a box inside, padded 5 units off the cell boundaries.
	 * @author Colin
	 *
	 */
	private class CellRectangleRenderer extends CellRenderer {
		public CellRectangleRenderer(Cell modelElement) {
			super(modelElement);
		}

		@Override
        public void draw(DrawContext drawContext) {
            super.draw(drawContext);
            PdfCanvas canvas = drawContext.getCanvas();
            canvas.setLineWidth(0.5f);
            float x = getOccupiedAreaBBox().getX();
            float y = getOccupiedAreaBBox().getY();
            float w = getOccupiedAreaBBox().getWidth();
            float h = getOccupiedAreaBBox().getHeight();
            
            canvas.moveTo(x+5, y + 5)
            .lineTo(x + 5, y + h - 5)
            .lineTo(x + w - 5, y + h - 5)
            .lineTo(x + w - 5, y + 5)
            .lineTo(x + 5, y + 5)
            .stroke();

        }
    }

	

	public static void main(String args[]) throws IOException {
		Path file = Files.createTempFile("operat", ".pdf");
		AssessmentSheetManager asm = new AssessmentSheetManager();
		asm.meshManager = new MeshblockManager();
		asm.meshManager.setMeshShapeFile("D:\\parhelion\\operat\\2017 Digital Boundaries Generalised Clipped\\MB2017_GV_Clipped.shp");
		asm.meshManager.setStreetShapeFile("D:\\parhelion\\operat\\nz-street-address\\Address_Info.shp");
		
		asm.createAssessmentSheet(new FileOutputStream(file.toFile()), asm.meshManager.getMeshblockById(2027800));
		//asm.createAssessmentSheet(new FileOutputStream(file.toFile()), asm.meshManager.getContainingMeshblock(-41.2263083,174.8755597));
		
		
		
		Desktop.getDesktop().open(file.toFile());
		System.exit(0);
	}

	public void submitResults(OperatForm form) throws IOException, MeshblockNotFoundException, InvalidResultsException {
		
		Meshblock block = meshManager.getMeshblockById((int)form.meshblockId);
		System.out.println("Block: "+block);
		if (block == null) {
			throw new MeshblockNotFoundException("Meshblock not found: "+form.meshblockId);
		}
		List<String> addresses = meshManager.getAddresses(block);
		
		int numAddresses = Math.max(addresses.size(), form.numberOfProperties);
		
		if (form.q17 > numAddresses || form.q18 > numAddresses || form.q19 > numAddresses || form.q20 > numAddresses) {
			System.out.println("Count of properties cannot be more than the number of properties in the meshblock");
			throw new InvalidResultsException("Count of properties cannot be more than the number of properties in the meshblock");
		}

		float naturalElements = calculateNaturalElements(form);
		float incivilities = calculateIncivilities(form);
		float navigation = calculateNavigation(form);
		float territorial = calculateTerritorial(form);
		System.out.println("Inserting in db");
		dao.insertForm(form, block, naturalElements, incivilities, navigation, territorial);
		System.out.println("Inserted in db");
		mailHelper.sendCSV(form, block, naturalElements, incivilities, navigation, territorial);
		
	}



	private float calculateTerritorial(OperatForm form) {
		float parking = form.q9 == Q9.NOT_RESIDENTS ? 2 : 0;
		float outlook = form.q13 == Q13.INDUSTRIAL ? 3 : 0;
		
		float beautificationPercentage = (float)form.q18 / (float)form.numberOfProperties;
		float gardenPercentage = (float)form.q19 / (float)form.numberOfProperties;
		float propertyPercentage = (float)form.q20 / (float)form.numberOfProperties;
		
		float beautification = 0;
		if (beautificationPercentage <= .2) {
			beautification = 1;
		} else if (beautificationPercentage <= .99) {
			beautification = 0.5f;
 		} 
		beautification *= 3;
		
		float garden = 0;
		if (gardenPercentage < 0.01) {
			garden = 1;
		} else if (gardenPercentage < .8) {
			garden = 0.5f;
		}
		garden *= 3;
		
		float property = 0;
		if (propertyPercentage <= 0.1) {
			property = 1;
		} else if (propertyPercentage <= .99) {
			property = 0.5f;
		}
		property *= 3;
		
		float domain = (parking + outlook + beautification + garden + property) / 14;
		
		return domain * 20;
		
	}
	
	
	
	

	private float calculateNavigation(OperatForm form) {
		float legibleSigns = form.q3 ? 0 : 2;
		float lighting = form.q4 ? 0 : 1;
		float alleys = form.q5 ? 1 : 0;
		
		float lightingAndAlleys = lighting + alleys == 0 ? 0 : 3;
		
		float pavement = form.q10 == Q10.NO_PAVEMENT ? 1 : form.q10 == Q10.NOT_CONTINUOUS ? 0.5f : 0;
		pavement *= 3;
		
		float gradient = form.q11 == Q11.FLAT ? 0 : form.q11 == Q11.MEDIUM ? 0.5f : 1;
		gradient *= 2;
		
		float roadMaintenance = form.q12 == Q12.WELL ? 0 : form.q12 == Q12.MODERATE ? 0.5f : 1;
		roadMaintenance *= 3;
		
		float domain = (legibleSigns + lightingAndAlleys + pavement + gradient + roadMaintenance) / 13;
		return domain * 40;
	}

	private float calculateIncivilities(OperatForm form) {
		float litter = form.q6 ? 4 : 0;
		float noise = form.q7 ? 3 : 0;
		float vehicles = form.q8 == Q8.NONE ? 0 : form.q8 == Q8.ONE_TO_ELEVEN ? 0.5f : 1;
		vehicles *= 3;
		
		float domain = (litter + noise + vehicles) / 10;
		return domain * 20;
	}

	private float calculateNaturalElements(OperatForm form) {
		float treePercentage = (float)form.q17 / (float)form.numberOfProperties;
		
		float grass = form.q1 ? 0 : 2;
		float nature = form.q2 ? 0 : 4;
		float trees = 0;
		if (treePercentage < .02) {
			trees = 1;
		} else if (treePercentage <= 0.99) {
			trees = .5f;
		}
		trees *= 3;
		
		float domainScore = (grass + nature + trees) / 9;
		domainScore *= 20;
		
		return domainScore;
	}
}
