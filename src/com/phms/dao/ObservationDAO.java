package com.phms.dao;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.phms.beans.ObservationBean;
import com.phms.beans.RecommendationBean;
import com.phms.utils.DBConnection;

public class ObservationDAO {

	public String convertToTimestamp(Date dt){
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy hh:mm");
		return sdf.format(dt);
	}

	public boolean addObservation(String patientId, ObservationBean obean){
		boolean result = true;
		DBConnection conn = DBConnection.getConnection();

		if(obean == null)
			return false;
		String query;
		if(obean.isTempAvailable()){
			query = "INSERT INTO PATIENT_TEMPERATURES VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ obean.getTemperature()+
			", 'Active', '"+  convertToTimestamp(obean.getTempDate()) +"', CURRENT_TIMESTAMP)";
			result = result && conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"Temperature");			
		}

		if(obean.isBPAvailable()){
			query = "INSERT INTO PATIENT_BPS VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ obean.getSystolic()+","+
			obean.getDiastolic() + ", 'Active', '"+  convertToTimestamp(obean.getBpDate()) +"', CURRENT_TIMESTAMP)";
			result = result && conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"BP");
		}	

		if(obean.isO2Available()){
			query = "INSERT INTO PATIENT_OXYGEN_SATURATIONS VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ obean.getO2()+
			 ", 'Active', '"+  convertToTimestamp(obean.getO2Date()) +"', CURRENT_TIMESTAMP)";
			result = result & conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"SPO2 Level");
		}	

		if(obean.isWeightAvailable()){
			query = "INSERT INTO PATIENT_WEIGHTS VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ obean.getWeight()+
			 ", 'Active', '"+  convertToTimestamp(obean.getWeightDate()) +"', CURRENT_TIMESTAMP)";
			result = result & conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"Weight");
		}	

		if(obean.isPainAvailable()){
			query = "INSERT INTO PATIENT_PAINS VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ obean.getPain()+
			 ", 'Active', '"+  convertToTimestamp(obean.getPainDate()) +"', CURRENT_TIMESTAMP)";
			result = result && conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"Pain");
		}	

		if(obean.isMoodAvailable()){
			int mood = obean.getMood().equalsIgnoreCase("happy") ? 1 : obean.getMood().equalsIgnoreCase("neutral") ? 2 : 3;
			query = "INSERT INTO PATIENT_MOODS VALUES('"+patientId+"',OBSERVATION_SEQ.NEXTVAL,"+ mood +
			 ", 'Active', '"+  convertToTimestamp(obean.getMoodDate()) +"', CURRENT_TIMESTAMP)";
			result = result && conn.executeUpdate(query) && conn.executelowActivityClearProcedure(patientId,"Mood");
		}

		if(result){
			//conn.executeOutOfBoundsProcedure(patientId);
			if(!conn.commit())
				conn.rollback();
		} else {
			conn.rollback();
		}

		return result;
	}

	public boolean addRecommendation(String patientId, String supporterId, RecommendationBean rbean){

		boolean result = true;
		DBConnection conn = DBConnection.getConnection();

		if(rbean == null)
			return false;
		String query;
		if(rbean.isTempAvailable()){
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"Temperature",rbean.getTempMin(),
				rbean.getTempMax(), 0.0, 0.0, rbean.getTempFrequency());
		}

		if(rbean.isBPAvailable()){
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"BP",rbean.getSystolicMin(),
				rbean.getSystolicMax(), rbean.getDiastolicMin(), rbean.getDiastolicMax(), rbean.getBpFrequency());
		}	

		if(rbean.isO2Available()){
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"SPO2 Level",rbean.getO2Min(),
				rbean.getO2Max(), 0.0, 0.0, rbean.getO2Frequency());
		}	

		if(rbean.isWeightAvailable()){
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"Weight",rbean.getWeightMin(),
				rbean.getWeightMax(), 0.0, 0.0, rbean.getWeightFrequency());
		}	

		if(rbean.isPainAvailable()){
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"Pain",0.0,
				(double)rbean.getPainMax(), 0.0, 0.0, rbean.getPainFrequency());
		}	

		if(rbean.isMoodAvailable()){
			double mood = rbean.getMoodMax().equalsIgnoreCase("Happy")? 0: rbean.getMoodMax().equalsIgnoreCase("Neutral") ? 1 : 2;
			result = result && conn.executeAddRecommendationProcedure(patientId,supporterId,"Mood",0.0,
				mood, 0.0, 0.0, rbean.getMoodFrequency());
		}

		if(result){
			if(!conn.commit())
				conn.rollback();
		} else {
			conn.rollback();
		}

		return result;
	}
}