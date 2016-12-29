package com.springmvc.controller;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {
	private final static String PATH = "//Users//yinjianhua//Desktop//hello";
	
	// 定位到上传单个文件界面
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String showUploadPage() {
		return "uploadFile"; // view文件夹下的上传单个文件的页面
	}

	/**
	 * 上传单个文件操作
	 * 
	 * @param multi
	 * @return
	 */
	@RequestMapping(value = "/doUpload", method = RequestMethod.POST)
	public String doUploadFile(@RequestParam("file") MultipartFile file) {

		if (!file.isEmpty()) {
			try {
				FileUtils.copyInputStreamToFile(file.getInputStream(), new File(PATH,
						System.currentTimeMillis() + file.getOriginalFilename()));

			} catch (IOException e) {
				e.printStackTrace();
				System.out.println(e.toString());
			}
		}

		return "success";
	}
}
