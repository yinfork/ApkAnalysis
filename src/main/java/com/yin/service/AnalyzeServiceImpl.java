package com.yin.service;

import java.util.List;

import com.yin.utils.FileUtil;
import com.yin.utils.ShellUtil;

public class AnalyzeServiceImpl implements AnalyzeService {

	public void analyze() {
		String path = FileUtil.getResourcePath("sh/run.sh");
		
		String apkPath = "/Users/yinjianhua/Desktop/hello/";
		ShellUtil.callShell("chmod 777 "+path);
		
		System.out.println("sh "+path+" "+apkPath);
		List<String> processList = ShellUtil.callShellWithReturn("sh "+path+" "+apkPath);
		if (null != processList) {
			for (String line : processList) {
				System.out.println(line);
			}
		}
	}
}
