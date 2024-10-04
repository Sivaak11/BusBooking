package com.vast.vo;

public class UserDetails {

	private String userId;
	private String userName;
	private String pwd;

	public UserDetails() {
		
	}
	public UserDetails(String userId, String userName, String pwd) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.pwd = pwd;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	

}
