<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.phms.beans.AppUserBean" %>
<%@ page import="com.phms.beans.DiseaseBean" %>
<%@ page import="com.phms.beans.AppUserBasicBean" %>
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
		<% String message = (String) request.getAttribute("message"); %>
		<% String viewMessage = (String) request.getAttribute("viewMessage"); %>
		<% String hspage = (String) request.getAttribute("hspage"); %>
		<% List<AppUserBasicBean> patients = (ArrayList<AppUserBasicBean>)request.getAttribute("patients"); %>
		<% List<AlertBean> alerts = (ArrayList<AlertBean>)request.getAttribute("alerts"); %>
	</head>
	<body>
		<div ng-include="'views/header.html'"></div>
		<div class="row">
			<div class="col-md-8">
			</div>
			<div class="col-md-2">
				<form method='POST' action="./viewAlerts">
					<input type="hidden" name="userId" id="userId" value="<%=appUserBean.getUserId() %>"/>
					<button type="submit" class="btn btn-primary <%if(appUserBean.getAlerts().size() == 0) {%> disabled <% } %>">Alerts (<%=appUserBean.getAlerts().size()%>)</button>
				</form>
			</div>
			<div class="col-md-2">
				<form method='POST' action="./logout">
					<button type="submit" class="btn btn-primary">Logout</button>
				</form>
			</div>
		</div>
		<div class="container">
			<ul class="nav nav-tabs">
				<% if(appUserBean.isPatient()) { %>
			  	<li <%if(appUserBean.isPatient() && hspage == null) { %> class="active" <% } %>>
			  		<a data-toggle="tab" href="#patient">Patient Details</a>
			  	</li>
			  	<% } %>
			  	<% if(appUserBean.isSupporter()) { %>
			  	<li <%if(!appUserBean.isPatient() || hspage != null) { %> class="active" <% } %>>
			  		<a data-toggle="tab" href="#hs">Health Supporter Details</a>
			  	</li>
			  	<% } %>
			</ul>
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
			<div class="tab-content">
				<% if(appUserBean.isPatient()) { %>
			  	<div id="patient" class="tab-pane fade <%if(appUserBean.isPatient() && hspage == null) { %> in active <% } %>">
			  		<% if(appUserBean.getDiseaseInfo().size() > 0) { %>
			    	<div class="row">
						<div class="col-md-3">
							<label>Diagnosis</label> 
						</div>
					</div>
					<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Disease</th>
					        <th>Diagnosis Date</th>
					      </tr>
					    </thead>
						<tbody>
						<% for(DiseaseBean disease : appUserBean.getDiseaseInfo()) { %>
						<tr>
					        <td><%=disease.getDiseaseName()%></td>
					        <td><%=disease.getDiagnosedOn()%></td>
				      	</tr>
						<% } %>
						<tbody>
					</table>
					<% } %>
					<%if (appUserBean.getActive().equals("Active")){ %>
					<div class="row">
						<div class="col-md-3">
							<label>Observations</label> 
						</div>
					</div>
					<% if(message != null) { %>
					<span> <%=message %> </span>
					<% } %>
					<form method='POST' action="./observation">
						<input type="hidden" name="userId" id="userId" value="<%=appUserBean.getUserId()%>"/>
						<div class="col-md-4">
							<div class="form-group">
								<label for="temp">Temperature</label> 
								<input type="input" class="form-control" name="temp" id="temp" placeholder="Temperature"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="tempDate">Date</label> 
								<input type="date" class="form-control" name="tempDate" id="tempDate" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="tempTime">Time</label> 
								<input type="input" class="form-control" name="tempTime" id="tempTime" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-12">
							<div class="form-group">
								<label for="bp">Blood Pressure</label>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label for="systolic">Systolic</label> 
								<input type="input" class="form-control" name="systolic" id="systolic" placeholder="Systolic"/>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label for=""diastolic"">Diastolic</label> 
								<input type="input" class="form-control" name="diastolic" id="diastolic" placeholder="Diastolic"/>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label for="bpDate">Date</label> 
								<input type="date" class="form-control" name="bpDate" id="bpDate" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label for="bpTime">Time</label> 
								<input type="input" class="form-control" name="bpTime" id="bpTime" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="weight">Weight</label> 
								<input type="input" class="form-control" name="weight" id="weight" placeholder="Weight"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="weightDate">Date</label> 
								<input type="date" class="form-control" name="weightDate" id="weightDate" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="weightTime">Time</label> 
								<input type="input" class="form-control" name="weightTime" id="weightTime" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="o2">Oxygen Saturation Level</label> 
								<input type="input" class="form-control" name="o2" id="o2" placeholder="Oxygen Saturation Level"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="o2Date">Date</label> 
								<input type="date" class="form-control" name="o2Date" id="o2Date" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="o2Time">Time</label> 
								<input type="input" class="form-control" name="o2Time" id="o2Time" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="pain">Pain</label> 
								<input type="number" class="form-control" id="pain" name="pain" min="1" step="1" max="10" placeholder="Pain"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="painDate">Date</label> 
								<input type="date" class="form-control" name="painDate" id="painDate" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="painTime">Time</label> 
								<input type="input" class="form-control" name="painTime" id="painTime" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="mood">Mood</label>
								<label class="form-control">
									<div class="row">
										<div class="col-md-4">
									    	<input type="radio" id="mood" name="mood" value="happy"> Happy
								    	</div>
									    <div class="col-md-4">
									    	<input type="radio" id="mood" name="mood" value="neutral"> Neutral
								    	</div>
								    	<div class="col-md-4">
									    	<input type="radio" id="mood" name="mood" value="sad"> Sad
								    	</div>
									</div>
								</label>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="moodDate">Date</label> 
								<input type="date" class="form-control" name="moodDate" id="moodDate" placeholder="Date"/>
							</div>
						</div>
						<div class="col-md-4">
							<div class="form-group">
								<label for="moodTime">Time</label> 
								<input type="input" class="form-control" name="moodTime" id="moodTime" placeholder="HH:MM"/>
							</div>
						</div>
						<div class="col-md-12">
							<button type="submit" class="btn btn-primary">Submit</button>
						</div>
					</form>
					<% } else { %>
						<span> At least one health supporter is mandatory. Add an existing health supporter</span>
						<form method="POST" action="./addSupporter">
							<div class="form-group">
							<input type="hidden" name="userId" value="<%= appUserBean.getUserId() %>"/>
							<label>Health Supporter</label>
							<div class="row">
								<div class="col-md-6">
									<label for="phsId">Primary Health Supporter ID</label> 
									<input type="input" name = "phsId" class="form-control" id="phsId" placeholder="Primary Health Supporter"/>
								</div>
								<div class="col-md-6">
									<label for="phsAd">Primary Health Supporter Authorization Date</label> 
									<input type="date" name = "phsAd" class="form-control" id="phsAd" placeholder="Primary Health Supporter Authorization Date"/>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<label for="shsId">Secondary Health Supporter ID</label> 
									<input type="input" name = "shsId" class="form-control" id="shsId" placeholder="Secondary Health Supporter"/>
								</div>
								<div class="col-md-6">
									<label for="shsAd">Secondary Health Supporter Authorization Date</label> 
									<input type="date" name = "shsAd" class="form-control" id="shsAd" placeholder="Secondary Health Supporter Authorization Date"/>
								</div>
							</div>
							</div>
							<div class="col-md-12">
								<button type="submit" class="btn btn-primary" >Add Supporters</button>
							</div>
						</form>
					<% } %>
			  	</div>
			  	<% } %>
			  	<% if(appUserBean.isSupporter()) { %>
			  	<div id="hs" class="tab-pane fade <%if(!appUserBean.isPatient() || hspage != null) { %> in active <% } %>">
			  		<div class="row">
						<div class="col-md-3">
							<label>View Details</label> 
						</div>
					</div>
			  		<% if(viewMessage != null) { %>
					<span> <%=viewMessage %> </span>
					<% } %>
			    	<form method='POST' action="./viewDetails">
			    		<input type="hidden" name="userId" id="userId" value="<%=appUserBean.getUserId()%>"/>
						<div class="col-md-6">
							<div class="form-group">
								<select class="form-control" name="selView" id="selView">
								    <option value="patients">Patients</option>
								    <option value="alerts">Alerts</option>
								</select>
							</div>
						</div>
						<div class="col-md-6">
							<button type="submit" class="btn btn-primary">View</button>
						</div>
					</form>
					<% if(patients != null && patients.size() > 0) { %>
					<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Patient ID</th>
					        <th>Patient Name</th>
					      </tr>
					    </thead>
						<tbody>
						<% for(AppUserBasicBean patient : patients) { %>
						<tr>
					        <td>
					        	<a href="./viewPatient?sid=<%=appUserBean.getUserId() %>&pid=<%=patient.getUserId()%>"> 
					        		<%=patient.getUserId()%> 
					        	</a>
					        </td>
					        <td><%=patient.getFirstName() + " " + patient.getLastName()%></td>
				      	</tr>
						<% } %>
						<tbody>
					</table>
					<% } else if(patients != null && patients.size() == 0) { %>
					<span> No patients to view. </span>
					<% } %>
					<% if(alerts != null && alerts.size() > 0) { %>
					<table class="table table-hover">
					    <thead>
					      <tr>
					        <th>Patient ID</th>
					        <th>Type</th>
					        <th>Alert Message</th>
					        <th>Justification</th>
					        <th>Delete</th>
					      </tr>
					    </thead>
						<tbody>
						<% for(AlertBean alert : alerts) { %>
						<tr>
					        <td><%=alert.getPatientId() %></td>
					        <td><%=alert.getObsType() %></td>
					        <td><%=alert.getAlert()%></td>
					        <td>
					        	<input type="input" class="form-control" name="reason" ng-model="reason<%=alert.getAlertId() %>" id="reason" placeholder="Justification"/>
					        </td>
					        <td>
					        	<a href="./deleteAlert?alertId=<%=alert.getAlertId()%>&deletedBy=<%=appUserBean.getUserId()%>&message={{reason<%=alert.getAlertId() %>}}">
					        		Delete
				        		</a>
				        	</td>
				      	</tr>
						<% } %>
						<tbody>
					</table>
					<% } else if(alerts != null && alerts.size() == 0) { %>
					<span> No alerts to view. </span>
					<% } %>
			  	</div>
			  	<% } %>
			</div>
		</div>
	</body>
</html>