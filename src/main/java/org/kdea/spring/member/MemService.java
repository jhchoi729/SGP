package org.kdea.spring.member;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MemService {
	@Autowired
    protected JavaMailSender  mailSender;
	@Autowired
	private MemDAO memDao;

    public boolean sendMail(EmailVO email) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	     	msg.setFrom("someone@paran.com"); 
	        msg.setSubject(email.getSubject());
	        msg.setContent(email.getContent(), "text/html; charset=utf-8");
	        
	        msg.setRecipient(RecipientType.TO , new InternetAddress(email.getReceiver()));
	         
	        mailSender.send(msg);
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }

	public boolean nickCheck(String nick) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean idCheck(String id) {
		// TODO Auto-generated method stub
		return false;
	}

	public boolean regist(MemberVO member) {
		// TODO Auto-generated method stub
		return false;
	}
}
