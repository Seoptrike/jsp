package model;

public class CommentVO extends UserVO{
	private	int cid;
	private int bid;
	private String writer;
	private String contents;
	private String cdate;
	
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	
	@Override
	public String toString() {
		return "CommentVO [cid=" + cid + ", bid=" + bid + ", writer=" + writer + ", contents=" + contents + ", cdate="
				+ cdate + ", getPhone()=" + getPhone() + ", getUname()=" + getUname() + "]";
	}
	
	
}
