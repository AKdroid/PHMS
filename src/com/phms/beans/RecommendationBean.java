package com.phms.beans;

public class RecommendationBean 
{
	private boolean isTempAvailable;
	private double tempMin;
	private double tempMax;
	private int tempFrequency;
	private boolean isWeightAvailable;
	private double weightMin;
	private double weightMax;
	private int weightFrequency;
	private boolean isBPAvailable;
	private double systolicMin;
	private double systolicMax;
	private double diastolicMin;
	private double diastolicMax;
	private int bpFrequency;
	private boolean isO2Available;
	private double o2Min;
	private double o2Max;
	private int o2Frequency;
	private boolean isPainAvailable;
	private int painMax;
	private int painFrequency;
	private boolean isMoodAvailable;
	private String moodMax;
	private int moodFrequency;
	public boolean isTempAvailable() {
		return isTempAvailable;
	}
	public void setTempAvailable(boolean isTempAvailable) {
		this.isTempAvailable = isTempAvailable;
	}
	public boolean isWeightAvailable() {
		return isWeightAvailable;
	}
	public void setWeightAvailable(boolean isWeightAvailable) {
		this.isWeightAvailable = isWeightAvailable;
	}
	public boolean isBPAvailable() {
		return isBPAvailable;
	}
	public void setBPAvailable(boolean isBPAvailable) {
		this.isBPAvailable = isBPAvailable;
	}
	public boolean isO2Available() {
		return isO2Available;
	}
	public void setO2Available(boolean isO2Available) {
		this.isO2Available = isO2Available;
	}
	public boolean isPainAvailable() {
		return isPainAvailable;
	}
	public void setPainAvailable(boolean isPainAvailable) {
		this.isPainAvailable = isPainAvailable;
	}
	public boolean isMoodAvailable() {
		return isMoodAvailable;
	}
	public void setMoodAvailable(boolean isMoodAvailable) {
		this.isMoodAvailable = isMoodAvailable;
	}
	public double getTempMin() {
		return tempMin;
	}
	public void setTempMin(double tempMin) {
		this.tempMin = tempMin;
	}
	public double getTempMax() {
		return tempMax;
	}
	public void setTempMax(double tempMax) {
		this.tempMax = tempMax;
	}
	public int getTempFrequency() {
		return tempFrequency;
	}
	public void setTempFrequency(int tempFrequency) {
		this.tempFrequency = tempFrequency;
	}
	public double getWeightMin() {
		return weightMin;
	}
	public void setWeightMin(double weightMin) {
		this.weightMin = weightMin;
	}
	public double getWeightMax() {
		return weightMax;
	}
	public void setWeightMax(double weightMax) {
		this.weightMax = weightMax;
	}
	public int getWeightFrequency() {
		return weightFrequency;
	}
	public void setWeightFrequency(int weightFrequency) {
		this.weightFrequency = weightFrequency;
	}
	public double getSystolicMin() {
		return systolicMin;
	}
	public void setSystolicMin(double systolicMin) {
		this.systolicMin = systolicMin;
	}
	public double getSystolicMax() {
		return systolicMax;
	}
	public void setSystolicMax(double systolicMax) {
		this.systolicMax = systolicMax;
	}
	public double getDiastolicMin() {
		return diastolicMin;
	}
	public void setDiastolicMin(double diastolicMin) {
		this.diastolicMin = diastolicMin;
	}
	public double getDiastolicMax() {
		return diastolicMax;
	}
	public void setDiastolicMax(double diastolicMax) {
		this.diastolicMax = diastolicMax;
	}
	public int getBpFrequency() {
		return bpFrequency;
	}
	public void setBpFrequency(int bpFrequency) {
		this.bpFrequency = bpFrequency;
	}
	public double getO2Min() {
		return o2Min;
	}
	public void setO2Min(double o2Min) {
		this.o2Min = o2Min;
	}
	public double getO2Max() {
		return o2Max;
	}
	public void setO2Max(double o2Max) {
		this.o2Max = o2Max;
	}
	public int getO2Frequency() {
		return o2Frequency;
	}
	public void setO2Frequency(int o2Frequency) {
		this.o2Frequency = o2Frequency;
	}
	public int getPainMax() {
		return painMax;
	}
	public void setPainMax(int painMax) {
		this.painMax = painMax;
	}
	public int getPainFrequency() {
		return painFrequency;
	}
	public void setPainFrequency(int painFrequency) {
		this.painFrequency = painFrequency;
	}
	public String getMoodMax() {
		return moodMax;
	}
	public void setMoodMax(String moodMax) {
		this.moodMax = moodMax;
	}
	public int getMoodFrequency() {
		return moodFrequency;
	}
	public void setMoodFrequency(int moodFrequency) {
		this.moodFrequency = moodFrequency;
	}
}