package com.phms.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.phms.beans.LoginBean;
import com.phms.utils.DBConnection;

public class LoginDAO 
{
	public String validateLogin(LoginBean login) 
	{
		DBConnection connection = DBConnection.getConnection();
		ResultSet rs;
		String user = null;
		String query = "SELECT USER_ID FROM APP_USERS WHERE USER_ID = '" 
					+ login.getLoginUser() + "' AND PASSWORD = '" + login.getPassword() 
					+ "' AND IS_ACTIVE <> 'Deleted'";
		rs = connection.executeQuery(query);
		if(rs == null){
			return user;
		}
		try {
			while(rs.next()){
				user = rs.getString("USER_ID");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;
	}
	
}