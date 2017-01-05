package com.yin.utils;

public class FileUtil {
	public static String getResourcePath(String resource) {
		if (TextUtil.isEmpty(resource))
			return null;

		if (null != FileUtil.class.getClassLoader().getResource(resource)) {
			return FileUtil.class.getClassLoader().getResource(resource).getPath();
		} else {
			return null;
		}
	}
	
	public static String getResourcePath() {
		return FileUtil.class.getClassLoader().getResource("").getPath();
	}
}
