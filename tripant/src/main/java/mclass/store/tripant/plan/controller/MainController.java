package mclass.store.tripant.plan.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import mclass.store.tripant.place.domain.AreaEntity;
import mclass.store.tripant.place.domain.AreaNameEntity;
import mclass.store.tripant.plan.model.service.PlanService;

@Controller
@Slf4j
public class MainController {
	@Autowired
	private PlanService planService;
//	@Autowired
//	private PlaceServiceCrawling placeService;
//	@Autowired
//	private TimeServiceCrawling timeService;

	@GetMapping("/")
	public ModelAndView home(Principal principal, Authentication authentication, ModelAndView mv) {
		mv.addObject("principal", principal);
		mv.addObject("auth", authentication);
		//model 대신 ModelAndView를 사용함
		mv.addObject("planCount", planService.selectPlanCount());
		mv.addObject("memCount", planService.selectMemCount());
		mv.addObject("areaNameList", planService.selectAreaNameList());
		
		mv.setViewName("main/home");
		//timeService.makeTimeList(); 
		return mv;
	}

	// 지역&제목 모달에서 선택한 지역 정보 가져오기
	@PostMapping("/plan/area")
	@ResponseBody
	public AreaEntity area(@RequestParam("areaCode") Integer areaCode) {
		AreaEntity areaInfo = planService.selectAreaInfo(areaCode);
		return areaInfo;
	}

	//지역 리스트 검색
	@PostMapping("/find/area")
	//@ResponseBody
	public String findArea(Model model, @RequestParam("findArea") String findArea) {
		List<AreaNameEntity> areaNameList = planService.selectAreaFindList(findArea);
		model.addAttribute("areaNameList", areaNameList);
		return "main/wrap_arealist";
	}
	
	
}
