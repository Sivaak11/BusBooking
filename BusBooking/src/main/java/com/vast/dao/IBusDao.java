package com.vast.dao;

import java.util.List;

import com.vast.Exception.NotFoundException;
import com.vast.vo.Bus;

public interface IBusDao {
	List<Bus> findBuses(String departure, String arrival) throws NotFoundException  ;

	List<String> getAvailableSeats(String busNumber) throws NotFoundException;
	
}
