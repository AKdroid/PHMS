package com.phms.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.AppUserBean;
import com.phms.beans.LoginBean;
import com.phms.dao.AppUserDao;
import com.phms.dao.LoginDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    public LoginServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
	        String userId = request.getParameter("userId");
	        String page = request.getParameter("page");
	        if(page == null)
	        {
		        String password = request.getParameter("password");
				System.out.println(userId);
				System.out.println(password);
				LoginBean login = new LoginBean();
				login.setLoginUser(userId);
				login.setPassword(password);
				LoginDAO loginDAO = new LoginDAO();
				String user = loginDAO.validateLogin(login);
				if(user != null)
				{
					AppUserDao appUserDao = new AppUserDao();
					AppUserBean appUserBean = appUserDao.fetchUserData(user);
					request.setAttribute("appUserBean", appUserBean);
					forward("views/user.jsp", request, response);
				}
				else
				{
					request.setAttribute("message", "Invalid User ID or Password.");
					forward("index.jsp", request, response);
				}
	        }
	        else if(page.equals("details"))
	        {
	        	AppUserDao appUserDao = new AppUserDao();
				AppUserBean appUserBean = appUserDao.fetchUserData(userId);
				request.setAttribute("appUserBean", appUserBean);
				forward("views/user.jsp", request, response);
	        }
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

	public void forward(String path,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		RequestDispatcher dis=request.getRequestDispatcher(path);
		dis.forward(request, response);
	}
}
