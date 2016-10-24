package com.phms.dao;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.phms.beans.AlertBean;
import com.phms.beans.AppUserBasicBean;
import com.phms.beans.AppUserBean;
import com.phms.beans.DiseaseBean;
import com.phms.beans.ObservationBean;
import com.phms.beans.PatientDetailsBean;
import com.phms.beans.RecommendationBean;
import com.phms.utils.DBConnection;

public class AppUserDao {

	public AppUserBean fetchUserData(String userId){
		AppUserBean appUser = new AppUserBean();
		DBConnection dbConnection = DBConnection.getConnection();
		CallableStatement cs = dbConnection.executeLoginProcedure(userId);
		if(cs != null)
		{
			try
			{
				ResultSet rs = (ResultSet)cs.getObject(2);
				while(rs != null && rs.next())
				{
					appUser.setUserId(userId);
					appUser.setFirstName(rs.getString("FIRST_NAME"));
					appUser.setLastName(rs.getString("LAST_NAME"));

					appUser.setPatient(!rs.getString("USER_TYPE").equals("Supporter"));
					appUser.setSupporter(!rs.getString("USER_TYPE").equals("Patient"));

					appUser.setStreet(rs.getString("STREET"));
					appUser.setCity(rs.getString("CITY"));
					appUser.setState(rs.getString("STATE"));
					appUser.setCountry(rs.getString("COUNTRY"));
					appUser.setZipcode(rs.getString("ZIP_CODE"));

					appUser.setDob(rs.getDate("DOB"));
					appUser.setGender(rs.getString("GENDER"));
				}
				rs = (ResultSet)cs.getObject(3);
				while(rs != null && rs.next())
				{
					DiseaseBean dbean = new DiseaseBean();
					dbean.setDiseaseName(rs.getString("DISEASE_NAME"));
					dbean.setDiagnosedOn(rs.getDate("DIAGNOSED_ON"));
					appUser.getDiseaseInfo().add(dbean);
				}
				rs = (ResultSet)cs.getObject(4);
				while(rs != null && rs.next())
				{
					AlertBean alertBean = new AlertBean();
					alertBean.setAlertId(rs.getString("ALERT_ID"));
					alertBean.setPatientId(userId);
					alertBean.setAlert(rs.getString("ALERT_MESSAGE"));
					alertBean.setAlertType(rs.getInt("ALERT_TYPE"));
					alertBean.setObsType(rs.getString("OBSERVATION_TYPE"));
					appUser.getAlerts().add(alertBean);
				}
				rs = (ResultSet)cs.getObject(5);
				while(rs != null && rs.next())
				{
					AlertBean alertBean = new AlertBean();
					alertBean.setAlertId(rs.getString("ALERT_ID"));
					alertBean.setPatientId(rs.getString("PATIENT_ID"));
					alertBean.setAlert(rs.getString("ALERT_MESSAGE"));
					alertBean.setAlertType(rs.getInt("ALERT_TYPE"));
					alertBean.setObsType(rs.getString("OBSERVATION_TYPE"));
					appUser.getPatientAlerts().add(alertBean);
				}
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
				if(cs.getString(6) != null)
					appUser.setPhsUserId(cs.getString(6));
				if(cs.getString(7) != null && cs.getString(8) != null)
					appUser.setPhsUserIdName(cs.getString(7)+" " + cs.getString(8));
				if(cs.getString(9) != null  && !cs.getString(9).trim().equalsIgnoreCase(""))
					appUser.setPhsAuthorizationDate(sdf.parse(cs.getString(9)));
				if(cs.getString(10) != null)
					appUser.setShsUserId(cs.getString(10));
				if(cs.getString(11) != null && cs.getString(12) != null)
					appUser.setShsUserIdName(cs.getString(11)+ " " + cs.getString(12));
				if(cs.getString(13) != null && !cs.getString(13).trim().equalsIgnoreCase(""))
					appUser.setShsAuthorizationDate(sdf.parse(cs.getString(9)));
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		return appUser;
	}
	/*public AppUserBean fetchUserData(String userId){
		AppUserBean appUser = new AppUserBean();
		DBConnection dbConnection = DBConnection.getConnection();
		String query = "SELECT * FROM APP_USERS WHERE USER_ID = '" + userId +"'";
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

					appUser.setPatient(!rs.getString("USER_TYPE").equals("Supporter"));
					appUser.setSupporter(!rs.getString("USER_TYPE").equals("Patient"));

					appUser.setStreet(rs.getString("STREET"));
					appUser.setCity(rs.getString("CITY"));
					appUser.setState(rs.getString("STATE"));
					appUser.setCountry(rs.getString("COUNTRY"));
					appUser.setZipcode(rs.getString("ZIP_CODE"));

					appUser.setDob(rs.getDate("DOB"));
					appUser.setGender(rs.getString("GENDER"));

					query = "SELECT D.DISEASE_NAME AS DISEASE_NAME, "
							+ "R.DIAGNOSED_ON AS DIAGNOSED_ON, "
							+ "R.CURED_ON AS CURED_ON, "
							+ "R.STATUS AS STATUS FROM PATIENT_DISEASES R, DISEASES D "+
							"WHERE D.DISEASE_ID = R.DISEASE_ID AND R.USER_ID = '" + userId + "'";
					rs = dbConnection.executeQuery(query);
					while(rs.next()){
						DiseaseBean dbean = new DiseaseBean();
						dbean.setDiseaseName(rs.getString("DISEASE_NAME"));
						dbean.setDiagnosedOn(rs.getDate("DIAGNOSED_ON"));
						dbean.setCuredOn(rs.getDate("CURED_ON"));
						dbean.setStatus(rs.getInt("STATUS"));
						appUser.getDiseaseInfo().add(dbean);
					}
					query = "SELECT  U.USER_ID AS USER_ID, "
							+ "U.FIRST_NAME AS FIRST_NAME, "
							+ "U.LAST_NAME AS LAST_NAME, "
							+ "R.AUTHORIZATION_DATE AS AUTH_DATE, "
							+ "R.IS_PRIMARY "
							+ "FROM APP_USERS U, PATIENT_SUPPORTERS R WHERE "
							+ "R.USER_ID_SUPPORTER = U.USER_ID AND "
							+ "R.USER_ID_PATIENT = '" + userId + "'";
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
	}*/

	public ArrayList<AppUserBasicBean> getPatients(String supporterId){
		AppUserBasicBean bean;
		ArrayList<AppUserBasicBean> users = new ArrayList<AppUserBasicBean>();
		ResultSet rs;
		DBConnection conn = DBConnection.getConnection();
		String query = "SELECT  U.USER_ID AS USER_ID, "
				+ "U.FIRST_NAME AS FIRST_NAME, "
				+ "U.LAST_NAME AS LAST_NAME, "
				+ "R.AUTHORIZATION_DATE AS AUTH_DATE, "
				+ "R.IS_PRIMARY "
				+ "FROM APP_USERS U, PATIENT_SUPPORTERS R WHERE "
				+ "R.USER_ID_PATIENT = U.USER_ID AND "
				+ "R.USER_ID_SUPPORTER = '" + supporterId + "'";
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

	public PatientDetailsBean getPatientDetails(String patientId){
		
		PatientDetailsBean pbean  = new PatientDetailsBean();
		String query = "SELECT * FROM APP_USERS WHERE USER_ID = '" + patientId +"'";
		ResultSet rs = null;
		DBConnection conn = DBConnection.getConnection();
		try{
			rs = conn.executeQuery(query);
			while(rs != null && rs.next()){
				pbean.setPatientId(rs.getString("USER_ID"));
				pbean.setFirstName(rs.getString("FIRST_NAME"));
				pbean.setLastName(rs.getString("LAST_NAME"));
				pbean.setObservation(getLatestObservation(patientId));
				pbean.setRecommendation(getRecommendation(patientId));
			}
		}
			
		catch (Exception e)
		{
			pbean = null;
			e.printStackTrace();
		}
		return pbean;

	}

	public ObservationBean getLatestObservation(String patientId){
		ObservationBean obean = new ObservationBean();
		ResultSet rs = null;
		DBConnection conn = DBConnection.getConnection();

		String query = "SELECT * FROM PATIENT_WEIGHTS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_WEIGHTS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setObservationAvailable(true);
				obean.setWeightAvailable(true);
				obean.setWeight(rs.getDouble("VALUE"));
				obean.setWeightDate(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setWeightAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM PATIENT_TEMPERATURES WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_TEMPERATURES WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setObservationAvailable(true);
				obean.setTempAvailable(true);
				obean.setTemperature(rs.getDouble("VALUE"));
				obean.setTempDate(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setTempAvailable(false);

			}
		}
		catch (Exception e){
			
			e.printStackTrace();
		}

		query = "SELECT * FROM PATIENT_BPS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_BPS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setObservationAvailable(true);
				obean.setBPAvailable(true);
				obean.setSystolic(rs.getDouble("SYSTOLIC_VALUE"));
				obean.setDiastolic(rs.getDouble("DIASTOLIC_VALUE"));
				obean.setBpDate(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setBPAvailable(false);
			}
		}
		catch (Exception e){

			e.printStackTrace();
		}

		query = "SELECT * FROM PATIENT_PAINS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_PAINS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setObservationAvailable(true);
				obean.setPainAvailable(true);
				obean.setPain(rs.getInt("VALUE"));
				obean.setPainDate(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setPainAvailable(false);

			}
		}
		catch (Exception e){

			e.printStackTrace();
		}

		String[] moods ={ "Happy","Neutral","Sad"};
		query = "SELECT * FROM PATIENT_MOODS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_MOODS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setObservationAvailable(true);
				obean.setMoodAvailable(true);
				obean.setMood(moods[rs.getInt("MOOD_VALUE")]);
				obean.setMoodDate(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setMoodAvailable(false);

			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active' AND OBSERVATION_TIME = (SELECT MAX(OBSERVATION_TIME) FROM PATIENT_OXYGEN_SATURATIONS WHERE USER_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active') " ;
		
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				obean.setO2Available(true);
				obean.setObservationAvailable(true);
				obean.setO2(rs.getDouble("SPO2_LEVEL_VALUE"));
				obean.setO2Date(rs.getTimestamp("OBSERVATION_TIME"));
			} else {
				obean.setO2Available(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return obean;
	}

	public RecommendationBean getRecommendation(String patientId){
		RecommendationBean rbean = new RecommendationBean();
		ResultSet rs = null;
		DBConnection conn = DBConnection.getConnection();

		String query = "SELECT * FROM RECOMMENDATION_WEIGHTS WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setWeightAvailable(true);
				rbean.setWeightMin(rs.getDouble("MIN_VALUE"));
	            rbean.setWeightMax(rs.getDouble("MAX_VALUE"));  
				rbean.setWeightFrequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setWeightAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM RECOMMENDATION_TEMPERATURES WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setTempAvailable(true);
				rbean.setTempMin(rs.getDouble("MIN_VALUE"));
	            rbean.setTempMax(rs.getDouble("MAX_VALUE"));  
				rbean.setTempFrequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setTempAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM RECOMMENDATION_BPS WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setBPAvailable(true);
				rbean.setSystolicMin(rs.getDouble("SYSTOLIC_MIN_VALUE"));
	            rbean.setSystolicMax(rs.getDouble("SYSTOLIC_MAX_VALUE"));
	            rbean.setDiastolicMin(rs.getDouble("DIASTOLIC_MIN_VALUE"));
	            rbean.setDiastolicMax(rs.getDouble("DIASTOLIC_MAX_VALUE"));  
				rbean.setBpFrequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setBPAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM RECOMMENDATION_PAINS WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setPainAvailable(true);
	            rbean.setPainMax(rs.getInt("PAIN_VALUE"));  
				rbean.setPainFrequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setPainAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		String[] moods ={ "Happy","Neutral","Sad"};
		query = "SELECT * FROM RECOMMENDATION_MOODS WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setMoodAvailable(true);
				rbean.setMoodMax(moods[rs.getInt("MOOD_VALUE")]);
				rbean.setMoodFrequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setMoodAvailable(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}

		query = "SELECT * FROM RECOMMENDATION_O2_SAT WHERE PATIENT_ID = '" + patientId +
		"' AND IS_ACTIVE = 'Active'" ;
		
		try{
			rs = conn.executeQuery(query);
			if (rs != null && rs.next()){
				rbean.setO2Available(true);
				rbean.setO2Min(rs.getDouble("SPO2_MIN_VALUE"));
				rbean.setO2Max(rs.getDouble("SPO2_MAX_VALUE"));
				rbean.setO2Frequency(rs.getInt("FREQUENCY"));
			} else {
				rbean.setO2Available(false);
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return rbean;

	}

	public boolean clearAlert(String alertId, String deletedBy, String reason) 
	{
		DBConnection conn = DBConnection.getConnection();
		String query;
		boolean result = false;
		query = "UPDATE ALERTS SET STATUS=1, CLEARED_TIME = CURRENT_TIMESTAMP, CLEARED_BY='"+deletedBy+"',CLEARED_REASON='"+
		reason+"' WHERE ALERT_ID = "+alertId;
		result = conn.executeUpdate(query);
		conn.commit();
		return result;
	}
	
	public String getUserType(boolean isPatient, boolean isSupporter){
		String result;
		if(isPatient) 
			result = "Patient";
		else
			result = "Supporter";
		if(isPatient && isSupporter)
			result = "Both";
		return result;
	}

	public int getDiseaseId(String diseaseName){
		DBConnection conn = DBConnection.getConnection();
		ResultSet rs;
		String query;
		int result=-1;
		query = "SELECT DISEASE_ID FROM DISEASES WHERE DISEASE_NAME =  '"+diseaseName +"'";
		rs = conn.executeQuery(query);
		try{
			while(rs!=null && rs.next()){
				result = rs.getInt("DISEASE_ID");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String convertDateToString(Date dt){
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
		return sdf.format(dt);
	}
	
	public boolean addUser(AppUserBean ubean){

		boolean result = true;
		String query;
		DBConnection conn = DBConnection.getConnection();
		boolean is_sick=false;
		boolean has_supporter=false;

		query = "INSERT INTO APP_USERS VALUES ('"
		          + ubean.getUserId() +"','"
		          + ubean.getPassword()+"','"
		          + ubean.getFirstName()+"','"
		          + ubean.getLastName()+"',"
		          + "CURRENT_TIMESTAMP , CURRENT_TIMESTAMP,'"
		          + getUserType(ubean.isPatient(),ubean.isSupporter()) +"','"
		          + convertDateToString(ubean.getDob()) + "','"
		          + ubean.getGender() +"','"
		          + ubean.getStreet() + "','"
		          + ubean.getCity() + "','"
		          + ubean.getState() + "','"
		          + ubean.getCountry() + "','"
		          + ubean.getZipcode() + "','Active')";

		result = conn.executeUpdate(query);
		if(result){
			for(DiseaseBean dbean : ubean.getDiseaseInfo()){
				int diseaseId = getDiseaseId(dbean.getDiseaseName());
				if(!is_sick)
					is_sick = diseaseId > 1;
				query = "INSERT INTO PATIENT_DISEASES VALUES ("
					+ubean.getUserId()+"',"
					+diseaseId+",'"
					+dbean.getDiagnosedOn()+"',NULL,0,2)";
				result = conn.executeUpdate(query);
				if(result){
					result = result && conn.executeCopyDefaultRecommendations(ubean.getUserId(),diseaseId);
				}
			}
		}

		if(ubean.getPhsUserId()!=null){
			query = "INSERT INTO PATIENT_SUPPORTERS VALUES ('"
				+ ubean.getUserId()+"','"
				+ ubean.getPhsUserId()+"','"
				+ convertDateToString(ubean.getPhsAuthorizationDate())+"',1)";
			result = result & conn.executeUpdate(query);
			if(result)
				has_supporter = true;
			if(ubean.getShsUserId()!=null){
				query = "INSERT INTO PATIENT_SUPPORTERS VALUES ('"
				+ ubean.getUserId()+"','"
				+ ubean.getShsUserId()+"','"
				+ convertDateToString(ubean.getShsAuthorizationDate())+"',0)";
				result = result & conn.executeUpdate(query);
			}
		}
		if(!is_sick && ubean.isPatient() && !has_supporter){
			query = "UPDATE APP_USERS SET IS_ACTIVE = 'Inactive' WHERE USER_ID = '"+ubean.getUserId()+"'"; 
			result = result & conn.executeUpdate(query);
		}
		if(result && !conn.commit()){
			result = conn.rollback();
		}
		return result;
	}
	
}
