<%@ page import="utils.JSFunction" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String saveDirectory = application.getRealPath("/Uploads");
String saveFilename = request.getParameter("sName");
String originalFilename = request.getParameter("oName");

System.out.println(saveFilename);
System.out.println(originalFilename);

try {
	File file = new File(saveDirectory, saveFilename);
	InputStream inStream = new FileInputStream(file);
	
	String client = request.getHeader("User-Agent");
	if (client.indexOf("Chrome/104.0.0.0") == -1) {
		originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
	}
	else {
		originalFilename = new String(originalFilename.getBytes("KSC5601"),"ISO-8859-1");
	}
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition","attachment; filename=\"" + originalFilename + "\"");
	response.setHeader("Context-Length", "" + file.length() );
	
	out.clear();
	
	OutputStream outStream = response.getOutputStream();
	
	byte b[] = new byte[(int)file.length()];
	int readBuffer = 0;
	while ((readBuffer = inStream.read(b)) > 0) {
		outStream.write(b, 0, readBuffer);
	}
	
	inStream.close();
	outStream.close();
}
catch (FileNotFoundException e){
	JSFunction.alertBack("파일을 찾을 수 없습니다.", out);
}
catch (Exception e){
	JSFunction.alertBack("예외가 발생하였습니다.", out);
	e.printStackTrace();
}
%>