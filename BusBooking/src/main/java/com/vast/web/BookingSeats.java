package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;

public class BookingSeats implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		IBusDao dao = DbBusDao.getDaoInstance();
		String busId = request.getParameter("busId");
		int seatsToBook = Integer.parseInt(request.getParameter("seats"));
		boolean res;
		res = dao.updateAvailableSeats(busId, seatsToBook);
		try {
			if (res) {
				request.setAttribute("res", "seats booked for " + busId + " is succesfully");
				return "ticket.jsp";
			}
			request.setAttribute("res", "seats not booked");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("res", e.getMessage());
		}

		return "bookSeat.jsp";
	}
}
