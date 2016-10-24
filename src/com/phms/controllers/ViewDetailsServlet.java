package com.phms.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.AlertBean;
import com.phms.beans.AppUserBasicBean;
import com.phms.beans.AppUserBean;
import com.phms.dao.AppUserDao;
import com.phms.dao.ObservationDAO;

@WebServlet("/ViewDetailsServlet")
public class ViewDetailsServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ViewDetailsServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String userId = request.getParameter("userId");
        AppUserDao appUserDao = new AppUserDao();
		AppUserBean appUserBean = appUserDao.fetchUserData(userId);
		request.setAttribute("appUserBean", appUserBean);
		request.setAttribute("hspage", "hspage");
		if(request.getParameter("selView") != null)
		{
			String view = request.getParameter("selView");
			if(view.equalsIgnoreCase("patients"))
			{
				List<AppUserBasicBean> patients = appUserDao.getPatients(userId);
				request.setAttribute("patients", patients);
			}
			else if(view.equalsIgnoreCase("alerts"))
			{
				List<AlertBean> alerts = appUserBean.getPatientAlerts();
				request.setAttribute("alerts", alerts);
			}
			forward("views/user.jsp", request, response);
		}
		else
		{
			request.setAttribute("viewMessage", "Select a view.");
			forward("views/user.jsp", request, response);
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