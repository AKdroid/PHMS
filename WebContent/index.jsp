<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>PHMS</title>
		<script type="text/javascript" src="js/angular.min1.5.js"></script>
		<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
		<link type="text/css" rel="stylesheet" href="css/bootstrap-theme.min.css" />
		<% String message = (String) request.getAttribute("message"); %>
	</head>
	<body>
		<div ng-include="'views/header.html'"></div>
		<div class="container">
			<h3>Login</h3>
			<% if(message != null) { %>
			<span> <%=message %> </span>
			<% } %>
			<form method='POST' action="./login">
				<div class="col-md-12">
					<div class="form-group">
						<label for="userId">User ID</label> 
						<input type="input" class="form-control" name="userId" id="userId" placeholder="User ID" required/>
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password" class="form-control" name="password" placeholder="Password" required/>
					</div>
				</div>
				<div class="col-md-12">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</form>
		</div>
		<div class="container">
			<a href="views/createUser.html">Create New User</a>
		</div>
	</body>
</html>