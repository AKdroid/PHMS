<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.phms.beans.AppUserBean" %>
<%@ page import="com.phms.beans.AlertBean" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>PHMS</title>
		<script type="text/javascript" src="js/angular.min1.5.js"></script>
		<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap-theme.min.css" />
		<% AppUserBean appUserBean = (AppUserBean) request.getAttribute("appUserBean"); %>
	</head>
	<body>
		<div ng-include="'views/header.html'"></div>
		<div class="row">
			<div class="col-md-8">
			</div>
			<div class="col-md-2">
				<form method='POST' action="./login">
					<input type="hidden" name="userId" id="userId" value="<%=appUserBean.getUserId() %>"/>
					<input type="hidden" name="page" id="page" value="details"/>
					<button type="submit" class="btn btn-primary">Back</button>
				</form>
			</div>
			<div class="col-md-2">
				<form method='POST' action="./logout">
					<button type="submit" class="btn btn-primary">Logout</button>
				</form>
			</div>
		</div>
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<label>User ID</label> 
				</div>
				<div class="col-md-4">
					<label><%=appUserBean.getUserId() %></label>  
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label>Name</label> 
				</div>
				<div class="col-md-4">
					<label><%=appUserBean.getFirstName() + " " + appUserBean.getLastName()%></label>  
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label>Date of Birth</label> 
				</div>
				<div class="col-md-4">
					<label><%=appUserBean.getDob() %></label>  
				</div>
			</div>
			<div class="row">
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>Alert Type</th>
				        <th>Alert Message</th>
				      </tr>
				    </thead>
					<tbody>
					<% for(AlertBean alert : appUserBean.getAlerts()) { %>
					<tr>
				        <td><%=alert.getObsType()%></td>
				        <td><%=alert.getAlert()%></td>
			      	</tr>
					<% } %>
					<tbody>
				</table>
			</div>
		</div>
	</body>
</html>