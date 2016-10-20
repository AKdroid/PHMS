package com.phms.dao;

import com.phms.beans.LoginBean;
import com.phms.utils.DBConnection;

public class LoginDAO 
{
	public boolean validateLogin(LoginBean login) 
	{
		DBConnection connection = DBConnection.getConnection();
		String query = "SELECT * FROM APP_USERS WHERE USER_ID = " + login.getLoginUser() + "AND PASSWORD = " + login.getPassword();
		connection.executeQuery(query);
		return true;
	}
	
}