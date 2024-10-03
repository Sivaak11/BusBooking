package com.vast.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.vast.Exception.NotFoundException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;
import com.vast.vo.Bus;

public class FindBuses implements Action {
	static Logger logger = Logger.getLogger("vast");

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String departure = request.getParameter("txtdeparture");
		String arrival = request.getParameter("txtarrival");
		String date = request.getParameter("txtdate");
		logger.debug("Departure: " + departure + ", Arrival: " + arrival);
		try {
			List<Bus> buses = dao.findBuses(departure, arrival, date);
			request.setAttribute("buses", buses);
		} catch (NotFoundException e) {
			request.setAttribute("res", e.getMessage());
		}

		return "availableBuses.jsp";
	}

}
