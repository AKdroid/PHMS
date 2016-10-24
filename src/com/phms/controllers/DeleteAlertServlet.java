package com.phms.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.dao.AppUserDao;

@WebServlet("/DeleteServlet")
public class DeleteAlertServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public DeleteAlertServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String alertId = request.getParameter("alertId");
		String deletedBy = request.getParameter("deletedBy");
		String reason = request.getParameter("message");
		AppUserDao appUserDao = new AppUserDao();
		appUserDao.clearAlert(alertId, deletedBy, reason);
		forward("/viewDetails?userId="+deletedBy+"&selView=alerts", request, response);
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