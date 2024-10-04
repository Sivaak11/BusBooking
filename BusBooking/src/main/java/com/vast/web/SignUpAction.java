package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import com.vast.Exception.AlreadyExistException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;
import com.vast.vo.UserDetails;

public class SignUpAction implements Action {
	static Logger logger = Logger.getLogger("vast");
	private IBusDao dao;

	public SignUpAction() {
		this.dao = DbBusDao.getDaoInstance();
	}

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		UserDetails details = new UserDetails();
		details.setUserName(request.getParameter("txtusername"));
		details.setUserId(request.getParameter("txtuserid"));
		details.setPwd(request.getParameter("txtpwd"));
		boolean res;
		try {
			res = dao.signUp(details);
			if (res) {
				request.setAttribute("res", "User Details added successfully");
				return "bookSeat.jsp";
			}
		} catch (AlreadyExistException e) {
			e.printStackTrace();
			request.setAttribute("res", e.getMessage());
		}
		return "signUp.jsp";
	}

}
