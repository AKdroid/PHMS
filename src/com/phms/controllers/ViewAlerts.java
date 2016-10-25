package com.phms.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.AppUserBean;
import com.phms.dao.AppUserDao;

@WebServlet("/ViewAlerts")
public class ViewAlerts extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ViewAlerts() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String userId = request.getParameter("userId");
		AppUserDao appUserDao = new AppUserDao();
		AppUserBean appUserBean = appUserDao.fetchUserData(userId);
		request.setAttribute("appUserBean", appUserBean);
		forward("views/alerts.jsp", request, response);
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