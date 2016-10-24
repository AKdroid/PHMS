package com.phms.beans;

public class PatientDetailsBean 
{
	private String patientId;
	private String firstName;
	private String lastName;
	private ObservationBean observation;
	private RecommendationBean recommendation;
	
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public ObservationBean getObservation() {
		return observation;
	}
	public void setObservation(ObservationBean observation) {
		this.observation = observation;
	}
	public RecommendationBean getRecommendation() {
		return recommendation;
	}
	public void setRecommendation(RecommendationBean recommendation) {
		this.recommendation = recommendation;
	}
}