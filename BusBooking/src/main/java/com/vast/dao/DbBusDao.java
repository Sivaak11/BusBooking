package com.vast.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.vast.vo.Bus;

public class DbBusDao implements IBusDao {

	static Logger logger = Logger.getLogger("vast");
	static ResourceBundle rb = ResourceBundle.getBundle("bus");
	private static IBusDao dao = new DbBusDao();

	private DbBusDao() {

	}

	static {

		try {
			Class.forName(rb.getString("driver"));
			logger.debug("driver loaded succesfully");
		} catch (ClassNotFoundException e) {
			logger.error(e.getMessage());
		}
	}

	public static IBusDao getDaoInstance() {
		return dao;

	}

	@Override
	public List<Bus> findBuses(String departure, String arrival) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> getAvailableSeats(String busNumber) {
		// TODO Auto-generated method stub
		return null;
	}

	private void closeConnection(Connection conn) {
		try {
			conn.close();
			logger.debug("connection closed");
		} catch (SQLException e) {
			logger.error(e.getMessage());
		}
	}

}
