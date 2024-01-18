package kr.bit.service;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import kr.bit.entity.ApiDataDto;
import kr.bit.entity.Member;
import kr.bit.mapper.ApiMapper;

@Service
public class ApiServiceImpl implements ApiService{
	
	@Autowired
	ApiMapper apiMapper;

	 @Override 
	 public List<ApiDataDto> parseApiData(int display, int pageIndex,
	 String srchPolyBizSecd, String query, String bizTycdSel) throws IOException,
	 ParserConfigurationException, SAXException { 
		 String apiUrl = "https://www.youthcenter.go.kr/opi/empList.do"; 
		 String openApiVlak = "5d13949d9bda5d91a55da85b"; 
		 String urlStr = apiUrl + "?openApiVlak=" + openApiVlak + "&display=" + display + "&pageIndex=" + pageIndex;
	 
	 if (query != null) { urlStr += "&query=" + query; }
	 
	 if (bizTycdSel != null) { urlStr += "&bizTycdSel=" + bizTycdSel; }

	 if (srchPolyBizSecd != null) { urlStr += "&srchPolyBizSecd=" + srchPolyBizSecd; }
	 
	 URL url = new URL(urlStr); 
	 HttpURLConnection connection = (HttpURLConnection)url.openConnection(); 
	 connection.setRequestMethod("GET");
	 connection.setRequestProperty("Content-Type", "application/json");
	  
	 InputStream responseStream = connection.getInputStream();
	  
	 DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	 DocumentBuilder builder = factory.newDocumentBuilder(); 
	 InputSource is = new InputSource(responseStream); Document doc = builder.parse(is);
	  
	 NodeList nodeList = doc.getElementsByTagName("emp");
	  
	 List<ApiDataDto> apiDataList = new ArrayList<>();
	  
	 for (int i = 0; i < nodeList.getLength(); i++) { 
		 Node node = nodeList.item(i); 
		 if (node.getNodeType() == Node.ELEMENT_NODE) { 
 		 Element element = (Element) node; 
 		 ApiDataDto apiData = new ApiDataDto();
		 apiData.setPolyItcnCn(element.getElementsByTagName("polyItcnCn").item(0).
				 getTextContent());
		 apiData.setPolyBizSjnm(element.getElementsByTagName("polyBizSjnm").item(0).
				 getTextContent());
		 apiData.setRqutPrdCn(element.getElementsByTagName("rqutPrdCn").item(0).
				 getTextContent());
		 apiData.setRqutUrla(element.getElementsByTagName("rqutUrla").item(0).
				 getTextContent());
		 apiData.setCnsgNmor(element.getElementsByTagName("cnsgNmor").item(0).
				 getTextContent());
		 apiData.setAgeInfo(element.getElementsByTagName("ageInfo").item(0).
				 getTextContent()); 
		 apiData.setSporCn(element.getElementsByTagName("sporCn").item(0).
				 getTextContent()); 
		 apiData.setJdgnPresCn(element.getElementsByTagName("jdgnPresCn").item(0).
				 getTextContent()); 
		 apiData.setEmpmSttsCn(element.getElementsByTagName("empmSttsCn").item(0).
				 getTextContent());
		 apiData.setAccrRqisCn(element.getElementsByTagName("accrRqisCn").item(0).
				 getTextContent()); 
		 apiData.setMajrRqisCn(element.getElementsByTagName("majrRqisCn").item(0).
				 getTextContent()); 
		 apiData.setSplzRlmRqisCn(element.getElementsByTagName("splzRlmRqisCn").item(0).
				 getTextContent()); 
		 apiData.setRqutProcCn(element.getElementsByTagName("rqutProcCn").item(0).
				 getTextContent()); 
		 apiData.setBizId(element.getElementsByTagName("bizId").item(0).
				 getTextContent()); 
		 
		 apiDataList.add(apiData); 
	 	} 
	 }
	 return apiDataList; 
	 }

	 
	@Override
	public void dataInsert(ApiDataDto vo) {
		apiMapper.dataInsert(vo);
		
	}


	@Override
	public List<ApiDataDto> getList(String userId) {
		List<ApiDataDto> apiData = apiMapper.getList(userId);
		return apiData;
	}


	@Override
	public void deleteList(String userId, String bizId) {
		apiMapper.dataDelete(userId, bizId);
	}
	
	@Override
	public String getSrchPolyBizSecd(String adressSi) {
	    String srchPolyBizSecd = "";
	    
	        switch (adressSi) {
	            case "서울특별시":
	                srchPolyBizSecd = "003002001";
	                break;
	            case "부산광역시":
	                srchPolyBizSecd = "003002002";
	                break;
	            case "대구광역시":
	                srchPolyBizSecd = "003002003";
	                break;
	            case "인천광역시":
	                srchPolyBizSecd = "003002004";
	                break;
	            case "광주광역시":
	                srchPolyBizSecd = "003002005";
	                break;
	            case "대전광역시":
	                srchPolyBizSecd = "003002006";
	                break;
	            case "울산광역시":
	                srchPolyBizSecd = "003002007";
	                break;
	            case "경기도":
	                srchPolyBizSecd = "003002008";
	                break;
	            case "강원도":
	                srchPolyBizSecd = "003002009";
	                break;
	            case "충청북도":
	                srchPolyBizSecd = "003002010";
	                break;
	            case "충청남도":
	                srchPolyBizSecd = "003002011";
	                break;
	            case "전라북도":
	                srchPolyBizSecd = "003002012";
	                break;
	            case "전라남도":
	                srchPolyBizSecd = "003002013";
	                break;
	            case "경상북도":
	                srchPolyBizSecd = "003002014";
	                break;
	            case "경상남도":
	                srchPolyBizSecd = "003002015";
	                break;
	            case "제주특별자치도":
	                srchPolyBizSecd = "003002016";
	                break;
	            case "세종특별자치시":
	                srchPolyBizSecd = "003002017";
	                break;
	            default:
	                srchPolyBizSecd = "003002001";
	                break;
	        }
	    
	    return srchPolyBizSecd;
	}


	@Override
	public List<ApiDataDto> getHotList() {
		List<ApiDataDto> apiData = apiMapper.getHotList();
		return apiData;
	}

}
