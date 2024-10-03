package com.vast.vo;

public class Bus {
	private String bus_Number;
	private String name;
	private String departure;
	private String arrival;
	private String date;
	private String departure_time;
	private int availableSeats;

	public Bus() {
	}

	public Bus(String bus_Number, String name, String departure, String arrival, String date, String departure_time,
			int availableSeats) {
		this.bus_Number = bus_Number;
		this.name = name;
		this.departure = departure;
		this.arrival = arrival;
		this.date = date;
		this.departure_time = departure_time;
		this.availableSeats = availableSeats; // Initialize
	}

	public String getBus_Number() {
		return bus_Number;
	}

	public void setBus_Number(String bus_Number) {
		this.bus_Number = bus_Number;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public String getArrival() {
		return arrival;
	}

	public void setArrival(String arrival) {
		this.arrival = arrival;
	}

	public String getDate() {
		return date; // Getter for date
	}

	public void setDate(String date) {
		this.date = date; // Setter for date
	}

	public String getDeparture_time() {
		return departure_time; // Getter for departure_time
	}

	public void setDeparture_time(String departure_time) {
		this.departure_time = departure_time; // Setter for departure_time
	}

	public int getAvailableSeats() {
		return availableSeats;
	}

	public void setAvailableSeats(int availableSeats) {
		this.availableSeats = availableSeats;
	}
}