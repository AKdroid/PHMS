package com.phms.utils;

import java.sql.*;

import oracle.jdbc.OracleTypes;

public class DBConnection 
{
	private static DBConnection dbConnection = null;
	private Connection connection = null;
	private static String CONNECTION_STRING = "jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01";
	private static String USER = "arrao";
	private static String PASSWORD = "200107246";
	private static String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";

	private DBConnection()
	{
		try 
		{
			Class.forName(DB_DRIVER);
			connection = DriverManager.getConnection(CONNECTION_STRING, USER, PASSWORD);
		} 
		catch (Exception e) 
		{
			System.out.println("Unable to establish connection");
			e.printStackTrace();
		}
	}

	public static DBConnection getConnection()
	{
		if(dbConnection == null)
		{
			dbConnection = new DBConnection();
		}
		return dbConnection;
	}

	public ResultSet executeQuery(String query) 
	{
		Statement stmt;
		ResultSet rs = null;
		try 
		{
			stmt = connection.createStatement();
			rs = stmt.executeQuery(query);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return rs;
	}

	// close connection
	protected void finalize() throws Throwable
	{
		System.out.println("Closing Collection");
		if(connection != null)
		{
			connection.close();
		}
	}

	// transaction
	public boolean executeUpdate(String query){
		boolean result = true;
		int rs;
		try {
			connection.setAutoCommit(false);
			Statement stmt;
			stmt = connection.createStatement();
			rs = stmt.executeUpdate(query);
			
			result = rs > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result = false;
			e.printStackTrace();
		}
		return result;
	}

	public boolean commit()
	{
		boolean result = false;
		try 
		{
			connection.commit();
			result = true;
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean rollback()
	{
		boolean result = false;
		try 
		{
			connection.rollback();
			result = true;
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return result;
	}
	
	public CallableStatement executeLoginProcedure(String userId) 
	{
		CallableStatement cs = null;
		try
		{
			String procedure = "{call READ_USER(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
			cs = connection.prepareCall(procedure);
			cs.setString(1, userId);
			cs.registerOutParameter(2, OracleTypes.CURSOR);
			cs.registerOutParameter(3, OracleTypes.CURSOR);
			cs.registerOutParameter(4, OracleTypes.CURSOR);
			cs.registerOutParameter(5, OracleTypes.CURSOR);
			cs.registerOutParameter(6, Types.VARCHAR);
			cs.registerOutParameter(7, Types.VARCHAR);
			cs.registerOutParameter(8, Types.VARCHAR);
			cs.registerOutParameter(9, Types.VARCHAR);
			cs.registerOutParameter(10, Types.VARCHAR);
			cs.registerOutParameter(11, Types.VARCHAR);
			cs.registerOutParameter(12, Types.VARCHAR);
			cs.registerOutParameter(13, Types.VARCHAR);
			cs.execute();
		}
		catch(Exception e)
		{
			cs = null;
			e.printStackTrace();
		}
		return cs;
	}
	
	public void executeOutOfBoundsProcedure(String patientId){
		CallableStatement cStmt;
		try{
			cStmt = connection.prepareCall("{call generate_out_of_bounds_alert(?)}");
			cStmt.setString(1,patientId);
			cStmt.execute();
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	public boolean executeAddRecommendationProcedure(String patientId , String supporterId, String otype, Double minval1,
			Double maxval1, Double minval2, Double maxval2, Integer frequency ){
		CallableStatement cStmt;
		try{
			cStmt = connection.prepareCall("{call add_recommendation(?,?,?,?,?,?,?,?)}");
			cStmt.setString(1,patientId);
			cStmt.setString(2,supporterId);
			cStmt.setString(3,otype);
			cStmt.setDouble(4,minval1);
			cStmt.setDouble(5,maxval1);
			cStmt.setDouble(6,minval2);
			cStmt.setDouble(7,maxval2);
			cStmt.setInt(8,frequency);
			cStmt.execute();
			return true;
		} catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean executelowActivityClearProcedure(String patientId, String otype){
		CallableStatement cStmt;
		try{
			cStmt = connection.prepareCall("{call clear_low_activity_alerts(?,?)}");
			cStmt.setString(1,patientId);
			cStmt.setString(2,otype);
			cStmt.execute();
			return true;
		} catch (Exception e){
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean executeCopyDefaultRecommendations(String patientId, int diseaseId){
		CallableStatement cStmt;
		try{
			cStmt = connection.prepareCall("{call copy_default_recommendation(?,?)}");
			cStmt.setString(1,patientId);
			cStmt.setInt(2,diseaseId);
			cStmt.execute();
			return true;
		} catch (Exception e){
			e.printStackTrace();
		}
		return false;
	}
	
}