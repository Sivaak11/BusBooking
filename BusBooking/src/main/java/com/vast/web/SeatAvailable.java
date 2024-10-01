package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.vast.Exception.NotFoundException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class SeatAvailable implements Action {
static Logger logger = Logger.getLogger("vast");
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String busNumber = request.getParameter("busId");
		logger.debug(busNumber+"action busnumber"); 
		try {
			request.setAttribute("findseat", dao.getAvailableSeats(busNumber));
			logger.debug(busNumber);
			
		} catch (NotFoundException e) {
			request.setAttribute("res", e.getMessage());
		}
		return "availableSeats.jsp";
	}

}
