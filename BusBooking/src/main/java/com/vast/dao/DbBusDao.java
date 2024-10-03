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
import com.vast.vo.Seats;

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
	public List<Bus> findBuses(String departure, String arrival, String date) throws NotFoundException {
	    List<Bus> buses = new ArrayList<>();
	    Connection con = null;

	    try {
	        con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
	        logger.debug("MySQL server connected");
	        
	        
	        String sql = "SELECT * FROM bus WHERE departure = ? AND arrival = ? AND date = ?";
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, departure);
	        ps.setString(2, arrival);
	        ps.setString(3, date);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Bus bus = new Bus();
	            bus.setBus_Number(rs.getString("bus_Number"));
	            bus.setName(rs.getString("name"));
	            bus.setDeparture(rs.getString("departure"));
	            bus.setArrival(rs.getString("arrival"));
	            bus.setDate(rs.getString("date")); 
	            bus.setDeparture_time(rs.getString("departure_time"));
	            buses.add(bus);
	        }

	        if (buses.isEmpty()) {
	            throw new NotFoundException("No buses found for the selected route.");
	        }

	        logger.info("Buses retrieved from database");
	    } catch (SQLException e) {
	        logger.error(e.getMessage());
	    } finally {
	        closeConnection(con);
	    }

	    return buses;
	}


	@Override
	public List<Seats> getAvailableSeats(String busNumber) throws NotFoundException {
		List<Seats> availableSeats = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("connected mq sql server successfully..");
			String sql = "SELECT * FROM seats WHERE bus_Number = ? AND is_available = 1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, busNumber);
			logger.debug(busNumber + " : busnumber");
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Seats seat = new Seats();
				seat.setBusNumber(rs.getString("bus_Number"));
				seat.setSeatNumber(rs.getString("seat_number"));
				seat.setAvailable(rs.getBoolean("is_available"));
				availableSeats.add(seat);

			}
			if (availableSeats.isEmpty()) {
				throw new NotFoundException("No available seats found for bus number: " + busNumber);
			}
		} catch (SQLException e) {
			logger.error("SQL Error: " + e.getMessage());
			throw new NotFoundException("Error fetching available seats", e);
		} finally {
			closeConnection(con);
		}
		return availableSeats;
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
