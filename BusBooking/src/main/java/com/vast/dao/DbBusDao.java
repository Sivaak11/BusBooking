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
import com.vast.vo.UserDetails;

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
				bus.setAvailableSeats(rs.getInt("available_seats"));
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
		if (buses.isEmpty()) {
			logger.info("bus is emptyyyy");
		}

		return buses;
	}

	private void closeConnection(Connection conn) {
		try {
			conn.close();
			logger.debug("connection closed");
		} catch (SQLException e) {
			logger.error(e.getMessage());
		}
	}

	@Override
	public boolean updateAvailableSeats(String busId, int newAvailableSeats) {

		Connection con = null;
		try {
			con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("MySQL server connected");
			String sql = "UPDATE bus SET available_seats = available_seats-? WHERE bus_Number = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, newAvailableSeats);
			ps.setString(2, busId);
			int res = ps.executeUpdate();
			logger.debug("res value" + res);
			if (res > 0)
				return true;
			logger.info("seat modified successfully");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public UserDetails getLoginDetails(String uname, String pwd) {
		
		Connection conn = null;
		UserDetails login = null;
		try {
			conn = DriverManager.getConnection(rb.getString("url"),rb.getString("uname"),rb.getString("pwd"));
			logger.debug("connected ti my sql server successfully");
			String sql = "selected * from login where user_id =? and pwd=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, uname);
			ps.setString(1, pwd);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				
				login = new UserDetails();
				login.setUserId(rs.getString("user_id"));
				login.setUserName(rs.getString("user_name"));
				
			}
			logger.info("login retrived from Database");
			
		}catch (SQLException e) {
			logger.debug(e.getMessage());
		}finally {
			closeConnection(conn);
		}
		return login;
	}

}
