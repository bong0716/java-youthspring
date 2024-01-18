package kr.bit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.bit.entity.Member;

public interface MemberMapper {
	 public List<Member> memberList();
	 public int memberInsert(Member vo);
	 public void memberUpdate(Member vo);
	 public Member login(Member vo); // SQL
	 public String idFind(@Param("userName") String userName, @Param("phoneNo") String phoneNo);
	 public Member read(String userId);
	 public void remove(Member vo);
	 public String idCheck(String userId);
	 public void updatePw(Member vo) throws Exception;
	 public Member selectMember(String email);
     public void pwUpdate_M(Member vo);

}
