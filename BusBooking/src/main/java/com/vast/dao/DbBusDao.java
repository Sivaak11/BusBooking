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

		try {
			con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("mysql server connected ");
			String sql = "SELECT * FROM bus WHERE departure = ? AND arrival = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, departure);
			ps.setString(2, arrival);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Bus bus = new Bus(); // Create a new Bus object inside the loop
				bus.setBus_Number(rs.getString("bus_Number"));
				bus.setName(rs.getString("name"));
				bus.setDeparture(rs.getString("departure"));
				bus.setArrival(rs.getString("arrival"));
				buses.add(bus); // Add each bus to the list
			}

			if (buses.isEmpty()) {
				throw new NotFoundException("No buses found for the selected route.");
			}

			logger.info("buses retrieved from database");
		} catch (SQLException e) {
			logger.error(e.getMessage());
		} finally {
			closeConnection(con);
		}

		return buses;
	
	}
	
	@Override
	public List<String> getAvailableSeats(String busNumber) throws NotFoundException {
	    List<String> seats = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = DriverManager.getConnection(rb.getString(busNumber)); 
	        logger.debug("connected mq sql server successfully..");
	        String sql = "SELECT seat_number FROM bus_seats WHERE bus_number = ? AND is_available = true";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, busNumber);

	        rs = pstmt.executeQuery();

	        // Check if the result set has rows (seats)
	        if (!rs.isBeforeFirst()) {
	            throw new NotFoundException("No available seats found for bus number: " + busNumber);
	        }

	        // Add seat numbers to the list
	        while (rs.next()) {
	            seats.add(rs.getString("seat_number"));
	        }

	        logger.debug("Available seats for bus " + busNumber + " retrieved successfully.");
	        
	    } catch (SQLException e) {
	        logger.error("Error while retrieving available seats for bus: " + e.getMessage());
	    } finally {
	        // Close resources
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) closeConnection(conn);
	        } catch (SQLException e) {
	            logger.error("Error while closing resources: " + e.getMessage());
	        }
	    }

	    return seats;

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
