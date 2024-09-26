package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vast.Exception.NotFoundException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class SeatAvailable implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String busNumber = request.getParameter("txtseats");
		try {
			request.setAttribute("findseat",dao.getAvailableSeats(busNumber));
		} catch (NotFoundException e) {
			request.setAttribute("res", e.getMessage());
		}
		
		return "availableSeats.jsp";
	}

}
