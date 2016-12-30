package com.yin.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class ShellUtil {

	public static List<String> callShellWithReturn(String command){
		if(null == command || command.length() == 0) return null;
		Process process = null;
		List<String> processList = new ArrayList<String>();
		try {
			process = Runtime.getRuntime().exec(command);
			BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream()));
			String line = "";
			while ((line = input.readLine()) != null) {
				processList.add(line);
			}
			input.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return processList;
	}
	
	
	public static boolean callShell(String command) {
		if(null == command || command.length() == 0) return false;
		try {
			Process process = Runtime.getRuntime().exec(command);
			int exitValue = process.waitFor();
			if (0 != exitValue) {
				System.out.println("call shell failed. error code is :" + exitValue);
				return false;
			}
		} catch (Throwable e) {
			System.out.println("call shell failed. " + e);
			return false;
		}
		return true;
	}
	
}
