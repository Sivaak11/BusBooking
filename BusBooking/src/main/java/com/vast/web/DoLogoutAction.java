package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DoLogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {

		String viewName = "LogIn.jsp";
		HttpSession session = request.getSession(false);
		if (null != session) {
			session.invalidate();
		}
		request.setAttribute("msg", "you have logged out.");
		return viewName;

	}

}
