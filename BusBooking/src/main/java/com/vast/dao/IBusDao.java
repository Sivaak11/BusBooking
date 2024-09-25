package com.vast.dao;

import java.util.List;

import com.vast.vo.Bus;

public interface IBusDao {
	List<Bus> findBuses(String departure, String arrival)  ;

	List<String> getAvailableSeats(String busNumber);
}
