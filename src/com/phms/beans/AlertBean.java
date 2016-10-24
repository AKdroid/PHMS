package com.phms.beans;

public class AlertBean 
{
	private String patientId;
	private String alertId;
	private String obsType;
	private int alertType;
	private String alert;
	private String clearedBy;
	private String reason;
	public String getPatientId() {
		return patientId;
	}
	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}
	public String getObsType() {
		return obsType;
	}
	public void setObsType(String obsType) {
		this.obsType = obsType;
	}
	public int getAlertType() {
		return alertType;
	}
	public void setAlertType(int alertType) {
		this.alertType = alertType;
	}
	public String getAlert() {
		return alert;
	}
	public void setAlert(String alert) {
		this.alert = alert;
	}
	public String getClearedBy() {
		return clearedBy;
	}
	public void setClearedBy(String clearedBy) {
		this.clearedBy = clearedBy;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getAlertId() {
		return alertId;
	}
	public void setAlertId(String alertId) {
		this.alertId = alertId;
	}
	
	
}