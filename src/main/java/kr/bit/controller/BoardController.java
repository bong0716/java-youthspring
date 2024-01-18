package kr.bit.controller;

import java.io.Console;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import kr.bit.entity.ApiDataDto;
import kr.bit.entity.Member;
import kr.bit.service.ApiService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SessionAttributes("mvo")
@Controller //POJO 
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	ApiService apiService;
	
	@GetMapping("/list")
	public String getList(
			@RequestParam(value = "userMessage", required = false) String query_, 
			@RequestParam(value = "perPageNum", defaultValue = "1") Integer perPageNum, 
			@SessionAttribute(value = "mvo", required = false) Member mvo, 
			Model model
			) throws Exception {
		
		String search = query_ != null ? "search" : "noSearch";
		String query = query_ != null ? URLEncoder.encode(query_, "UTF-8") : null;
		
		String srchPolyBizSecd = mvo != null ? apiService.getSrchPolyBizSecd(mvo.getAdressSi()) : "";
		
	    List<ApiDataDto> apiDataList = apiService.parseApiData(8, perPageNum, srchPolyBizSecd, query, null);
	    List<ApiDataDto> hotList = apiService.getHotList();
	    model.addAttribute("apiDataList", apiDataList);
	    model.addAttribute("perPageNum", perPageNum);
	    model.addAttribute("search", search);
	    model.addAttribute("hotList", hotList);
	    model.addAttribute("srchPolyBizSecd", srchPolyBizSecd);
	    
	    return "board/list";
	}

	@RequestMapping("/content")
	public String getContent(
			String category, 
			@RequestParam(value = "perPageNum", defaultValue = "1") Integer perPageNum, 
			@SessionAttribute(value = "mvo", required = false) Member mvo, 
			Model model
			) throws Exception{
		
		String bizTycdSel = null;
		if(category.equals("employment")) {bizTycdSel = "004001,004002";}
		else if(category.equals("finance")) {bizTycdSel = "004003001";}
		else if(category.equals("residence")) {bizTycdSel = "004003002";}
		else if(category.equals("culture")) {bizTycdSel = "004004";}
		
		String srchPolyBizSecd = mvo != null ? apiService.getSrchPolyBizSecd(mvo.getAdressSi()) : "003002001";
		
		List<ApiDataDto> apiDataList = apiService.parseApiData(8, perPageNum, srchPolyBizSecd, null, bizTycdSel);
	    model.addAttribute("apiDataList", apiDataList);
	    model.addAttribute("category", category);
	    model.addAttribute("perPageNum", perPageNum);
			
		return "board/get";
	}
	
	@GetMapping("/get")
    public String getContent2(@RequestParam("category") String category, 
    		@RequestParam(value = "userMessage", required =false) String query_, 
    		@SessionAttribute(value = "mvo", required = false) Member mvo, 
    		Model model) 
    		throws IOException, ParserConfigurationException, SAXException {
		
		String query = URLEncoder.encode(query_, "UTF-8");
		
		String bizTycdSel = null;
		if(category.equals("employment")) {bizTycdSel = "004001,004002";}
		else if(category.equals("finance")) {bizTycdSel = "004003001";}
		else if(category.equals("residence")) {bizTycdSel = "004003002";}
		else if(category.equals("culture")) {bizTycdSel = "004004";}
		
		String srchPolyBizSecd = mvo != null ? apiService.getSrchPolyBizSecd(mvo.getAdressSi()) : "003002001";
		
		List<ApiDataDto> apiDataList = apiService.parseApiData(12, 1, srchPolyBizSecd, query, bizTycdSel);
	    
		model.addAttribute("apiDataList", apiDataList);
        model.addAttribute("category", category);
        model.addAttribute("pageNum", 1);
	
        return "board/get";
    }
	
	
	@PostMapping("/insertWishlist")
    public String getWishlist(
    		@ModelAttribute ApiDataDto apiData,
            RedirectAttributes rttr){
		
		List<ApiDataDto> wishList = new ArrayList<>();

		ApiDataDto wishListDTO = new ApiDataDto();
	    wishListDTO.setUserId(apiData.getUserId());
	    wishListDTO.setBizId(apiData.getBizId());
	    wishListDTO.setPolyBizSjnm(apiData.getPolyBizSjnm());
	    wishListDTO.setPolyItcnCn(apiData.getPolyItcnCn());
	    wishListDTO.setRqutPrdCn(apiData.getRqutPrdCn());
	    wishListDTO.setAgeInfo(apiData.getAgeInfo());
	    wishListDTO.setSporCn(apiData.getSporCn());
	    wishListDTO.setCnsgNmor(apiData.getCnsgNmor());
	    wishListDTO.setRqutUrla(apiData.getRqutUrla());
	    wishListDTO.setRqutProcCn(apiData.getRqutProcCn());
	    wishListDTO.setJdgnPresCn(apiData.getJdgnPresCn());
	    wishListDTO.setEmpmSttsCn(apiData.getEmpmSttsCn());
	    wishListDTO.setAccrRqisCn(apiData.getAccrRqisCn());
	    wishListDTO.setMajrRqisCn(apiData.getMajrRqisCn());
	    wishListDTO.setSplzRlmRqisCn(apiData.getSplzRlmRqisCn());
		
		try {
		    apiService.dataInsert(wishListDTO);
		} catch (DuplicateKeyException e) {
		    // 중복 키 오류 처리 코드 작성
		    // 예를 들어, 사용자에게 중복된 데이터임을 알리고 예외를 로깅할 수 있습니다.
		    e.printStackTrace();
		}
		rttr.addFlashAttribute("wish", "success");
        return "redirect:/board/list";
    }
	
	@GetMapping("/wishList")
	public String wishList(@RequestParam("userId") String userId, Model model) {
		
		List<ApiDataDto> apiDataDto = apiService.getList(userId);
		model.addAttribute("apiData", apiDataDto);
		model.addAttribute("userId", userId);
		return "board/wishList";
	}
	
	@PostMapping("/deleteWishList")
	public String deleteWishList(@RequestParam("userId") String userId, @RequestParam("bizId") String bizId, RedirectAttributes rttr) {
		apiService.deleteList(userId, bizId);
		rttr.addAttribute("userId", userId);
		rttr.addAttribute("wish", "delete");
		return "redirect:/board/wishList2";
	}
	
	@RequestMapping("/wishList2")
	public String wishList2(@RequestParam("userId") String userId, @RequestParam("wish") String wish, Model model) {
		
		List<ApiDataDto> apiDataDto = apiService.getList(userId);
		model.addAttribute("apiData", apiDataDto);
		model.addAttribute("userId", userId);
		
		if(wish == "delete") {
			model.addAttribute("wish", wish);
		}
		return "board/wishList";
	}
}