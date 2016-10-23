package com.phms.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.AppUserBean;
import com.phms.beans.LoginBean;
import com.phms.beans.ObservationBean;
import com.phms.dao.AppUserDao;
import com.phms.dao.LoginDAO;
import com.phms.dao.ObservationDAO;

@WebServlet("/ObservationServlet")
public class ObservationServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ObservationServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd hh:mm");
	        String userId = request.getParameter("userId");
	        ObservationBean obsBean = new ObservationBean();
	        if(request.getParameter("temp") != null && !request.getParameter("temp").trim().equals(""))
	        {
	        	obsBean.setTempAvailable(true);
	        	obsBean.setTemperature(Double.parseDouble(request.getParameter("temp")));
	        	obsBean.setTempDate(sdf.parse(request.getParameter("tempDate") + " " + request.getParameter("tempTime")));
	        }
	        if(request.getParameter("systolic") != null && !request.getParameter("systolic").trim().equals("")
	        		&& request.getParameter("diastolic") != null && !request.getParameter("diastolic").trim().equals(""))
	        {
	        	obsBean.setBPAvailable(true);
	        	obsBean.setSystolic(Double.parseDouble(request.getParameter("systolic")));
	        	obsBean.setSystolic(Double.parseDouble(request.getParameter("diastolic")));
	        	obsBean.setBpDate(sdf.parse(request.getParameter("bpDate") + " " + request.getParameter("bpTime")));
	        }
	        if(request.getParameter("weight") != null && !request.getParameter("weight").trim().equals(""))
	        {
	        	obsBean.setWeightAvailable(true);
	        	obsBean.setWeight(Double.parseDouble(request.getParameter("weight")));
	        	obsBean.setWeightDate(sdf.parse(request.getParameter("weightDate") + " " + request.getParameter("weightTime")));
	        }
	        if(request.getParameter("o2") != null && !request.getParameter("o2").trim().equals(""))
	        {
	        	obsBean.setO2Available(true);
	        	obsBean.setO2(Double.parseDouble(request.getParameter("o2")));
	        	obsBean.setO2Date(sdf.parse(request.getParameter("o2Date") + " " + request.getParameter("o2Time")));
	        }
	        if(request.getParameter("pain") != null && !request.getParameter("pain").trim().equals(""))
	        {
	        	obsBean.setPainAvailable(true);
	        	obsBean.setPain(Integer.parseInt(request.getParameter("pain")));
	        	obsBean.setPainDate(sdf.parse(request.getParameter("painDate") + " " + request.getParameter("painTime")));
	        }
	        if(request.getParameter("mood") != null && !request.getParameter("mood").trim().equals(""))
	        {
	        	obsBean.setMoodAvailable(true);
	        	obsBean.setMood(request.getParameter("mood").trim().equalsIgnoreCase("happy") ? 0 : 
	        		request.getParameter("mood").trim().equalsIgnoreCase("neutral") ? 1 : 2);
	        	obsBean.setMoodDate(sdf.parse(request.getParameter("moodDate") + " " + request.getParameter("moodTime")));
	        }
	        ObservationDAO observationDAO = new ObservationDAO();
	        boolean insertSuccess = observationDAO.insertObservation(userId, obsBean);
	        AppUserDao appUserDao = new AppUserDao();
			AppUserBean appUserBean = appUserDao.fetchUserData(userId);
			request.setAttribute("appUserBean", appUserBean);
			if(insertSuccess)
			{
				forward("views/user.jsp", request, response);
			}
			else
			{
				request.setAttribute("message", "Failed to save the observation.");
				forward("views/user.jsp", request, response);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			response.getWriter().append("Error");
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
