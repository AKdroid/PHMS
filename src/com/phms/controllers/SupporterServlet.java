package com.phms.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.phms.beans.AppUserBean;
import com.phms.dao.AppUserDao;

/**
 * Servlet implementation class SupporterServlet
 */
@WebServlet("/SupporterServlet")
public class SupporterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SupporterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			AppUserDao appUserDao = new AppUserDao();
			String userid = request.getParameter("userId");
			ArrayList<String> existingUserIds = new ArrayList<String>();
			existingUserIds = appUserDao.getUserIds();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String phsuser,shsuser,phsDate,shsDate;
			AppUserBean ubean = new AppUserBean();
			ubean.setUserId(userid);
			phsuser = request.getParameter("phsId");
			phsDate = request.getParameter("phsAd");
			if(phsuser!= null && existingUserIds.contains(phsuser) && phsDate != null){
				ubean.setPhsUserId(phsuser);
				ubean.setPhsAuthorizationDate(sdf.parse(phsDate));
			}
			shsuser = request.getParameter("shsId");
			shsDate = request.getParameter("shsAd");
			if(shsuser!= null && existingUserIds.contains(shsuser) && shsDate != null){
				ubean.setShsUserId(shsuser);
				ubean.setShsAuthorizationDate(sdf.parse(shsDate));
			}
			appUserDao.addHealthSupporter(ubean);
			appUserDao = new AppUserDao();
			AppUserBean appUserBean = appUserDao.fetchUserData(userid);
			request.setAttribute("appUserBean", appUserBean);
			forward("views/user.jsp", request, response);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
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
