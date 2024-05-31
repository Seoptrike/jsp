package model;

public class UserVO {
	private String uid;
	private String upass;
	private String uname;
	private String phone;
	private String raddress1;
	private String raddress2;
	
	
	
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRaddress1() {
		return raddress1;
	}
	public void setRaddress1(String raddress1) {
		this.raddress1 = raddress1;
	}
	public String getRaddress2() {
		return raddress2;
	}
	public void setRaddress2(String raddress2) {
		this.raddress2 = raddress2;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUpass() {
		return upass;
	}
	public void setUpass(String upass) {
		this.upass = upass;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	
	@Override
	public String toString() {
		return "UserVO [uid=" + uid + ", upass=" + upass + ", uname=" + uname + ", getUid()=" + getUid()
				+ ", getUpass()=" + getUpass() + ", getUname()=" + getUname() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	
}
