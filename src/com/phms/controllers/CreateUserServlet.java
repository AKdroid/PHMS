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
import com.phms.beans.DiseaseBean;
import com.phms.dao.AppUserDao;

import java.util.ArrayList;
import java.util.Date;

/**
 * Servlet implementation class CreateUserServlet
 */
@WebServlet("/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		AppUserBean ubean      = new AppUserBean();
		AppUserDao  appUserDao = new AppUserDao();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		ArrayList<String> existingUserIds = new ArrayList<String>();
		String userid="", phsuser="", shsuser="";
		boolean result = false;
		try{
			existingUserIds = appUserDao.getUserIds();
			userid = request.getParameter("userId");
			if(!existingUserIds.contains(userid)){
				
				ubean.setUserId(userid);
				ubean.setPassword(request.getParameter("password"));
			
				ubean.setFirstName(request.getParameter("firstname"));
				ubean.setLastName(request.getParameter("lastname"));

				ubean.setDob(sdf.parse(request.getParameter("dob")));
				ubean.setGender( (request.getParameter("gender").equals("male") ? "M" : "F") );

				ubean.setStreet(request.getParameter("street"));
				ubean.setCity(request.getParameter("city"));
				ubean.setCountry(request.getParameter("country"));
				ubean.setState(request.getParameter("state"));
				ubean.setZipcode(request.getParameter("zipcode"));

				String[] checked = request.getParameterValues("usertype");
				ubean.setPatient(false);
				ubean.setSupporter(false);
				for(String x: checked){
					if(x.equals("patient")){
						ubean.setPatient(true);
					} else if(x.equals("supporter")) {
						ubean.setSupporter(true);
					}
				}

				DiseaseBean dbean;
				String[] diseases = request.getParameterValues("diseases");
				if(diseases == null){
					dbean = new DiseaseBean();
					dbean.setDiseaseName("None");
					dbean.setDiagnosedOn(new Date());
					if(ubean.isPatient())
						ubean.getDiseaseInfo().add(dbean);
				} else {
					for(String d: diseases){
						dbean = new DiseaseBean();
						dbean.setDiseaseName(d);
						dbean.setDiagnosedOn(new Date());
						ubean.getDiseaseInfo().add(dbean);
					}
				}
				
				if(ubean.isPatient()){
					phsuser = request.getParameter("phsId");
					String phsDate = request.getParameter("phsAd");
					if(phsuser!= null && existingUserIds.contains(phsuser) && phsDate != null){
						ubean.setPhsUserId(phsuser);
						ubean.setPhsAuthorizationDate(sdf.parse(phsDate));
					}
					shsuser = request.getParameter("shsId");
					String shsDate = request.getParameter("shsAd");
					if(shsuser!= null && existingUserIds.contains(shsuser) && shsDate != null){
						ubean.setShsUserId(shsuser);
						ubean.setShsAuthorizationDate(sdf.parse(shsDate));
					}
				}
				result = appUserDao.addUser(ubean);	
			}
			
			if(result){
				request.setAttribute("message", "User "+ userid +" created");  
				forward("index.jsp", request, response);
			} else {
				request.setAttribute("message", "Create User Failed");
				forward("views/createUser.html", request, response);
			}
			
			
			//response.getWriter().append("Served at: ").append(request.getContextPath());
		} catch (Exception e){
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void forward(String path,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		RequestDispatcher dis=request.getRequestDispatcher(path);
		dis.forward(request, response);
	}
}

