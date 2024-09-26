package com.vast.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.vast.Exception.NotFoundException;
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
	public List<Bus> findBuses(String departure, String arrival) throws NotFoundException {
		List<Bus> buses = new ArrayList<Bus>();
		Connection con = null;
		Bus bus = null;

		try {
			con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("mysql server connected ");
			String sql = "select * from bus where  departure= ? and arrival = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, departure);
			ps.setString(2, arrival);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				bus = new Bus();
				bus.setBus_Number(rs.getString("bus_Number"));
				bus.setName(rs.getString("name"));
				bus.setDeparture(rs.getString("departure"));
				bus.setArrival(rs.getString("arrival"));
			}
			buses.add(bus);
			logger.info("bus retrived from database");

		} catch (SQLException e) {

			logger.error(e.getMessage());
		} finally {
			closeConnection(con);
		}
		if (buses.isEmpty()) {
			throw new NotFoundException("no bus are found ");
		}
		return buses;
	}

	@Override
	public List<String> getAvailableSeats(String busNumber) {

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
