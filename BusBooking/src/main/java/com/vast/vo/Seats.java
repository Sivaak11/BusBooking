package com.vast.vo;

public class Seats {

	private String busNumber;
	private String seatNumber;
	private boolean isAvailable;
	
	
	public Seats() {

	}

	public Seats(String busNumber, String seatNumber, boolean isAvailable) {
		super();
		this.busNumber = busNumber;
		this.seatNumber = seatNumber;
		this.isAvailable = isAvailable;
	}

	public String getBusNumber() {
		return busNumber;
	}

	public void setBusNumber(String busNumber) {
		this.busNumber = busNumber;
	}

	public String getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

}
