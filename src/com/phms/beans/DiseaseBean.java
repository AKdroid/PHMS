package com.phms.beans;

import java.util.Date;

public class DiseaseBean {
	
	String diseaseName;
	Date diagnosedOn;
	Date curedOn;
	int status;
	
	public String getDiseaseName() {
		return diseaseName;
	}
	public void setDiseaseName(String diseaseName) {
		this.diseaseName = diseaseName;
	}
	public Date getDiagnosedOn() {
		return diagnosedOn;
	}
	public void setDiagnosedOn(Date diagnosedOn) {
		this.diagnosedOn = diagnosedOn;
	}
	public Date getCuredOn() {
		return curedOn;
	}
	public void setCuredOn(Date curedOn) {
		this.curedOn = curedOn;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	
	
}
