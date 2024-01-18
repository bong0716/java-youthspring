package kr.bit.service;

import java.io.IOException;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import kr.bit.entity.ApiDataDto;
import kr.bit.entity.Member;

public interface ApiService {

	public List<ApiDataDto> parseApiData(int display, int pageIndex, String srchPolyBizSecd, String query, String bizTycdSel) 
			 throws IOException, ParserConfigurationException, SAXException ;

	public void dataInsert(ApiDataDto vo);
	public List<ApiDataDto> getList(String userId);
	public void deleteList(String userId, String bizId);
	public String getSrchPolyBizSecd(String adressSi);
	public List<ApiDataDto> getHotList();
}
