package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.vast.Exception.NotFoundException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class ViewTicketAction implements Action {
	static Logger logger = Logger.getLogger("vast");

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (null == session || null == session.getAttribute("login")) {
			request.setAttribute("msg", "your not authenticated");
			return "LogIn.jsp";
		}
		IBusDao dao = DbBusDao.getDaoInstance();
		String userId = (String) session.getAttribute("userId");
		logger.info(userId + " loggerssss ");
		try {
			request.setAttribute("ticketDeetail", dao.showticket(userId));
		} catch (NotFoundException e) {
			request.setAttribute("res", e.getMessage());

		}
		return "viewTicket.jsp";
	}

}
