package mclass.store.tripant.diary.controller;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nimbusds.oauth2.sdk.Response;

import mclass.store.tripant.diary.domain.DiaryBoardEntity;
import mclass.store.tripant.diary.service.DiaryService;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class MyDiaryController {

	@Autowired
	private DiaryService diaryService;

	// 나의 글보기
	@GetMapping("/my/diary") // 나의 여행기(비공개글) 목록 가져오기
	public String mydiary(Model model) {
		diaryService.selectDiaryList();
		model.addAttribute("diaries", diaryService.selectDiaryList());
		System.out.println("======mydiary controller===" + diaryService.selectDiaryList());
		return "mydiary/mydiary_board";
	}

//		글쓰기 페이지 보이기
	@GetMapping("/my/write")
	public String diarywrite() {
		return "mydiary/mydiary_write";
	}

	// 글쓰기 처리
    @PostMapping("/my/write")
    public ResponseEntity<?> createDiary(@RequestParam String diaryMemEmail,
                                         @RequestParam Integer diaryPlanId,
                                         @RequestParam String diaryTitle,
                                         @RequestParam String diaryContent,
                                         @RequestParam String diaryDate,
                                         @RequestParam String diaryOpen,
                                         @RequestParam(required = false) Integer diaryViews,
                                         @RequestParam(required = false) String diaryTheme) {
        DiaryBoardEntity diary = new DiaryBoardEntity();
        diary.setDiaryMemEmail(diaryMemEmail);
        diary.setDiaryPlanId(diaryPlanId);
        diary.setDiaryTitle(diaryTitle);
        diary.setDiaryContent(diaryContent);
        diary.setDiaryOpen(diaryOpen);
        diary.setDiaryViews(diaryViews == null ? 0 : diaryViews); // 기본값 설정
        diary.setDiaryTheme(diaryTheme);

        try {
            
            LocalDate localDate = LocalDate.parse(diaryDate, DateTimeFormatter.ISO_DATE);
            diary.setDiaryDate(java.sql.Date.valueOf(localDate));
        } catch (DateTimeParseException e) {
            
            return ResponseEntity.badRequest().body("Invalid date format. Please use 'yyyy-MM-dd'.");
        }

        diaryService.save(diary);
        return ResponseEntity.ok().body(diary);
    }
}