package nz.co.parhelion.operat.service;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

import javax.activation.DataSource;
import javax.mail.internet.MimeMessage;
import javax.mail.util.ByteArrayDataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import nz.co.parhelion.operat.model.Meshblock;
import nz.co.parhelion.operat.model.OperatForm;

@Service
public class MailHelper {

	@Autowired
	JavaMailSender mailSender;
	
	@Async
	public void sendCSV(OperatForm form, Meshblock block, float naturalElements, float incivilities, float navigation,	float territorial) {
		// TODO Auto-generated method stub
		
		String message = "A new assessment has been completed.  \n\n"
				+ "Meshblock id: "+block.getId()+"\n"
				+ "Natural elements score: "+naturalElements+"\n"
				+ "Incivilities score: "+incivilities+"\n"
				+ "Navigation score: "+navigation+"\n"
				+ "Territorial score: "+territorial+"\n\n"
				+ "See this meshblock at: https://operat.co.nz/scores/"+block.getId()+"\n\n"
				+ "The raw results are attached to this email";
				
//		System.out.println("Going to send message: "+message);
		mailSender.send(getContentWtihAttachementMessagePreparator(form, block, message));

	}
	

	private MimeMessagePreparator getContentWtihAttachementMessagePreparator(final OperatForm form, Meshblock block, String message) {
		 
	    MimeMessagePreparator preparator = new MimeMessagePreparator() {
	 
	        public void prepare(MimeMessage mimeMessage) throws Exception {
	            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
	 
	            helper.setSubject("New NZ Operat entry");
	            helper.setFrom("operat@parhelion.co.nz");
	            helper.setTo("pete@furzehill.co.nz");
	 
	            helper.setText(message);

	            byte[] bytes = writeCSV(form);
	 
	            DataSource dataSource = new ByteArrayDataSource(bytes, "text/csv");
	            // Add a resource as an attachment
	            helper.addAttachment("assessment.csv", dataSource);
	            System.out.println("All prepared");
	        }

			private byte[] writeCSV(OperatForm form) {
				StringWriter sw = new StringWriter();
				PrintWriter pw = new PrintWriter(sw);
								
				pw.println("Meshblock, whole_area, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13, Q14, Q15, Q16, Q17");
				pw.print(block.getId()+",");
				pw.print(form.wholeArea ? "yes" : "no");
				pw.print(",");
				pw.print(form.q1 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q2 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q3 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q4 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q5 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q6 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q7 ? "yes" : "no");
				pw.print(",");
				pw.print(form.q8);
				pw.print(",");
				pw.print(form.q9);
				pw.print(",");
				pw.print(form.q10);
				pw.print(",");
				pw.print(form.q11);
				pw.print(",");
				pw.print(form.q12);
				pw.print(",");
				pw.print(form.q13);
				pw.print(",");
				pw.print(form.q18);
				pw.print(",");
				pw.print(form.q19);
				pw.print(",");
				pw.print(form.q20);
				pw.print(",");
				pw.print(form.q21);
				pw.println();
				pw.flush();
				byte[] bytes = sw.getBuffer().toString().getBytes(StandardCharsets.UTF_8);
				return bytes;
			}

	    };
	    return preparator;
	}
	
}
