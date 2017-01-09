<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="resources/js/jquery-2.2.0.min.js"></script>
<script src="resources/js/analyze.js"></script>

<title>APK分析页面</title>
</head>
<script type="text/javascript">
var basepath = "<%=request.getContextPath()%>";
</script>

<body onload="setInterval('requestOutput(basepath)',second)">
	<h1 align="left">Output</h1>
	<div align="left" id="output"></div>
</body>
</html>