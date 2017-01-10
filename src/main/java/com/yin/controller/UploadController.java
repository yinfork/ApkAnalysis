package com.yin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.yin.service.AnalyzeService;
import com.yin.service.AnalyzeServiceImpl;

@Controller
public class UploadController {
	private final static String FILE_PATH = "//Users//yinjianhua//Desktop//hello";
	private static Logger logger = Logger.getLogger(UploadController.class);

	private String mOutputLog = "";

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

		new Thread(new Runnable() {

			@Override
			public void run() {
				work(file);
			}
		}).start();

		return "analyze";
	}

	@RequestMapping(value = "/result", method = RequestMethod.GET, produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String result() {
		return mOutputLog;
	}

	private void work(MultipartFile file) {
		if (!file.isEmpty()) {
			try {
				mOutputLog += "开始上传<br>";
				logger.info("开始上传");
				Date now = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");// 精确到毫秒
				String time = dateFormat.format(now);

				File workPath = new File(FILE_PATH + "//" + time);
				File inputPath = new File(FILE_PATH + "//" + time + "//input");
				inputPath.mkdirs();

				FileUtils.copyInputStreamToFile(file.getInputStream(), new File(inputPath, file.getOriginalFilename()));

				mOutputLog += "上传完成<br>";
				logger.info("上传完成");

				AnalyzeService analyzeService;
				analyzeService = new AnalyzeServiceImpl();
				List<String> result = analyzeService.analyze(workPath.getPath() + "/");

				if (null != result) {
					for (String line : result) {
						mOutputLog += line + "<br>";
					}
				}
				logger.info("分析完成");
			} catch (IOException e) {
				e.printStackTrace();
				logger.error("发生错误");
				logger.error(e.toString());
			}
		}
	}

}
