package nz.co.parhelion.operat.config;

import javax.naming.NamingException;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.datasource.lookup.JndiDataSourceLookup;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.EnableAsync;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

@Configuration
@ComponentScan(basePackages = "nz.co.parhelion.operat")
@PropertySource(value= {"classpath:application.properties"})
@EnableAsync
public class AppConfig {

	@Value("${operat.mailHost}")
	private String mailHost;
	

	@Value("${operat.mailPort}")
	private int mailPort;
	
	@Bean
	public ObjectMapper jacksonObjectMapper() {
	    return new ObjectMapper().setPropertyNamingStrategy(
	            PropertyNamingStrategy.CAMEL_CASE_TO_LOWER_CASE_WITH_UNDERSCORES);
	}

	
	@Bean
	DataSource dataSource() {
		final JndiDataSourceLookup dsLookup = new JndiDataSourceLookup();
        dsLookup.setResourceRef(true);
        DataSource dataSource = dsLookup.getDataSource("java:comp/env/jdbc/operat");
        return dataSource;
	}

	
	@Bean 
	JavaMailSender mailSender() throws IllegalArgumentException, NamingException {
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(mailHost);
		sender.setPort(mailPort);
		return sender;
	}
	
}
