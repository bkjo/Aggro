package kr.team.aggro.realword;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.team.aggro.chatting.InvenSocket;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/realword")
public class RealWordController {
	
	private static final Logger logger = LoggerFactory.getLogger(RealWordController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/nickname/create", method = RequestMethod.POST)
	public String getNickName(@RequestParam(value="nickName", defaultValue="noName")String nickName , Model model, HttpSession session) throws Exception {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + nickName);
		session.setAttribute("nickName", nickName);

		kr.team.aggro.chatting.InvenSocket is = new InvenSocket();
		System.out.println(is.getClients().size());
		session.setAttribute("invenCount", is.getClients().size());
		
		
		Document daumDocument = Jsoup.connect("http://m.daum.net").get();
		Document naverDocument = Jsoup.connect("http://www.naver.com?mobile").get();
		Document invenDocument = Jsoup.connect("http://m.inven.co.kr").get();
		Document marumaruDocument = Jsoup.connect("http://marumaru.in").get();
		
		ArrayList<RealWordDTO> dataList = new ArrayList<RealWordDTO>();
		
		Map<String,ArrayList<RealWordDTO>> dataMap = new HashMap<String,ArrayList<RealWordDTO>>();
		
		Elements elements;
		RealWordDTO rsDTO = new RealWordDTO();
		
        if (null != daumDocument) {
            // class 가 rank_dummy 를 가지고 있는 div 태그는 포함시키지 않는다.
        	elements = daumDocument.select("div.keyword_issue > ol.list_issue > li > a");
             for (int i = 0; i < 10; i++) {
            	rsDTO = new RealWordDTO();
            	rsDTO.setWord(elements.get(i).select("span.txt_issue").text());
            	rsDTO.setRank(i + 1);
            	dataList.add(rsDTO);
            	
             }
             dataMap.put("daumDataList", dataList);
        }
        dataList = new ArrayList<RealWordDTO>();
        if (null != naverDocument) {
        	elements = naverDocument.select("div.ah_roll a");
			for (int i = 0; i < 10; i++) {
				rsDTO = new RealWordDTO();
				rsDTO.setWord(elements.get(i).select("span.ah_k").text());
				rsDTO.setRank(i + 1);
				dataList.add(rsDTO);
			}
            dataMap.put("naverDataList", dataList);
        }
        dataList = new ArrayList<RealWordDTO>();
        if (null != invenDocument) {
        	elements = invenDocument.select("div > ul.ranklist a");
			for (int i = 0; i < 10; i++) {
				rsDTO = new RealWordDTO();
				rsDTO.setWord(elements.get(i).select("span.ranksubject").text());
				rsDTO.setRank(i + 1);
				dataList.add(rsDTO);
			}
            dataMap.put("invenDataList", dataList);
        }
        dataList = new ArrayList<RealWordDTO>();
        if (null != marumaruDocument) {
        	elements = marumaruDocument.select("div.widget_prank a");
			for (int i = 0; i < 10; i++) {
				rsDTO = new RealWordDTO();
				rsDTO.setWord(elements.get(i).select("a").text());
				rsDTO.setRank(i + 1);
				dataList.add(rsDTO);
			}
            dataMap.put("marumaruDataList", dataList);
        }
        if (naverDocument != null || daumDocument != null || invenDocument != null || marumaruDocument != null) {
            model.addAttribute("dataList", dataMap);
            
        	return "RealWord/RealWord.user";
        }
        
		return "RealWord/RealWord.user";
	}
	
//	@RequestMapping(value = "/search", method = RequestMethod.GET)
//	public String daumReal(Model model) throws Exception {
//		Document daumDocument = Jsoup.connect("http://m.daum.net").get();
//		Document naverDocument = Jsoup.connect("http://www.naver.com?mobile").get();
//		ArrayList<RealWordDTO> dataList = new ArrayList<RealWordDTO>();
//		
//		Elements elements;
//		RealWordDTO rsDTO = new RealWordDTO();
//		
//        if (null != daumDocument) {
//            // class 가 rank_dummy 를 가지고 있는 div 태그는 포함시키지 않는다.
//        	elements = daumDocument.select("div.keyword_issue > ol.list_issue > li > a");
//             for (int i = 0; i < 10; i++) {
//            	rsDTO = new RealWordDTO();
//            	rsDTO.setWord(elements.get(i).select("span.txt_issue").text());
//            	rsDTO.setRank(i + 1);
//            	dataList.add(rsDTO);
//            	
//             }
//             model.addAttribute("dataList", dataList);
//             System.out.println("######1" + dataList);
//        }
//        if (null != naverDocument) {
//        	elements = naverDocument.select("div.ah_roll a");
//			for (int i = 0; i < 10; i++) {
//				rsDTO = new RealWordDTO();
//				rsDTO.setWord(elements.get(i).select("span.ah_k").text());
//				rsDTO.setRank(i + 1);
//				dataList.add(rsDTO);
//			}
//            model.addAttribute("dataList", dataList);
//            System.out.println("######2" + dataList);
//        }
//        if (naverDocument != null || daumDocument != null) {
//        	return "RealWord/RealWord.user";
//        }
//        
//		return "redirect:/";
//		
//	}
	
	@RequestMapping(value = "/inven/chat", method = RequestMethod.POST)
	public String invenChat(HttpSession session, Model model){
		String nickName = (String) session.getAttribute("nickName");
		System.out.println(nickName);
		return "Chatting/InvenChat.user";
	}
//	
//	@RequestMapping(value = "/chat2")
//	public String chat2(Model model){
//		return "chat2";
//		
//	}
//	
}
