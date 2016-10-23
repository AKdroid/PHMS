package com.phms.utils;

import java.sql.*;

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
			connection.commit();
			result = rs > 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
}