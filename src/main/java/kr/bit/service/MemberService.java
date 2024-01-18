package kr.bit.service;

import javax.servlet.http.HttpServletResponse;

import kr.bit.entity.Member;

public interface MemberService {
	
	public void memberInsert(Member vo);
	public Member login(Member vo);
	public String idFind(String userName, String phoneNo);
	public void modify(Member vo);
	public Member get(String userId);
	public void withdrawal(Member vo);
	//이메일발송
	public void sendEmail(Member vo, String div) throws Exception;
	//비밀번호찾기
	public void findPw(HttpServletResponse resp, Member vo) throws Exception;
	
	public Member selectMember(String email);
	public int pwUpdate_M(Member vo);
}
