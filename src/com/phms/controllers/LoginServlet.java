package com.phms.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.phms.beans.LoginBean;
import com.phms.dao.LoginDAO;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			StringBuilder sb = new StringBuilder();
	        BufferedReader br = request.getReader();
	        String str = null;
	        while ((str = br.readLine()) != null) 
	        {
	            sb.append(str);
	        }
	        JSONObject jObj = new JSONObject(sb.toString());
	        String userId = jObj.getString("userId");
	        String password = jObj.getString("password");
			System.out.println(userId);
			System.out.println(password);
			LoginBean login = new LoginBean();
			login.setLoginUser(userId);
			login.setPassword(password);
			LoginDAO loginDAO = new LoginDAO();
			String userType = loginDAO.validateLogin(login);
			if(userType != null)
			{
				if(userType.equalsIgnoreCase("patient"))
				{
					response.getWriter().append("Served at: ").append(request.getContextPath());
				}
			}
			else
			{
				
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			response.getWriter().append("Error");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
