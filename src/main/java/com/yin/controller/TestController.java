package com.yin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yin.service.AnalyzeService;
import com.yin.service.AnalyzeServiceImpl;


@Controller
public class TestController {
	AnalyzeService analyzeService;
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String HelloWorld(Model model) {
		model.addAttribute("message", "Hello Spring MVC!!!"); // 传参数给前端
		
//		analyzeService = new AnalyzeServiceImpl();
//		analyzeService.analyze("");
		return "test";
	}
}
