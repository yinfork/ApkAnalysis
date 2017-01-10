package com.yin.service;

import java.util.List;

import org.apache.log4j.Logger;

import com.yin.controller.UploadController;
import com.yin.utils.FileUtil;
import com.yin.utils.ShellUtil;

public class AnalyzeServiceImpl implements AnalyzeService {
	
	private static Logger logger = Logger.getLogger(AnalyzeServiceImpl.class);

	public List<String> analyze(String apkPath) {
		String path = FileUtil.getResourcePath("sh/run.sh");
		
		ShellUtil.callShell("chmod 777 "+path);
		
		System.out.println("sh "+path+" "+apkPath);
		List<String> processList = ShellUtil.callShellWithReturn("sh "+path+" "+apkPath);
		if (null != processList) {
			for (String line : processList) {
				logger.info(line);
			}
		}
		return processList;
	}
}
