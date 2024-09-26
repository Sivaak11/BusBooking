package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vast.Exception.NotFoundException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class FindBuses implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String departure = request.getParameter("txtdeparture");
		String arrival = request.getParameter("txtarrival");
		try {
			request.setAttribute("findbus", dao.findBuses(departure, arrival));
		} catch (NotFoundException e) {
			request.setAttribute("res", e.getMessage());
		}
		return "availableBuses.jsp";
	}

}
