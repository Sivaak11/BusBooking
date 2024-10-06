package com.vast.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.vast.Exception.AlreadyExistException;
import com.vast.dao.DbBusDao;
import com.vast.dao.IBusDao;
import com.vast.vo.TicketDetails;

public class AddTicketDetailsAction implements Action {
	static Logger logger = Logger.getLogger("vast");

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if (null == session || null == session.getAttribute("login")) {
			request.setAttribute("msg", "You're not authenticated");
			return "LogIn.jsp";
		}

		IBusDao dao = DbBusDao.getDaoInstance();
		int seats = Integer.parseInt(request.getParameter("seats"));

		for (int i = 1; i <= seats; i++) {
			TicketDetails passenger = new TicketDetails();
			// Populate passenger details from the request
			passenger.setBusId(request.getParameter("busId"));
			logger.info(request.getParameter("busId") + " bus id ossss");
			passenger.setBusName(request.getParameter("busName"));
			passenger.setDeparture(request.getParameter("departure"));
			passenger.setArrival(request.getParameter("arrival"));
			passenger.setSeatNumber(i);
			passenger.setPassengerName(request.getParameter("name_" + i));
			passenger.setAge(Integer.parseInt(request.getParameter("age_" + i)));
			passenger.setMobile(request.getParameter("mobile"));
			passenger.setAddress(request.getParameter("address"));
			passenger.setPaymentMethod(request.getParameter("payment-method"));
			passenger.setUserId(request.getParameter("userId"));
			logger.info(request.getParameter("userId")+"  getting user id");

			boolean res;

			try {
				res = dao.addPassenger(passenger);
				if (res) {
					request.setAttribute("msg", "Passenger details added successfully for passenger " + i + "!");
				} else {
					request.setAttribute("msg", "Failed to add passenger details for passenger " + i + ".");
				}
			} catch (AlreadyExistException e) {
				request.setAttribute("msg", e.getMessage());
				logger.error(e.getMessage() + " : ticket details error for passenger " + i);
			}
		}

		return "ticket.jsp"; // Redirect to a confirmation page
	}
}
