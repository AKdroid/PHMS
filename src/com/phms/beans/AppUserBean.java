package com.phms.beans;

import java.util.ArrayList;
import java.util.Date;

public class AppUserBean {
	
	String userId;
	String firstName;
	String lastName;
	//gender
	String gender;
	// roles
	boolean isPatient;
	boolean isSupporter;
	// address
	String street;
	String city;
	String state;
	String country;
	String zipcode;
	// date of birth
	Date dob;
	// Diagnoses
	ArrayList<DiseaseBean> diseaseInfo;
	// Primary Health Supporter
	String phsUserId;
	String phsUserIdName;
	Date phsAuthorizationDate;
	// Secondary Health Supporter
	String shsUserId;
	String shsUserIdName;
	Date shsAuthorizationDate;
	
	public AppUserBean(){
		diseaseInfo = new ArrayList<DiseaseBean>();
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public boolean isPatient() {
		return isPatient;
	}

	public void setPatient(boolean isPatient) {
		this.isPatient = isPatient;
	}

	public boolean isSupporter() {
		return isSupporter;
	}

	public void setSupporter(boolean isSupporter) {
		this.isSupporter = isSupporter;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public ArrayList<DiseaseBean> getDiseaseInfo() {
		return diseaseInfo;
	}

	public void setDiseaseInfo(ArrayList<DiseaseBean> diseaseInfo) {
		this.diseaseInfo = diseaseInfo;
	}

	public String getPhsUserId() {
		return phsUserId;
	}

	public void setPhsUserId(String phsUserId) {
		this.phsUserId = phsUserId;
	}

	public String getPhsUserIdName() {
		return phsUserIdName;
	}

	public void setPhsUserIdName(String phsUserIdName) {
		this.phsUserIdName = phsUserIdName;
	}

	public Date getPhsAuthorizationDate() {
		return phsAuthorizationDate;
	}

	public void setPhsAuthorizationDate(Date phsAuthorizationDate) {
		this.phsAuthorizationDate = phsAuthorizationDate;
	}

	public String getShsUserId() {
		return shsUserId;
	}

	public void setShsUserId(String shsUserId) {
		this.shsUserId = shsUserId;
	}

	public String getShsUserIdName() {
		return shsUserIdName;
	}

	public void setShsUserIdName(String shsUserIdName) {
		this.shsUserIdName = shsUserIdName;
	}

	public Date getShsAuthorizationDate() {
		return shsAuthorizationDate;
	}

	public void setShsAuthorizationDate(Date shsAuthorizationDate) {
		this.shsAuthorizationDate = shsAuthorizationDate;
	}
	
	
	
	
}
