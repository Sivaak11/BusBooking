package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;
import com.vast.vo.UserDetails;

public class DoLoginAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String viewName = "Login.jsp";
		String uname = request.getParameter("txtuname");
		String pwd = request.getParameter("txtpass");
		UserDetails login = dao.getLoginDetails(uname, pwd);
		HttpSession session = request.getSession(false);
		if(null != login) {
			session.setAttribute("login", login);
			session.setMaxInactiveInterval(10 * 60);
			viewName = "index.jsp";
		}else {
			request.setAttribute("msg", "you are not authenticated, check your credentials ");
		}
		
		return viewName;
	}

}