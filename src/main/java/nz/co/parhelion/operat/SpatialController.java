package nz.co.parhelion.operat;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.opengis.referencing.crs.CoordinateReferenceSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.vividsolutions.jts.geom.Geometry;

import nz.co.parhelion.operat.model.DisplayResult;
import nz.co.parhelion.operat.model.InvalidResultsException;
import nz.co.parhelion.operat.model.Meshblock;
import nz.co.parhelion.operat.model.MeshblockDTO;
import nz.co.parhelion.operat.model.MeshblockNotFoundException;
import nz.co.parhelion.operat.model.OperatForm;
import nz.co.parhelion.operat.service.AssessmentSheetManager;
import nz.co.parhelion.operat.service.MeshblockManager;

@Controller
public class SpatialController {

	@Autowired 
	private MeshblockManager manager;
	
	@Autowired 
	private AssessmentSheetManager assessmentManager;
	
	@RequestMapping("/hello")
	@ResponseBody
	public TestMessage showMessage(@RequestParam(value = "name", required = false, defaultValue = "World") String name, Model model) {
		return new TestMessage(name);
	}
	
	
	@RequestMapping("/meshblock")
	@ResponseBody
	public MeshblockDTO getContainingMeshblock(@RequestParam double lat, @RequestParam double lng, Model model) throws IOException {
		Meshblock block = manager.getContainingMeshblock(lat, lng);

		MeshblockDTO dto = new MeshblockDTO();
		dto.setWkt( manager.getMeshblockOutlineWkt(block));
		dto.setId(block.getId());
		
		dto.setAddresses(manager.getAddresses(block));
		return dto;
	}
	
	@RequestMapping("/assessPdf/{meshblock}") 
	@ResponseBody
	public void getAssessmentPdf(@PathVariable int meshblock, HttpServletResponse response) throws IOException {
		Meshblock block = manager.getMeshblockById(meshblock);
		
		response.setContentType("application/pdf");
        response.setHeader("Content-disposition", "inline;filename=assessment_sheet.pdf");
		assessmentManager.createAssessmentSheet(response.getOutputStream(), block);
	}
	
	@RequestMapping("/assessForm/{meshblock}") 
	public String getAssessmentForm(@PathVariable int meshblock, HttpServletRequest request) throws IOException {
		Meshblock block = manager.getMeshblockById(meshblock);
		request.setAttribute("block", block);
		request.setAttribute("addresses", manager.getAddresses(block));
		
		return "form";
	}

	@RequestMapping("/assessForm") 
	public String getAssessmentForm() throws IOException {
//		Meshblock block = manager.getMeshblockById(meshblock);
//		request.setAttribute("block", block);
//		request.setAttribute("addresses", manager.getAddresses(block));
		
		return "form";
	}

	
	@PostMapping("/submitResults")
	@ResponseBody
	public ResponseEntity<?> submitResults(@RequestBody OperatForm form) throws IOException {
		try {
			assessmentManager.submitResults(form);
			return ResponseEntity.ok(form);
		} catch (InvalidResultsException e) {
			return ResponseEntity.badRequest().body(Collections.singletonMap("error", e.getMessage()));
		} catch (MeshblockNotFoundException e) {
			Map<String, String> values = new HashMap<String, String>();
			values.put("error", e.getMessage());
			values.put("invalidMeshblock", "true");
			return ResponseEntity.badRequest().body(values);
		}
	}
	
	@RequestMapping("/contact")
	public String getContactPage() {
		return "contact";
	}

	@RequestMapping("/faqs")
	public String getFAQPage() {
		return "faqs";
	}

	@ExceptionHandler
	@ResponseStatus(code = HttpStatus.BAD_REQUEST)
	public void handle(Exception e) {
	    e.printStackTrace();
//		log.warn("Returning HTTP 400 Bad Request", e);
	}
	
	@RequestMapping("/")
	public String getMainPage() {
		return "scrape";
	}
	
	@RequestMapping("/app")
	public String index() {
		return "scrape";
	}
	
	@RequestMapping("/results")
	@ResponseBody
	public List<DisplayResult> getResults() {
		return manager.getResults(null);
	}
	
	@RequestMapping("/results/{lat1},{lng1}/{lat2},{lng2}/")
	@ResponseBody
	public List<DisplayResult> getResults(@PathVariable double lat1, @PathVariable double lng1, @PathVariable double lat2, @PathVariable double lng2) {
		System.out.println("Lng2 "+lng2);
		ReferencedEnvelope env = manager.getLatLngEnvelope(lat1, lat2, lng1, lng2);
		
		return manager.getResults(env);
	}
	
	@RequestMapping("/scores")
	public String showResults() {
		return "results";
	}
	
	class TestMessage {
		private String name;
		
		public TestMessage(String name) {
			this.name = name;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
	}
	
	@RequestMapping("/admin/addAddressFile/{addressFile:.*}/{field}")
	@ResponseBody
	public String addAddressFile(@PathVariable String addressFile, @PathVariable String field) {
		return manager.addAddressesFile(addressFile, field);
	}
}
