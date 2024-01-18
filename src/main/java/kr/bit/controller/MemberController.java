package kr.bit.controller;

import java.io.IOException;
import java.util.List;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.bit.entity.Member;
import kr.bit.service.MemberService;
import mail.MailHandler;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	JavaMailSender mailSender;
	
	
	@GetMapping("/memberRegister")
	public String register() {
		return "member/memberRegister";
	}
	
	@PostMapping("/memberRegister")
	public String register(
			Member vo
			,RedirectAttributes rttr) {
		
		memberService.memberInsert(vo);
		rttr.addFlashAttribute("result", vo.getUserName());
		return "redirect:/board/list";
		
	}
	
	@GetMapping("/loginProcess")
	public String login() {
		return "member/logIn";
	}
	
	@PostMapping("/loginProcess")
	public String login(
			Member vo
			,HttpSession session
			,RedirectAttributes rttr) {
		
		Member mvo = memberService.login(vo);
		if (mvo != null) {
			session.setAttribute("mvo", mvo); // 객체바인딩
		}
		else if (mvo == null) {
			rttr.addFlashAttribute("f", "fail");
		}
		return "redirect:/board/list";
	}

	@RequestMapping("/logoutProcess")
	public String logout(
			HttpSession session
			,RedirectAttributes rttr) {
		
		session.invalidate(); // 세션 무효화(로그아웃)
		rttr.addFlashAttribute("message", "로그아웃되었습니다.");
		return "redirect:/board/list";
	}
	
	@GetMapping("/idFind")
	public String idFind() {
		return "/member/idFind";
	}
	
	@PostMapping("/idFind")
	public String idFind(
			@RequestParam("userName") String userName
			,@RequestParam("phoneNo") String phoneNo
			,Model model) {
		
		String mvoId = memberService.idFind(userName, phoneNo);
		if(mvoId == null) 
			mvoId = "fail";
		model.addAttribute("mvoId", mvoId);
		
		return "/member/idFind";
	}
	
	@GetMapping("/passwordFind")
	public String passwordFind() {
		return "/member/passwordFind";
	}
	
	@GetMapping("/modify")
	public String modify(
			@RequestParam("userId") String userId
			,Model model) {
		
		Member vo = memberService.get(userId);
		model.addAttribute("userId", userId);
		model.addAttribute("vo", vo);
		return "/member/modify";
	}
	
	@PostMapping("/modify")
	public String modify(
			Member vo
			,RedirectAttributes rttr
			,HttpSession session) {
		
		memberService.modify(vo);
		session.invalidate(); // 세션 무효화(로그아웃)
		rttr.addFlashAttribute("success", "success");
		return "redirect:/board/list";
	}
	
	@GetMapping("/withdrawal")
	public String withdrawal() {
		return "/member/withdrawal";
	}
	
	@PostMapping("/withdrawal")
	public String withdrawal(
			Member vo
			,RedirectAttributes rttr
			,HttpSession session) {
		
		Member member = (Member) session.getAttribute("mvo");
		String sessionPass = member.getUserPassword();
		String voPass = vo.getUserPassword();
		
		if(!(sessionPass.equals(voPass))) {
			rttr.addFlashAttribute("msg",false);
			return "redirect:/member/withdrawal";
		}
		
		memberService.withdrawal(vo);
		rttr.addFlashAttribute("withdrawal", "success"); 
		session.invalidate(); // 세션 무효화(로그아웃)
		return "redirect:/board/list";
	}
	
	/* 비밀번호 찾기 */
	@GetMapping("/findpw")
	public String findPwGET() throws Exception{
		return "/member/findpw";
	}

	@PostMapping("/findpw")
	public void findPwPOST(
			@ModelAttribute Member vo
			,HttpServletResponse response) throws Exception{
		memberService.findPw(response, vo);
	}
	
	@GetMapping("/pw_find")
	public String findPw() throws Exception{
		return "/member/pw_find";
	}
	
	@GetMapping("/pw_auth")
	public String auth() throws Exception{
		return "/member/pw_auth";
	}
	
	@PostMapping("/pw_auth")
	public ModelAndView pw_auth(
			HttpSession session
			,HttpServletRequest request
			,HttpServletResponse response) throws IOException, MessagingException {
		
		String email = (String)request.getParameter("email");
		String name = (String)request.getParameter("name");
		Member vo = memberService.selectMember(email);
			
		if(vo != null) {
		Random r = new Random();
		int num = r.nextInt(999999); // 랜덤난수설정
		System.out.println(num);
		
		if (vo.getUserName().equals(name)) {
			session.setAttribute("email", vo.getEmail());

			/*
			 * String setfrom = "hjyoon0716@gmail.com"; String tomail = email; //받는사람 String
			 * title = "[청년복지모아모아] 비밀번호변경 인증 이메일 입니다"; String content =
			 * System.getProperty("line.separator") + "안녕하세요 회원님" +
			 * System.getProperty("line.separator") + "청년복지모아모아 비밀번호찾기(변경) 인증번호는 " + num +
			 * " 입니다." + System.getProperty("line.separator"); try { MimeMessage message =
			 * mailSender.createMimeMessage(); MimeMessageHelper messageHelper = new
			 * MimeMessageHelper(message, true, "utf-8");
			 * 
			 * messageHelper.setFrom(setfrom); messageHelper.setTo(tomail);
			 * messageHelper.setSubject(title); messageHelper.setText(content);
			 * 
			 * mailSender.send(message); } catch (Exception e) {
			 * System.out.println(e.getMessage()); }
			 */
			
			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("[청년복지 모아모아 인증메일입니다.]");
			sendMail.setText(
					"<h1>인증번호는</h1>" + num 
					);
			sendMail.setFrom("hjyoon0716@gmail.com", "청년복지");
			sendMail.setTo(email);
			sendMail.send();
			
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/pw_auth");
			mv.addObject("num", num);
			return mv;
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/pw_find");
			return mv;
		}
		}else {
			ModelAndView mv = new ModelAndView();
			mv.setViewName("member/pw_find");
			return mv;
		}
}
	
	@PostMapping("/pw_set")
	public String pw_set(
			@RequestParam(value="email_injeung") String email_injeung
				,@RequestParam(value = "num") String num
				,RedirectAttributes rttr) throws IOException{
			
			if(email_injeung.equals(num)) {
				return "member/pw_new";
			}
			else {
				rttr.addFlashAttribute("error", "true");
				 return "redirect:/member/pw_find";
			}
	} //이메일 인증번호 확인
	
	@PostMapping("/pw_new")
	public String pw_new(
			Member vo
			,HttpSession session) throws IOException{
		
		int result = memberService.pwUpdate_M(vo);
		if(result == 1) {
			return "member/logIn";
		}
		else {
			System.out.println("pw_update"+ result);
			return "member/pw_new";
		}
	}
}



