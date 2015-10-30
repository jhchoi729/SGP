package org.kdea.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("ex")
public class ExController {

	@RequestMapping("index")
	public String viewIndex() {
		return "ex";
	}
}
