package kr.bit.service;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.bit.entity.Member;
import kr.bit.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberMapper memberMapper;

	@Override
	public void memberInsert(Member vo) {
		memberMapper.memberInsert(vo);
	}
	
	@Override
	public Member login(Member vo) {
		Member mvo = memberMapper.login(vo);
		
		return mvo;
	}

	@Override
	public String idFind(String userName, String phoneNo) {
		String mvoId = memberMapper.idFind(userName, phoneNo);
		
		return mvoId;
	}

	@Override
	public void modify(Member vo) {
		memberMapper.memberUpdate(vo);
		
	}

	@Override
	public Member get(String userId) {
		Member vo = memberMapper.read(userId);
		
		return vo;
	}

	@Override
	public void withdrawal(Member vo) {
		memberMapper.remove(vo);
	}
	
	//비밀번호 찾기 이메일발송
	@Override
	public void sendEmail(Member vo, String div) throws Exception {
		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "aa76892122@gmail.com";
		String hostSMTPpwd = "gPwlsdlek12!!";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "aa76892122@gmail.com";
		String fromName = "이름";
		String subject = "";
		String msg = "";

		if(div.equals("findpw")) {
			subject = "청년복지 맞춤제공 웹사이트 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getUserId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getUserPassword() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = vo.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}

	//비밀번호찾기
	@Override
	public void findPw(HttpServletResponse response, Member vo) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		Member ck = memberMapper.read(vo.getUserId());
		PrintWriter out = response.getWriter();
		// 가입된 아이디가 없으면
		if(memberMapper.idCheck(vo.getUserId()) == "null") {
			out.print("등록되지 않은 아이디입니다.");
			out.close();
		}
		// 가입된 이메일이 아니면
		else if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("등록되지 않은 이메일입니다.");
			out.close();
		}else {
			// 임시 비밀번호 생성
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo.setUserPassword(pw);
			// 비밀번호 변경
			memberMapper.updatePw(vo);
			// 비밀번호 변경 메일 발송
			sendEmail(vo, "findpw");

			out.print("이메일로 임시 비밀번호를 발송하였습니다.");
			out.close();
		}
	}

	@Override
	public Member selectMember(String email) {
		Member vo = memberMapper.selectMember(email);
		
		return vo;
	}

	@Override
	public int pwUpdate_M(Member vo) {
		memberMapper.pwUpdate_M(vo);
		int result = 1;
		
		return result;
	}


}
