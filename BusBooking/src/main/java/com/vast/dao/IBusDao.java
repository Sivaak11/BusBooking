package com.vast.dao;

import java.sql.SQLException;
import java.util.List;

import com.vast.Exception.NotFoundException;
import com.vast.vo.Bus;
import com.vast.vo.Seats;

public interface IBusDao {
	List<Bus> findBuses(String departure, String arrival) throws NotFoundException  ;


	List<Seats> getAvailableSeats(String busNumber) throws NotFoundException, SQLException;

}
