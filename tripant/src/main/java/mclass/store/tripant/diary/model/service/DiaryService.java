package mclass.store.tripant.diary.model.service;


import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import mclass.store.tripant.diary.domain.BuyThemeEntity;
import mclass.store.tripant.diary.domain.DiaryBoardEntity;
import mclass.store.tripant.diary.domain.LikeEntity;
import mclass.store.tripant.diary.domain.WritePlanTitleEntity;
import mclass.store.tripant.diary.model.repository.DiaryRepository;

@Service
public class DiaryService {
	@Autowired
	private DiaryRepository diaryRepository;

	// 전체글 리스트 가져오기
	public List<DiaryBoardEntity> selectDiaryList(String areaname, int maxNum, String memEmail) {
		return diaryRepository.selectDiaryList(areaname, maxNum, memEmail);
	}

	// 최신순 정렬
	public List<DiaryBoardEntity> getLatestDiaries(String areaname, int maxNum, String memEmail) {
		return diaryRepository.selectLatest(areaname, maxNum, memEmail);
	}

	// 좋아요 정렬
	public List<DiaryBoardEntity> selectLikesPopular(String areaname, int maxNum, String memEmail) {
		return diaryRepository.selectLikesPopular(areaname, maxNum, memEmail);
	}

	// 조회수 정렬
	public List<DiaryBoardEntity> selectViewsPopular(String areaname, int maxNum, String memEmail) {
		return diaryRepository.selectViewsPopular(areaname, maxNum, memEmail);
	}

	// mydiary 모든 내가 쓴 글()조회해서 가져오기
	public List<DiaryBoardEntity> selectMyDiaryList(String memEmail, int maxNum) {
		return diaryRepository.selectMyDiaryList(memEmail, maxNum);
	}

	// 특정 ID의 여행기 글 가져오기
	public DiaryBoardEntity selectDiaryById(int diaryId, String memEmail) {
		return diaryRepository.selectDiaryById(diaryId, memEmail);
	}
	
	// 글 작성 페이지 등급별 나누기
	public String isVip(String memEmail) {
		return diaryRepository.isVip(memEmail);
	}

	// 여행기 글 등록하기, 여행기 글 등록 시 이미지 url 및 text 저장 
	@Transactional
	public DiaryBoardEntity save(DiaryBoardEntity diary) {
		int result = diaryRepository.insertDiary(diary);
		diaryRepository.insertDiaryImage(diary);
		return diary;
	}
	
	// 여행기 글 수정하기
	@Transactional
	public DiaryBoardEntity updateDiary(DiaryBoardEntity updatedDiary) {
		int result = diaryRepository.updateDiary(updatedDiary);
		diaryRepository.updateDiaryImage(updatedDiary); 
		return updatedDiary;
	}

	// 여행기 글 삭제
	  public int deleteDiaryById(int diaryId, String memEmail)throws DataAccessException {
	    return diaryRepository.deleteDiaryById(diaryId,memEmail);
	  } 

	 // 여행기 글 신고하기
	  public int reportsOne(int diaryId, String memEmail)  throws DataAccessException{
		  return diaryRepository.reportsOne(diaryId, memEmail);
	  }
	  

	// 조회수 증가
	@Transactional
	public int incrementDiaryViews(int diaryId, String memEmail) {
		
		return diaryRepository.incrementDiaryViews(diaryId);
	}

	// 회원의 모든 여행 계획 가져오기(Mycontroller)
	public List<WritePlanTitleEntity> getAllPlans(String memberEmail) {
		return diaryRepository.selectPlanById(memberEmail);
	}

	// 한개의 여행기에 여러명의 이메일 계정들이 누른 하트 개수 + 로그인한 계정이 눌렀는지 여부
	public LikeEntity selectDiaryLike(int diaryId, String memEmail) {
		return diaryRepository.selectDiaryLike(diaryId, memEmail);
	}

	// 다이어리 좋아요 수 증가하기
	/*
	 * public LikeEntity isDiaryLikedByUser(int diaryId, String memEmail) { return
	 * diaryRepository.selectDiaryLike(diaryId); }
	 */
	// 여행기 글 좋아요
	public int likeDiary(int diaryId, String memEmail) {
		return diaryRepository.insertDiaryLike(diaryId, memEmail);
	}
	// 여행기 글 좋아요해제
	public int unlikeDiary(int diaryId, String memEmail) {
		return diaryRepository.deleteDiaryLike(diaryId, memEmail);
	}
	
	// 내가 산 theme 가져와서 적용 시키기
	public List<BuyThemeEntity> selectBuyTheme(int diaryId, String memEmail) {
		return diaryRepository.selectBuyTheme(diaryId,memEmail);
		
	}
	// 내가 산 theme 가져와서 적용 시키기(글쓸때)
	public List<BuyThemeEntity> selectBuyTheme(String memEmail) {
		// TODO Auto-generated method stub
		return diaryRepository.selectBuyTheme(memEmail);
	}
}