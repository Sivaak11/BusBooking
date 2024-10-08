package com.vast.dao;

import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.vast.Exception.AlreadyExistException;
import com.vast.Exception.NotFoundException;
import com.vast.vo.Bus;
import com.vast.vo.TicketDetails;
import com.vast.vo.UserDetails;

public interface IBusDao {
	List<Bus> findBuses(String departure, String arrival, String date) throws NotFoundException;

	boolean updateAvailableSeats(String busId, int newAvailableSeats);

	UserDetails getLoginDetails(String uname, String pwd);

	boolean addPassenger(TicketDetails passenger) throws AlreadyExistException;

	Set<TicketDetails> showticket(String userId) throws NotFoundException;

	String doLogout(HttpServletRequest request, HttpServletResponse response);

}
