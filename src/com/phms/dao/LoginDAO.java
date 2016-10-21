package com.phms.dao;

import com.phms.beans.LoginBean;
import com.phms.utils.DBConnection;

public class LoginDAO 
{
	public String validateLogin(LoginBean login) 
	{
		DBConnection connection = DBConnection.getConnection();
		String query = "SELECT USER_TYPE FROM APP_USERS WHERE USER_ID = '" 
					+ login.getLoginUser() + "' AND PASSWORD = '" + login.getPassword() 
					+ "' AND IS_ACTIVE = 'Active'";
		String userType = connection.executeLoginQuery(query);
		return userType;
	}
	
}