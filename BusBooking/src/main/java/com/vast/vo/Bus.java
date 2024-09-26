package com.vast.vo;

public class Bus {
	private String bus_Number;
	private String name;
	private String departure;
	private String arrival;

	public Bus() {

	}

	public Bus(String bus_Number, String name, String departure, String arrival) {
		super();
		this.bus_Number = bus_Number;
		this.name = name;
		this.departure = departure;
		this.arrival = arrival;
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

}
