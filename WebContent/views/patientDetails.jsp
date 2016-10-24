<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.phms.beans.PatientDetailsBean" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
		<% PatientDetailsBean patientDetails = (PatientDetailsBean) request.getAttribute("patientDetails"); %>
		<% SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); %>
		<% String supporterId = (String) request.getAttribute("supporterId"); %>
	</head>
	<body>
		<div ng-include="'views/header.html'"></div>
		<form method='POST' action="./viewDetails">
				<input type="hidden" name="userId" id="userId" value="<%=supporterId %>"/>
				<div class="col-md-9">
				</div>
				<div class="col-md-3">
					<button type="submit" class="btn btn-primary">Back</button>
				</div>
		</form>
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<label>User ID</label> 
				</div>
				<div class="col-md-4">
					<label><%=patientDetails.getPatientId() %></label>  
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label>Name</label> 
				</div>
				<div class="col-md-4">
					<label><%=patientDetails.getFirstName() + " " + patientDetails.getLastName()%></label>  
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<label>Latest Observation</label> 
				</div>
			</div>
			<% if(patientDetails.getObservation().isObservationAvailable()) { %>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-hover">
					    <thead>
					      <tr>
					      	<th>Observation Type</th>
					        <th>Observation Value</th>
					        <th>Observation Date</th>
					      </tr>
					    </thead>
						<tbody>
						<% if(patientDetails.getObservation().isTempAvailable()) { %>
						<tr>
							<td>Temperature</td>
					        <td><%=patientDetails.getObservation().getTemperature() %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getTempDate()) %></td>
				      	</tr>
						<% } %>
						<% if(patientDetails.getObservation().isBPAvailable()) { %>
						<tr>
							<td>Blood Pressure</td>
							<td><%=patientDetails.getObservation().getSystolic() + "-" + patientDetails.getObservation().getDiastolic()  %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getBpDate()) %></td>
				      	</tr>
						<% } %>
						<% if(patientDetails.getObservation().isWeightAvailable()) { %>
						<tr>
							<td>Weight</td>
					        <td><%=patientDetails.getObservation().getWeight() %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getWeightDate()) %></td>
				      	</tr>
						<% } %>
						<% if(patientDetails.getObservation().isO2Available()) { %>
						<tr>
							<td>Oxygen Saturation Level</td>
					        <td><%=patientDetails.getObservation().getO2() %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getO2Date()) %></td>
				      	</tr>
						<% } %>
						<% if(patientDetails.getObservation().isPainAvailable()) { %>
						<tr>
							<td>Pain</td>
					        <td><%=patientDetails.getObservation().getPain() %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getPainDate()) %></td>
				      	</tr>
						<% } %>
						<% if(patientDetails.getObservation().isMoodAvailable()) { %>
						<tr>
							<td>Mood</td>
					        <td><%=patientDetails.getObservation().getMood() %></td>
					        <td><%=sdf.format(patientDetails.getObservation().getMoodDate()) %></td>
				      	</tr>
						<% } %>
						<tbody>
					</table>
				</div>
			</div>
			<% } else { %>
			<div class="row">
				<div class="col-md-3">
					<label>No observation available.</label> 
				</div>
			</div>
			<% } %>
			<div class="row">
				<div class="col-md-3">
					<label>Recommendations</label> 
				</div>
			</div>
			<form method='POST' action="./insertRecommendation">
				<input type="hidden" name="patientId" id="patientId" value="<%=patientDetails.getPatientId() %>"/>
				<input type="hidden" name="supporterId" id="supporterId" value="<%=supporterId %>"/>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Temperature</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="tempMin">Temperature Minimum Value</label> 
						<input type="input" class="form-control" name="tempMin" id="tempMin" placeholder="Temperature Minimum Value" <% if(patientDetails.getRecommendation().isTempAvailable()) { %> value="<%=patientDetails.getRecommendation().getTempMin() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="tempMax">Temperature Maximum Value</label> 
						<input type="input" class="form-control" name="tempMax" id="tempMax" placeholder="Temperature Maximum Value" <% if(patientDetails.getRecommendation().isTempAvailable()) { %> value="<%=patientDetails.getRecommendation().getTempMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="tempFreq">Temperature Frequency</label> 
						<input type="input" class="form-control" name="tempFreq" id="tempFreq" placeholder="Temperature Frequency" <% if(patientDetails.getRecommendation().isTempAvailable()) { %> value="<%=patientDetails.getRecommendation().getTempFrequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Weight</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="weightMin">Weight Minimum Value</label> 
						<input type="input" class="form-control" name="weightMin" id="weightMin" placeholder="Weight Minimum Value" <% if(patientDetails.getRecommendation().isWeightAvailable()) { %> value="<%=patientDetails.getRecommendation().getWeightMin() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="weightMax">Weight Maximum Value</label> 
						<input type="input" class="form-control" name="weightMax" id="weightMax" placeholder="Weight Maximum Value" <% if(patientDetails.getRecommendation().isWeightAvailable()) { %> value="<%=patientDetails.getRecommendation().getWeightMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="weightFreq">Weight Frequency</label> 
						<input type="input" class="form-control" name="weightFreq" id="weightFreq" placeholder="Weight Frequency" <% if(patientDetails.getRecommendation().isWeightAvailable()) { %> value="<%=patientDetails.getRecommendation().getWeightFrequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Blood Pressure</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="sysmin">Systolic Minimum Value</label> 
						<input type="input" class="form-control" name="sysmin" id="sysmin" placeholder="Systolic Minimum Value" <% if(patientDetails.getRecommendation().isBPAvailable()) { %> value="<%=patientDetails.getRecommendation().getSystolicMin() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="sysmax">Systolic Maximum Value</label> 
						<input type="input" class="form-control" name="sysmax" id="sysmax" placeholder="Systolic Maximum Value" <% if(patientDetails.getRecommendation().isBPAvailable()) { %> value="<%=patientDetails.getRecommendation().getSystolicMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="diastolicmin">Diastolic Minimum Value</label> 
						<input type="input" class="form-control" name="diastolicmin" id="diastolicmin" placeholder="Diastolic Minimum Value" <% if(patientDetails.getRecommendation().isBPAvailable()) { %> value="<%=patientDetails.getRecommendation().getDiastolicMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="diastolicmax">Diastolic Maximum Value</label> 
						<input type="input" class="form-control" name="diastolicmax" id="diastolicmax" placeholder="Diastolic Maximum Value" <% if(patientDetails.getRecommendation().isBPAvailable()) { %> value="<%=patientDetails.getRecommendation().getDiastolicMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="bpFreq">Blood Pressure Frequency</label> 
						<input type="input" class="form-control" name="bpFreq" id="bpFreq" placeholder="Blood Pressure Frequency" <% if(patientDetails.getRecommendation().isBPAvailable()) { %> value="<%=patientDetails.getRecommendation().getBpFrequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Oxygen Saturation Level</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="spo2Min">SPO2 Minimum Value</label> 
						<input type="input" class="form-control" name="spo2Min" id="spo2Min" placeholder="SPO2 Minimum Value" <% if(patientDetails.getRecommendation().isO2Available()) { %> value="<%=patientDetails.getRecommendation().getO2Min() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="spo2Max">SPO2 Maximum Value</label> 
						<input type="input" class="form-control" name="spo2Max" id="spo2Max" placeholder="SPO2 Maximum Value" <% if(patientDetails.getRecommendation().isO2Available()) { %> value="<%=patientDetails.getRecommendation().getO2Max() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="spo2Freq">SPO2 Frequency</label> 
						<input type="input" class="form-control" name="spo2Freq" id="spo2Freq" placeholder="SPO2 Frequency" <% if(patientDetails.getRecommendation().isO2Available()) { %> value="<%=patientDetails.getRecommendation().getO2Frequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Pain</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="pain">Pain</label> 
						<input type="input" class="form-control" name="pain" id="pain" placeholder="Pain" <% if(patientDetails.getRecommendation().isPainAvailable()) { %> value="<%=patientDetails.getRecommendation().getPainMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="painFreq">Pain Frequency</label> 
						<input type="input" class="form-control" name="painFreq" id="painFreq" placeholder="Pain Frequency" <% if(patientDetails.getRecommendation().isPainAvailable()) { %> value="<%=patientDetails.getRecommendation().getPainFrequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label for="bp">Mood</label>
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="mood">Mood</label> 
						<input type="input" class="form-control" name="mood" id="mood" placeholder="Mood" <% if(patientDetails.getRecommendation().isMoodAvailable()) { %> value="<%=patientDetails.getRecommendation().getMoodMax() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="moodFreq">Mood Frequency</label> 
						<input type="input" class="form-control" name="moodFreq" id="moodFreq" placeholder="Mood Frequency" <% if(patientDetails.getRecommendation().isMoodAvailable()) { %> value="<%=patientDetails.getRecommendation().getMoodFrequency() %>" <% } %> />
					</div>
				</div>
				<div class="col-md-12">
					<button type="submit" class="btn btn-primary">Submit</button>
				</div>
			</form>
		</div>
	</body>
</html>