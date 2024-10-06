package com.vast.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.log4j.Logger;

import com.vast.Exception.AlreadyExistException;
import com.vast.Exception.NotFoundException;
import com.vast.vo.Bus;
import com.vast.vo.TicketDetails;
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
	public UserDetails getLoginDetails(String userid, String pwd) {
		Connection conn = null;
		UserDetails login = null;
		try {
			conn = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("connected to Mysqlserver sucessfully");
			String sql = "select * from login where user_id =? and pwd=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, pwd);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				login = new UserDetails();
				login.setUserId(rs.getString("user_id"));
				login.setUserName(rs.getString("user_name"));

			}
			logger.info("Login retrived from DataBase");

		} catch (SQLException e) {
			logger.error(e.getMessage());
		} finally {

			closeConnection(conn);
		}
		return login;
	}

	@Override
	public boolean signUp(UserDetails login) throws AlreadyExistException {
		Connection con = null;
		{
			try {
				con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
				logger.debug("mysql server connected");
				String sql = "INSERT INTO login values (?,?,?)";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setString(1, login.getUserId());
				ps.setString(2, login.getUserName());
				ps.setString(3, login.getPwd());
				int res = ps.executeUpdate();
				if (res > 0)
					return true;
			} catch (SQLException e) {
				logger.error(e.getMessage());
				if (e.getMessage().contains("Duplicate"))
					throw new AlreadyExistException("user id alreadey existed try new id");
			} finally {
				closeConnection(con);
			}
		}
		return false;
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
	public boolean addPassenger(TicketDetails passenger) throws AlreadyExistException {
		Connection con = null;
		try {
			con = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("MySQL server connected");

			String sql = "INSERT INTO ticket_details (bus_id, bus_name, departure, arrival, seat_number, passenger_name, age, mobile, address, payment_method,user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, passenger.getBusId());
			ps.setString(2, passenger.getBusName());
			ps.setString(3, passenger.getDeparture());
			ps.setString(4, passenger.getArrival());
			ps.setInt(5, passenger.getSeatNumber());
			ps.setString(6, passenger.getPassengerName());
			ps.setInt(7, passenger.getAge());
			ps.setString(8, passenger.getMobile());
			ps.setString(9, passenger.getAddress());
			ps.setString(10, passenger.getPaymentMethod());
			ps.setString(11, passenger.getUserId());
			logger.error(passenger.getUserId() + "user id odff");
			int res = ps.executeUpdate();
			if (res > 0) {
				logger.info("Passenger details added successfully");
				return true;
			}

		} catch (SQLException e) {
			logger.error(e.getMessage());
			if (e.getMessage().contains("Duplicate")) {
				throw new AlreadyExistException("Passenger details already exist.");
			}
		} finally {
			closeConnection(con);
		}
		return false;
	}

	@Override
	public Set<TicketDetails> showticket(String userId) throws NotFoundException {
		logger.info(userId + " show ticket");
		Set<TicketDetails> set = new HashSet<>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DriverManager.getConnection(rb.getString("url"), rb.getString("uname"), rb.getString("pwd"));
			logger.debug("Connected to MySQL server successfully");

			String sql = "SELECT * FROM ticket_details WHERE user_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userId); // Set the user ID parameter

			rs = ps.executeQuery(); // Execute the query after setting the parameter

			while (rs.next()) {
				TicketDetails ticket = new TicketDetails();
				ticket.setBusId(rs.getString("bus_id"));
				ticket.setBusName(rs.getString("bus_name"));
				ticket.setDeparture(rs.getString("departure"));
				ticket.setArrival(rs.getString("arrival"));
				ticket.setSeatNumber(rs.getInt("seat_number"));
				ticket.setPassengerName(rs.getString("passenger_name"));
				ticket.setAge(rs.getInt("age"));
				ticket.setMobile(rs.getString("mobile"));
				ticket.setAddress(rs.getString("address"));
				ticket.setPaymentMethod(rs.getString("payment_method"));
				ticket.setUserId(rs.getString("user_id"));

				set.add(ticket);
			}

			if (set.isEmpty()) {
				logger.warn("No tickets found for user ID: " + userId);
			} else {
				logger.info("Ticket details retrieved from the database");
			}

		} catch (SQLException e) {
			logger.error("Error retrieving ticket details: " + e.getMessage());
			throw new NotFoundException("Error retrieving ticket details"); // Consider throwing a custom exception
		} finally {
			// Close resources in reverse order of their creation
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (SQLException e) {
				logger.error("Error closing resources: " + e.getMessage());
			}
		}
		return set;
	}

}
