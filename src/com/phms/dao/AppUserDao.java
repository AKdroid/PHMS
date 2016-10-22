package com.phms.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import com.phms.beans.AppUserBasicBean;
import com.phms.beans.AppUserBean;
import com.phms.beans.DiseaseBean;
import com.phms.utils.DBConnection;

public class AppUserDao {

	public AppUserBean fetchUserData(String userId){
		AppUserBean appUser = new AppUserBean();
		DBConnection dbConnection = DBConnection.getConnection();
		String query = "SELECT * FROM APP_USERS WHERE USER_ID = " + userId;
		ResultSet rs;
		
		rs = dbConnection.executeQuery(query);
		if(rs == null)
			return null;
		else{
			
			try {
				if(rs.next()){
					appUser.setUserId(userId);
					appUser.setFirstName(rs.getString("FIRST_NAME"));
					appUser.setLastName(rs.getString("LAST_NAME"));
					
					appUser.setPatient(rs.getString("USER_TYPE").equals("Supporter"));
					appUser.setSupporter(rs.getString("USER_TYPE").equals("Patient"));
					
					appUser.setStreet(rs.getString("STREET"));
					appUser.setCity(rs.getString("CITY"));
					appUser.setState(rs.getString("STATE"));
					appUser.setCountry(rs.getString("COUNTRY"));
					appUser.setZipcode(rs.getString("ZIPCODE"));
					
					appUser.setDob(rs.getDate("DOB"));
					appUser.setGender(rs.getString("GENDER"));
					
					query = "SELECT D.DISEASE_NAME AS DISEASE_NAME,"
							+ " R.DIAGNOSED_ON AS DIAGNOSED_ON, "
							+ "R.CURED_ON AS CURED_ON,"
							+ " R.STATUS AS STATUS FROM PATIENT_DISEASES R, DISEASES D"+
							"WHERE D.DISEASE_ID = R.DISEASE_ID AND R.PATIENT_ID = "+userId;
					rs = dbConnection.executeQuery(query);
					while(rs.next()){
						DiseaseBean dbean = new DiseaseBean();
						dbean.setDiseaseName(rs.getString("DISEASE_NAME"));
						dbean.setDiagnosedOn(rs.getDate("DIAGNOSED_ON"));
						dbean.setCuredOn(rs.getDate("CURED_ON"));
						dbean.setStatus(rs.getInt("STATUS"));
						appUser.getDiseaseInfo().add(dbean);
					}
					query = "SELECT  U.USER_ID AS USER_ID,"
							+ "U.FIRST_NAME AS FIRST_NAME,"
							+ "U.LAST_NAME AS LAST_NAME,"
							+ "R.AUTHORIZATION_DATE AS AUTH_DATE,"
							+ "R.IS_PRIMARY"
							+ "FROM APP_USERS U, PATIENT_SUPPORTERS R WHERE"
							+ "R.USER_ID_SUPPORTER = U.USER_ID AND"
							+ "R.USER_ID_PATIENT = " +userId;
					rs = dbConnection.executeQuery(query);
					while(rs.next()){
						if(rs.getInt("IS_PRIMARY")==1){
							appUser.setPhsAuthorizationDate(rs.getDate("AUTH_DATE"));
							appUser.setPhsUserId(rs.getString("USER_ID"));
							appUser.setPhsUserIdName(rs.getString("FIRST_NAME")+" " + rs.getString("LAST_NAME"));
						} else {
							appUser.setShsAuthorizationDate(rs.getDate("AUTH_DATE"));
							appUser.setShsUserId(rs.getString("USER_ID"));
							appUser.setShsUserIdName(rs.getString("FIRST_NAME")+" " + rs.getString("LAST_NAME"));
						}
					}
					
				} else {
					return null;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				appUser = null;
			}
		}
		
		return appUser;
	}
	
	public ArrayList<AppUserBasicBean> getPatients(String supporterId){
		AppUserBasicBean bean;
		ArrayList<AppUserBasicBean> users = new ArrayList<AppUserBasicBean>();
		ResultSet rs;
		DBConnection conn = DBConnection.getConnection();
		String query = "SELECT  U.USER_ID AS USER_ID,"
				+ "U.FIRST_NAME AS FIRST_NAME,"
				+ "U.LAST_NAME AS LAST_NAME,"
				+ "R.AUTHORIZATION_DATE AS AUTH_DATE,"
				+ "R.IS_PRIMARY"
				+ "FROM APP_USERS U, PATIENT_SUPPORTERS R WHERE"
				+ "R.USER_ID_PATIENT = U.USER_ID AND"
				+ "R.USER_ID_SUPPORTER = " +supporterId;
		rs = conn.executeQuery(query);
		try {
			while(rs.next()){
				bean = new AppUserBasicBean();
				bean.setFirstName(rs.getString("FIRST_NAME"));
				bean.setLastName(rs.getString("LAST_NAME"));
				bean.setUserId(rs.getString("USER_ID"));
				users.add(bean);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}
	
	public void addAppUser(AppUserBasicBean bean){
		
	}
	
	public boolean setPrimaryHealthSupporter(String userId, Date authDate){
		boolean result = false;
		
		
		return result;
	}
	
	public boolean setSecondaryHealthSupporter(String userId, Date authDate){
		boolean result = false;
		
		
		return result;
	}
	
	public ArrayList<String> getUserIds(){
		ArrayList<String> users = new ArrayList<String>();
		DBConnection conn = DBConnection.getConnection();
		ResultSet rs;
		String query = "Select USER_ID FROM APP_USERS";
		rs = conn.executeQuery(query);
		
		try {
			while(rs.next()){
				users.add(rs.getString("USER_ID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return users;
	}
	
	public ArrayList<String> getDiseases(){
		ArrayList<String> diseases = new ArrayList<String>();
		DBConnection conn = DBConnection.getConnection();
		ResultSet rs;
		String query = "Select DISEASE_NAME FROM DISEASES WHERE DISEASE_NAME != 'None'";
		rs = conn.executeQuery(query);
		
		try {
			while(rs.next()){
				diseases.add(rs.getString("DISEASE_NAME"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return diseases;
	}
	
}
