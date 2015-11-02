package org.kdea.spring.member;

public interface  MemDAO {

	public int memregist(MemberVO mem);

	public int pwregist(MemberVO mem);
	
	public int getMnum(String id);

	public int idCheck(String id);

	public int nickCheck(String nick);
}
