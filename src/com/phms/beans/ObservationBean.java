package com.phms.beans;

import java.util.Date;

public class ObservationBean 
{
	private boolean isObservationAvailable;
	
	private boolean isTempAvailable;
	private double temperature;
	private Date tempDate;

	private boolean isBPAvailable;
	private double systolic;
	private double diastolic;
	private Date bpDate;

	private boolean isWeightAvailable;
	private double weight;
	private Date weightDate;

	private boolean isO2Available;
	private double o2;
	private Date o2Date;

	private boolean isPainAvailable;
	private int pain;
	private Date painDate;

	private boolean isMoodAvailable;
	private String mood;
	private Date moodDate;
	
	public boolean isTempAvailable() {
		return isTempAvailable;
	}
	public void setTempAvailable(boolean isTempAvailable) {
		this.isTempAvailable = isTempAvailable;
	}
	public double getTemperature() {
		return temperature;
	}
	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}
	public Date getTempDate() {
		return tempDate;
	}
	public void setTempDate(Date tempDate) {
		this.tempDate = tempDate;
	}
	public boolean isBPAvailable() {
		return isBPAvailable;
	}
	public void setBPAvailable(boolean isBPAvailable) {
		this.isBPAvailable = isBPAvailable;
	}
	public double getSystolic() {
		return systolic;
	}
	public void setSystolic(double systolic) {
		this.systolic = systolic;
	}
	public double getDiastolic() {
		return diastolic;
	}
	public void setDiastolic(double diastolic) {
		this.diastolic = diastolic;
	}
	public Date getBpDate() {
		return bpDate;
	}
	public void setBpDate(Date bpDate) {
		this.bpDate = bpDate;
	}
	public boolean isWeightAvailable() {
		return isWeightAvailable;
	}
	public void setWeightAvailable(boolean isWeightAvailable) {
		this.isWeightAvailable = isWeightAvailable;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public Date getWeightDate() {
		return weightDate;
	}
	public void setWeightDate(Date weightDate) {
		this.weightDate = weightDate;
	}
	public boolean isO2Available() {
		return isO2Available;
	}
	public void setO2Available(boolean isO2Available) {
		this.isO2Available = isO2Available;
	}
	public double getO2() {
		return o2;
	}
	public void setO2(double o2) {
		this.o2 = o2;
	}
	public Date getO2Date() {
		return o2Date;
	}
	public void setO2Date(Date o2Date) {
		this.o2Date = o2Date;
	}
	public boolean isPainAvailable() {
		return isPainAvailable;
	}
	public void setPainAvailable(boolean isPainAvailable) {
		this.isPainAvailable = isPainAvailable;
	}
	public int getPain() {
		return pain;
	}
	public void setPain(int pain) {
		this.pain = pain;
	}
	public Date getPainDate() {
		return painDate;
	}
	public void setPainDate(Date painDate) {
		this.painDate = painDate;
	}
	public boolean isMoodAvailable() {
		return isMoodAvailable;
	}
	public void setMoodAvailable(boolean isMoodAvailable) {
		this.isMoodAvailable = isMoodAvailable;
	}
	public String getMood() {
		return mood;
	}
	public void setMood(String mood) {
		this.mood = mood;
	}
	public Date getMoodDate() {
		return moodDate;
	}
	public void setMoodDate(Date moodDate) {
		this.moodDate = moodDate;
	}
	public boolean isObservationAvailable() {
		return isObservationAvailable;
	}
	public void setObservationAvailable(boolean isObservationAvailable) {
		this.isObservationAvailable = isObservationAvailable;
	}
}