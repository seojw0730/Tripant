package mclass.store.tripant.diary.model.repository;



import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.dao.DataAccessException;

import mclass.store.tripant.diary.domain.BuyThemeEntity;
import mclass.store.tripant.diary.domain.DiaryBoardEntity;
import mclass.store.tripant.diary.domain.LikeEntity;
import mclass.store.tripant.diary.domain.WritePlanTitleEntity;

@Mapper
public interface DiaryRepository {

	// 전체글 목록
	public List<DiaryBoardEntity> selectDiaryList(@Param("areaname") String areaname, @Param("maxNum") int maxNum, @Param("memEmail") String memEmail);
	// 최신순 정렬
	List<DiaryBoardEntity> selectLatest(@Param("areaname") String areaname, @Param("maxNum") int maxNum, @Param("memEmail") String memEmail);
	// 좋아요 정렬
	List<DiaryBoardEntity> selectLikesPopular(@Param("areaname") String areaname, @Param("maxNum") int maxNum, @Param("memEmail") String memEmail);
	// 조회수 정렬
	List<DiaryBoardEntity> selectViewsPopular(@Param("areaname") String areaname, @Param("maxNum") int maxNum, @Param("memEmail") String memEmail);
	
	// 나의 모든 글 조회
	public List<DiaryBoardEntity> selectMyDiaryList(@Param("memEmail") String diaryMemEmail, @Param("maxNum") int maxNum);

	// 글 작성 페이지 등급별 나누기
	String isVip(String memEmail);
	// 여행기 글 등록
	public int insertDiary(DiaryBoardEntity diary);
	// 여행기 이미지URL 및 텍스트 저장
	public int insertDiaryImage(DiaryBoardEntity diary);
	
	List<WritePlanTitleEntity> selectPlanById(String memberEmail);
	
	DiaryBoardEntity findById(@Param("id") Long id);
	
	 //한개의 글 보기
	// 특정 ID의 다이어리 조회 + 로그인한 계정이 눌렀는지 여부
	 DiaryBoardEntity selectDiaryById(@Param("diaryId") int diaryId, @Param("memEmail") String memEmail);

	// 글 카운트 증가 메서드
	int incrementDiaryViews(@Param("diaryId") int diaryId);
	
	// 한개의 여행기에 여러명의 이메일 계정들이 누른 하트 개수 + 로그인한 계정이 눌렀는지 여부
	LikeEntity selectDiaryLike(@Param("diaryId") int diaryId, @Param("memEmail") String memEmail);
	// 좋아요 누르기
	int insertDiaryLike(@Param("diaryId") int diaryId, @Param("memEmail") String memEmail);
	// 좋아요 해제
	int deleteDiaryLike(@Param("diaryId") int diaryId, @Param("memEmail") String memEmail);
	// 여행기글 삭제

	 int deleteDiaryById(@Param("diaryId") int diaryId , @Param("memEmail") String memEmail) throws DataAccessException;
	
	// 여행기글 신고 
	 int reportsOne(@Param("diaryId") int diaryId, @Param("memEmail") String memEmail) throws DataAccessException;

	 // 여행기 글 Previews text 꺼내기
	 void previewsText(@Param("diaryId") int diaryId , @Param("memEmail") String memEmail);
	 
	// 글 수정하기
	 int updateDiary(DiaryBoardEntity updatedDiary);
	// 글 미리보기 & 대표이미지 url 수정하기
	 public int updateDiaryImage(DiaryBoardEntity diary);
	 
	 

	 // 내가 구매한 theme 꺼내기 
	 List<BuyThemeEntity> selectBuyTheme(@Param("diaryId") int diaryId ,@Param("memEmail") String memEmail);
	// 글작성 시theme 꺼내기 
	 public List<BuyThemeEntity> selectBuyTheme(String memEmail);
	

}
