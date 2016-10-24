package com.phms.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.PatientDetailsBean;
import com.phms.dao.AppUserDao;

@WebServlet("/ViewPatientServlet")
public class ViewPatientServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ViewPatientServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String supporterId = request.getParameter("sid");
		String patientId = request.getParameter("pid");
		AppUserDao appUserDao = new AppUserDao();
		PatientDetailsBean patientDetails = appUserDao.getPatientDetails(patientId);
		request.setAttribute("patientDetails", patientDetails);
		request.setAttribute("supporterId", supporterId);
		forward("views/patientDetails.jsp", request, response);
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
