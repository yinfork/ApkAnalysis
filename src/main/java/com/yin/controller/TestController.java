package com.yin.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yin.service.AnalyzeService;


@Controller
public class TestController {
	private static Logger logger = Logger.getLogger(TestController.class);
	
	AnalyzeService analyzeService;
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String HelloWorld(Model model) {
		model.addAttribute("message", "Hello Spring MVC!!!"); // 传参数给前端
		
//		analyzeService = new AnalyzeServiceImpl();
//		analyzeService.analyze("");
		
		logger.info("info测试");
        logger.debug("debug测试 ");
        logger.error("error测试");
		
		return "test";
	}
}
