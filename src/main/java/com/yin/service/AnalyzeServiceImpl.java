package com.yin.service;

import java.util.List;

import com.yin.utils.ShellUtil;

public class AnalyzeServiceImpl implements AnalyzeService {

	public void analyze() {
		List<String> processList = ShellUtil.callShellWithReturn("ps");
		if (null != processList) {
			for (String line : processList) {
				System.out.println(line);
			}
		}
	}
}
