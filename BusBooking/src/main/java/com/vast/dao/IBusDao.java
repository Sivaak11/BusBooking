package com.vast.dao;

import java.util.List;

import com.vast.Exception.NotFoundException;
import com.vast.vo.Bus;
import com.vast.vo.UserDetails;

public interface IBusDao {
	List<Bus> findBuses(String departure, String arrival, String date) throws NotFoundException;

	boolean updateAvailableSeats(String busId, int newAvailableSeats);
	
	UserDetails getLoginDetails(String uname,String pwd);

}
