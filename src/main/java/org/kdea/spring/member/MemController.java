package org.kdea.spring.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/mem/")
public class MemController {
	@Autowired
	private MemService memService;
	

	@RequestMapping("send")
	@ResponseBody
	public String sendMail(HttpServletRequest request) throws Exception {

		EmailVO email = new EmailVO();
		String mail = request.getParameter("email");
		System.out.println(mail);
		String sId = request.getSession().getId();
		request.getSession().setAttribute("email", mail);
		/*
		 * String receiver = "jhchoi729@naver.com"; //Receiver.
		 */
		String subject = "인증 확인 메일";
		String content = "<html>"
				+ "<head>"
				+ "</head>"
				+ "<body>"
				+ "<a href=\"http://192.168.8.28:8888/SpringWeb/email/userInput?auth="
				+ sId + "\">인증용 링크</a>" + "</body>" + "</html>";

		email.setReceiver(mail);
		email.setSubject(subject);
		email.setContent(content);
		boolean result = memService.sendMail(email);

		return "{\"ok\":" + result + "}";
	}

	@RequestMapping("userInput")
	public String returnlink(HttpServletRequest request, @RequestParam String auth) throws Exception {
		if(request.getSession().getId().equals(auth)){
			request.getSession().setAttribute("check", true);
		}
		return "redirect:/mem/input";
	}
	
	@RequestMapping("idCheck")
	@ResponseBody
	public String idCheck(@RequestParam("id") String id) {
		boolean result = memService.idCheck(id);

		return "{\"ok\":" + result + "}";
	}
	@RequestMapping("nickCheck")
	@ResponseBody
	public String nickCheck(@RequestParam("nick") String nick) {
		boolean result = memService.nickCheck(nick);

		return "{\"ok\":" + result + "}";
	}
	
	@RequestMapping("input")
	public String meminput(Model model) {
		return "mem/memInput";
	}
	
	@RequestMapping("regist")
	@ResponseBody
	public String regist(MemberVO member) {
		System.out.println(member.getEmail());
		boolean ok = memService.regist(member);
		
		return "{\"ok\":" + ok + "}";
	}

}
