package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller  
public class UploadController {
	    @RequestMapping(value="/upload",method=RequestMethod.GET)  
	    public String HelloWorld(Model model){ 
	        model.addAttribute("message","Hello Spring MVC!!!");  //传参数给前端
	        return "upload"; 
	    }  
}
