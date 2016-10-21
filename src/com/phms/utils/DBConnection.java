package com.phms.utils;

import java.sql.*;

public class DBConnection 
{
	private static DBConnection dbConnection = null;
	private Connection connection = null;
	private static String CONNECTION_STRING = "jdbc:oracle:thin:@orca.csc.ncsu.edu:1521:orcl01";
	private static String USER = "nshivra";
	private static String PASSWORD = "200111243";
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

	public String executeLoginQuery(String query) 
	{
		Statement stmt;
		ResultSet rs;
		String userType = null;
		try 
		{
			stmt = connection.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) 
			{
				userType = rs.getString("USER_TYPE");
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return userType;
	}
	
	// open connection
	
	// close connection
	
	// transaction
}