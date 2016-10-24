package com.phms.controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.RecommendationBean;
import com.phms.dao.ObservationDAO;

@WebServlet("/RecommendationServlet")
public class RecommendationServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public RecommendationServlet() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String patientId = request.getParameter("patientId");
		String supporterId = request.getParameter("supporterId");
		if(patientId != null && supporterId != null)
		{
			RecommendationBean recommendationBean = new RecommendationBean();
			if(request.getParameter("tempMin") != null && !request.getParameter("tempMin").equalsIgnoreCase("") 
					&& request.getParameter("tempMax") != null && !request.getParameter("tempMax").equalsIgnoreCase(""))
			{
				recommendationBean.setTempAvailable(true);
				recommendationBean.setTempMin(Double.parseDouble(request.getParameter("tempMin")));
				recommendationBean.setTempMax(Double.parseDouble(request.getParameter("tempMax")));
			}
			if(request.getParameter("tempFreq") != null && !request.getParameter("tempFreq").equalsIgnoreCase(""))
			{
				recommendationBean.setTempAvailable(true);
				recommendationBean.setTempFrequency(Integer.parseInt(request.getParameter("tempFreq")));
			}
			if(request.getParameter("weightMin") != null && !request.getParameter("weightMin").equalsIgnoreCase("") 
					&& request.getParameter("weightMax") != null && !request.getParameter("weightMax").equalsIgnoreCase(""))
			{
				recommendationBean.setWeightAvailable(true);
				recommendationBean.setWeightMin(Double.parseDouble(request.getParameter("weightMin")));
				recommendationBean.setWeightMax(Double.parseDouble(request.getParameter("weightMax")));
			}
			if(request.getParameter("weightFreq") != null && !request.getParameter("weightFreq").equalsIgnoreCase(""))
			{
				recommendationBean.setWeightAvailable(true);
				recommendationBean.setWeightFrequency(Integer.parseInt(request.getParameter("weightFreq")));
			}
			if(request.getParameter("sysmin") != null && !request.getParameter("sysmin").equalsIgnoreCase("") 
					&& request.getParameter("sysmax") != null && !request.getParameter("sysmax").equalsIgnoreCase("")
					&& request.getParameter("diastolicmin") != null && !request.getParameter("diastolicmin").equalsIgnoreCase("") 
					&& request.getParameter("diastolicmax") != null && !request.getParameter("diastolicmax").equalsIgnoreCase(""))
			{
				recommendationBean.setBPAvailable(true);
				recommendationBean.setSystolicMin(Double.parseDouble(request.getParameter("sysmin")));
				recommendationBean.setSystolicMax(Double.parseDouble(request.getParameter("sysmax")));
				recommendationBean.setDiastolicMin(Double.parseDouble(request.getParameter("diastolicmin")));
				recommendationBean.setDiastolicMax(Double.parseDouble(request.getParameter("diastolicmax")));
			}
			if(request.getParameter("bpFreq") != null && !request.getParameter("bpFreq").equalsIgnoreCase(""))
			{
				recommendationBean.setBPAvailable(true);
				recommendationBean.setBpFrequency(Integer.parseInt(request.getParameter("bpFreq")));
			}
			if(request.getParameter("spo2Min") != null && !request.getParameter("spo2Min").equalsIgnoreCase("") 
					&& request.getParameter("spo2Max") != null && !request.getParameter("spo2Max").equalsIgnoreCase(""))
			{
				recommendationBean.setO2Available(true);
				recommendationBean.setO2Min(Double.parseDouble(request.getParameter("spo2Min")));
				recommendationBean.setO2Max(Double.parseDouble(request.getParameter("spo2Max")));
			}
			if(request.getParameter("spo2Freq") != null && !request.getParameter("spo2Freq").equalsIgnoreCase(""))
			{
				recommendationBean.setO2Available(true);
				recommendationBean.setO2Frequency(Integer.parseInt(request.getParameter("spo2Freq")));
			}
			if(request.getParameter("pain") != null && !request.getParameter("pain").equalsIgnoreCase(""))
			{
				recommendationBean.setPainAvailable(true);
				recommendationBean.setPainMax(Integer.parseInt(request.getParameter("pain")));
			}
			if(request.getParameter("painFreq") != null && !request.getParameter("painFreq").equalsIgnoreCase(""))
			{
				recommendationBean.setPainAvailable(true);
				recommendationBean.setPainFrequency(Integer.parseInt(request.getParameter("painFreq")));
			}
			if(request.getParameter("mood") != null && !request.getParameter("mood").equalsIgnoreCase(""))
			{
				recommendationBean.setMoodAvailable(true);
				recommendationBean.setMoodMax(request.getParameter("mood"));
			}
			if(request.getParameter("moodFreq") != null && !request.getParameter("moodFreq").equalsIgnoreCase(""))
			{
				recommendationBean.setMoodAvailable(true);
				recommendationBean.setMoodFrequency(Integer.parseInt(request.getParameter("moodFreq")));
			}
			ObservationDAO obsDao = new ObservationDAO();
			boolean isSuccess = obsDao.addRecommendation(patientId, supporterId, recommendationBean);
			forward("./viewPatient?sid="+supporterId+"&pid="+patientId, request, response);
		}
		else
		{
			forward("./viewPatient?sid="+supporterId+"&pid="+patientId, request, response);
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