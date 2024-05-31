package model;

public class PurchaseVO extends UserVO {
	private String pid;
	private String pdate;
	private int sum;
	private int status;
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "PurchaseVO [pid=" + pid + ", pdate=" + pdate + ", sum=" + sum + ", status=" + status + ", getPhone()="
				+ getPhone() + ", getRaddress1()=" + getRaddress1() + ", getRaddress2()=" + getRaddress2()
				+ ", getUid()=" + getUid() + "]";
	}
	
	
}
