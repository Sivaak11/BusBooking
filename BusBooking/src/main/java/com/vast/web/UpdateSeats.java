package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class UpdateSeats implements Action {
static Logger logger = Logger.getLogger("vast");
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String busId = request.getParameter("busId");
		int seatsToBook = Integer.parseInt(request.getParameter("seats"));
	logger.info(seatsToBook);
		boolean res;
		res = dao.updateAvailableSeats(busId, seatsToBook);
		logger.info("value of res :"+res);
		try {
			if (res) {
				request.setAttribute("res", "seats booked for " + busId + " is succesfully");
				return "index.jsp";
			}
			request.setAttribute("res", "seats not booked");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("res", e.getMessage());
		}

		return "index.jsp";
	}
}
