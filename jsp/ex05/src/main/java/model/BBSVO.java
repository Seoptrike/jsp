package model;

public class BBSVO extends UserVO { //UseVO를 상속받는다.
	private int bid;
	private String title;
	private String contents;
	private String writer;
	private String bdate;
	
	
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	
	
	@Override
	public String toString() {
		return "BBSVO [bid=" + bid + ", title=" + title + ", contents=" + contents + ", writer=" + writer + ", bdate="
				+ bdate + ", getPhone()=" + getPhone() + ", getUid()=" + getUid() + ", getUname()=" + getUname() + "]";
	}
	
	
 }
