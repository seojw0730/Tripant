package mclass.store.tripant.diary.controller;

import java.security.Principal;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.service.annotation.PostExchange;
import org.springframework.web.servlet.ModelAndView;

import mclass.store.tripant.diary.domain.BuyThemeEntity;
import mclass.store.tripant.diary.domain.DiaryBoardEntity;
import mclass.store.tripant.diary.domain.WritePlanTitleEntity;
import mclass.store.tripant.diary.model.service.DiaryService;

@Controller
@RequestMapping("/my")
public class MyDiaryController {

	@Autowired
	private DiaryService diaryService;
	

	@GetMapping("/diary") // 특정 사용자가 작성한 모든 글 조회
	public ModelAndView mydiary(ModelAndView mv, Principal principal) {
		mv.addObject("diaries", diaryService.selectMyDiaryList(principal.getName(), 4));
		mv.setViewName("diary/my/my_board");
		return mv;
	}

	@PostMapping("/diary/more") // 특정 사용자가 작성한 모든 글 조회 더보기
	public String mydiaryMore(Model model, Principal principal, Integer clickNum) {
		int maxNum = (clickNum + 1) * 4;
		List<DiaryBoardEntity> list = diaryService.selectMyDiaryList(principal.getName(), maxNum);
		
		model.addAttribute("diaries", list);
		return "diary/my/board_more_fragment";
	}

	// 기본 글 버전
	@GetMapping("/post")
	public String showDiaryForm(Model model, Principal principal) {
		List<BuyThemeEntity> themes = diaryService.selectBuyTheme(principal.getName());
		model.addAttribute("themes", themes);
		model.addAttribute("plans", diaryService.getAllPlans(principal.getName()));

		String memRole = diaryService.isVip(principal.getName());
		if (memRole.contains("MEM")) {
			return "diary/my/my_write";
		} else if (memRole.contains("VIP")) {
			return "diary/my/my_write_font";
		} else {
			return "redirect:/";
		}
	}

	// 글쓰기 처리
	@PostMapping("/post")
	@ResponseBody
	public ResponseEntity<?> createDiary(@RequestBody DiaryBoardEntity diaryForm, Principal principal) {

		diaryForm.setDiaryMemEmail(principal.getName());
		diaryForm.setDiaryViews(diaryForm.getDiaryViews() == null ? 0 : diaryForm.getDiaryViews()); // 기본값 설정

		// DiaryPostEntity 저장 (diaryService를 통해 저장 후 diary 객체는 DB에 저장된 후 자동으로 생성된 ID가
		// 채워짐)
		diaryForm = diaryService.save(diaryForm);

		// 저장된 DiaryPostEntity를 ResponseEntity로 반환
		return ResponseEntity.ok().body(diaryForm);
	}

	// 글쓰기 처리(폰트 구매버전)
	@PostMapping("/post/font")
	@ResponseBody
	public ResponseEntity<?> createFontDiary(@RequestBody DiaryBoardEntity diaryForm, Principal principal) {

		diaryForm.setDiaryMemEmail(principal.getName());
		diaryForm.setDiaryViews(diaryForm.getDiaryViews() == null ? 0 : diaryForm.getDiaryViews()); // 기본값 설정

		// DiaryPostEntity 저장 (diaryService를 통해 저장 후 diary 객체는 DB에 저장된 후 자동으로 생성된 ID가
		// 채워짐)
		diaryForm = diaryService.save(diaryForm);

		// 저장된 DiaryPostEntity를 ResponseEntity로 반환
		return ResponseEntity.ok().body(diaryForm);
	}

	// 여행글 삭제 처리
	@PostMapping("/diary/delete/{diaryId}")
	@ResponseBody
	public int deleteDiaryById(@PathVariable("diaryId") int diaryId, Principal principal) {
		// 여기서 diaryId를 사용하여 삭제 작업을 수행합니다.
		int result = 0;

		try {

			result = diaryService.deleteDiaryById(diaryId, principal.getName());
		} catch (DataAccessException e) {

			e.printStackTrace();
			result = -1;
		} // DiaryService에서 삭제 메서드 호출
		return result; // 삭제 성공 시 1, 실패 시 0을 반환합니다.
	}

	// 여행글 신고 처리
	@PostMapping("/diary/report/{diaryId}")
	@ResponseBody
	public int reportsOne(@PathVariable("diaryId") int diaryId, Principal principal) {
		int result = 0;
		try {
			result = diaryService.reportsOne(diaryId, principal.getName());
		}catch (DuplicateKeyException e) {
			//DuplicateKeyException (좁은 범위)
			e.printStackTrace();
			result = -2;
		}
			catch (DataAccessException e) {
			//	DataAccessException 더 넓은 범위
				e.printStackTrace();
			result = -3;
		}
		return result;
	}

	// 좋아요 기능
	@PostMapping("/diary/like/{diaryId}")
	@ResponseBody
	public Integer likeDiary(@PathVariable int diaryId, Principal principal) {
		int result = diaryService.likeDiary(diaryId, principal.getName());
		return result;
	}

	// 좋아요해제 기능
	@PostMapping("/diary/unlike/{diaryId}")
	@ResponseBody
	public Integer unlikeDiary(@PathVariable int diaryId, Principal principal) {
		int result = diaryService.unlikeDiary(diaryId, principal.getName());
		return result;
	}

	// 수정하기
	@GetMapping("/diary/update/{diaryId}")
	public String showUpdateDiaryForm(@PathVariable int diaryId, Model model, Principal principal) {
		String memEmail = null;
		if (principal != null) {
			memEmail = principal.getName();
		}

		model.addAttribute("themes", diaryService.selectBuyTheme(memEmail));
		// 조회된 글 정보를 모델에 추가하여 폼에 전달
		model.addAttribute("diary", diaryService.selectDiaryById(diaryId, memEmail));
		//model.addAttribute("plans", diaryService.getAllPlans(memEmail));
		model.addAttribute("loggedInUserEmail", memEmail);

		// 수정 폼을 나타내는 HTML 파일 이름을 반환합니다.
		return "diary/my/diary_modify";
	}

	@PostMapping("/diary/update/{diaryId}")
	public ResponseEntity<?> updateDiary(@RequestBody DiaryBoardEntity diaryForm, Principal principal ) {
		
		diaryForm.setDiaryMemEmail(principal.getName());
		diaryForm.setDiaryViews(diaryForm.getDiaryViews() == null ? 0 : diaryForm.getDiaryViews()); // 기본값 설정
		diaryForm.setDiaryId(diaryForm.getDiaryId());
		// DiaryPostEntity 저장 (diaryService를 통해 저장 후 diary 객체는 DB에 저장된 후 자동으로 생성된 ID가
		// 채워짐)
		diaryForm = diaryService.updateDiary(diaryForm);

		// 저장된 DiaryPostEntity를 ResponseEntity로 반환
		return ResponseEntity.ok().body(diaryForm);
	}
}
