DROP SEQUENCE "SEQ_BUY_ID" ;
CREATE SEQUENCE "SEQ_BUY_ID" ;

DROP SEQUENCE "SEQ_DIARY_ID";
CREATE SEQUENCE "SEQ_DIARY_ID";

DROP SEQUENCE "SEQ_PLAN_ID";
CREATE SEQUENCE "SEQ_PLAN_ID";


DROP TABLE "DIARY_SAVE";

DROP TABLE "DIARY_REPORTS";
DROP TABLE "DIARY_LIKES";
DROP TABLE "DIARY";

DROP TABLE "BUY";
DROP TABLE "CART";
DROP TABLE "ITEM";

DROP TABLE "PLAN_SPOT";
DROP TABLE "PLAN_SCHEDULE";
DROP TABLE "PLAN_MEMBER";
DROP TABLE "PLAN";

-- 아래 테이블은 될수록 드랍하지 말자!
DROP TABLE "PLACE";
DROP TABLE "AREA";

DROP TABLE "LOG";
DROP TABLE "QUIT_MEMBER";
DROP TABLE "MEMBER";

-- JOB 삭제
EXEC DBMS_SCHEDULER.DROP_JOB('MEM_SLEEP', false);
EXEC DBMS_SCHEDULER.DROP_JOB('MEM_IS_VIP', false);


CREATE TABLE "MEMBER" (
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"MEM_NICK"	NVARCHAR2(8)		NOT NULL UNIQUE,
	"MEM_PASSWORD"	VARCHAR2(100)		NOT NULL,
	"MEM_ROLE"	VARCHAR2(30)		NOT NULL,
	"MEM_ENABLED"	NUMBER	DEFAULT 1	NOT NULL,
	"MEM_TYPE"	NUMBER(2)		NOT NULL,
	"MEM_JOIN_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEM_BIRTH"	DATE		NOT NULL,
	"MEM_TEL"	VARCHAR2(12)		NOT NULL,
	"MEM_FONT_DUR"	NUMBER	DEFAULT 0	NULL,
	"MEM_TOKEN_KAKAO"	VARCHAR2(300)		NULL,
	"MEM_TOKEN_NAVER"	VARCHAR2(300)		NULL,
	"MEM_TOKEN_RE_NAVER"	VARCHAR2(300)		NULL,
	"MEM_TOKEN_GOOGLE"	VARCHAR2(300)		NULL,
	"MEM_REPORT_NUM"	NUMBER	DEFAULT 0	NULL
);

COMMENT ON COLUMN "MEMBER"."MEM_EMAIL" IS '회원 이메일';

COMMENT ON COLUMN "MEMBER"."MEM_NICK" IS '회원 닉네임(한글 2~8자), UNIQUE';

COMMENT ON COLUMN "MEMBER"."MEM_PASSWORD" IS '비밀번호 (영문 대문자, 소문자, 숫자 포함 8~20자)';

COMMENT ON COLUMN "MEMBER"."MEM_ROLE" IS '회원 권한 등급 [휴면회원(ROLE_SLEEP), 일반회원(ROLE_MEM), 폰트 적용 회원(ROLE_VIP), 관리자(ROLE_ADMIN)]';

COMMENT ON COLUMN "MEMBER"."MEM_ENABLED" IS '활성 여부 [비활성(0), 활성(1)]';

COMMENT ON COLUMN "MEMBER"."MEM_TYPE" IS 'SNS 여부 [이메일(8), 카카오(4), 네이버(2), 구글(1)]';

COMMENT ON COLUMN "MEMBER"."MEM_JOIN_DATE" IS '가입날짜';

COMMENT ON COLUMN "MEMBER"."MEM_BIRTH" IS '생일';

COMMENT ON COLUMN "MEMBER"."MEM_TEL" IS '휴대폰 번호';

COMMENT ON COLUMN "MEMBER"."MEM_FONT_DUR" IS '글꼴 잔여 기간(일)';

COMMENT ON COLUMN "MEMBER"."MEM_TOKEN_KAKAO" IS '카카오 토큰 값';

COMMENT ON COLUMN "MEMBER"."MEM_TOKEN_NAVER" IS '네이버 토큰 값';

COMMENT ON COLUMN "MEMBER"."MEM_TOKEN_RE_NAVER" IS '네이버 갱신토큰 값';

COMMENT ON COLUMN "MEMBER"."MEM_TOKEN_GOOGLE" IS '구글 토큰 값';

COMMENT ON COLUMN "MEMBER"."MEM_REPORT_NUM" IS '신고 횟수';



CREATE TABLE "BUY" (
	"BUY_ID"	NUMBER		NOT NULL,
	"BUY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "BUY"."BUY_ID" IS '구매내역 ID';

COMMENT ON COLUMN "BUY"."BUY_DATE" IS '구매일자';

COMMENT ON COLUMN "BUY"."ITEM_CODE" IS '상품코드(폰트 2개, 테마 10개)';

COMMENT ON COLUMN "BUY"."MEM_EMAIL" IS '회원 이메일';



CREATE TABLE "ITEM" (
	"ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"ITEM_NAME"	VARCHAR2(1000)		NOT NULL,
	"ITEM_PRICE"	NUMBER		NOT NULL,
	"ITEM_DUR"	NUMBER		NULL,
	"ITEM_SALE"	NUMBER		NULL,
	"ITEM_COLOR"	CHAR(8)		NULL,
	"ITEM_SRC"	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN "ITEM"."ITEM_CODE" IS '상품코드(폰트 2개, 테마 10개)';

COMMENT ON COLUMN "ITEM"."ITEM_NAME" IS '상품명';

COMMENT ON COLUMN "ITEM"."ITEM_PRICE" IS '상품가격';

COMMENT ON COLUMN "ITEM"."ITEM_DUR" IS '상품기간';

COMMENT ON COLUMN "ITEM"."ITEM_SALE" IS '상품할인율';

COMMENT ON COLUMN "ITEM"."ITEM_COLOR" IS '상품색상(헥사코드)';

COMMENT ON COLUMN "ITEM"."ITEM_SRC" IS '상품이미지 경로';


CREATE TABLE "PLACE" (
	"TYPE"	NUMBER		NOT NULL,
	"CONTENTID"	NUMBER		NOT NULL,
	"CONTENTTYPEID"	VARCHAR2(10)		NOT NULL,
	"ADD1"	VARCHAR2(500)		NOT NULL,
	"ADD2"	VARCHAR2(100)		NULL,
	"AREACODE"	NUMBER		NOT NULL,
	"BOOKTOUR"	VARCHAR2(10)		NULL,
	"CAT1"	VARCHAR2(3)		NULL,
	"CAT2"	VARCHAR2(5)		NULL,
	"CAT3"	VARCHAR2(9)		NULL,
	"FIRSTIMAGE"	VARCHAR2(1000)		NULL,
	"FIRSTIMAGE2"	VARCHAR2(1000)		NULL,
	"CPYRHT_DIV_CD"	VARCHAR2(10)		NULL,
	"MAPX"	VARCHAR2(50)		NOT NULL,
	"MAPY"	VARCHAR2(50)		NOT NULL,
	"CREATETIME"	VARCHAR2(30)		NULL,
	"MLEVEL"	CHAR(2)		NULL,
	"SIGUNGUCODE"	VARCHAR2(2)		NULL,
	"TEL"	NVARCHAR2(40)		NULL,
	"TITLE"	VARCHAR2(500)		NOT NULL,
	"MODIFIEDTIME"	VARCHAR2(30)		NULL,
	"GETTIME"	VARCHAR2(30)	DEFAULT SYSDATE	NOT NULL
);

COMMENT ON COLUMN "PLACE"."TYPE" IS '장소 타입(필요한것만 분류, 나머지 10)';

COMMENT ON COLUMN "PLACE"."CONTENTID" IS '장소 ID';

COMMENT ON COLUMN "PLACE"."CONTENTTYPEID" IS '관광타입(12:관광지, 14:문화시설, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점)';

COMMENT ON COLUMN "PLACE"."ADD1" IS '주소(예, 서울중구다동)를응답';

COMMENT ON COLUMN "PLACE"."ADD2" IS '상세주소';

COMMENT ON COLUMN "PLACE"."AREACODE" IS '지역코드';

COMMENT ON COLUMN "PLACE"."BOOKTOUR" IS '교과서속여행지여부 (1=여행지, 0=해당없음)';

COMMENT ON COLUMN "PLACE"."CAT1" IS '대분류';

COMMENT ON COLUMN "PLACE"."CAT2" IS '중분류';

COMMENT ON COLUMN "PLACE"."CAT3" IS '소분류 (캠핑장)';

COMMENT ON COLUMN "PLACE"."FIRSTIMAGE" IS '원본대표이미지';

COMMENT ON COLUMN "PLACE"."FIRSTIMAGE2" IS '썸네일대표이미지';

COMMENT ON COLUMN "PLACE"."CPYRHT_DIV_CD" IS '저작권 유형(Type1:제1유형(출처표시-권장) Type3:제3유형(제1유형 + 변경금지))';

COMMENT ON COLUMN "PLACE"."MAPX" IS 'GPS X좌표(WGS84 경도좌표) 응답';

COMMENT ON COLUMN "PLACE"."MAPY" IS 'GPS Y좌표(WGS84 위도좌표) 응답';

COMMENT ON COLUMN "PLACE"."CREATETIME" IS '콘텐츠최초등록일';

COMMENT ON COLUMN "PLACE"."MLEVEL" IS '지도확대레벨';

COMMENT ON COLUMN "PLACE"."SIGUNGUCODE" IS '시군구코드';

COMMENT ON COLUMN "PLACE"."TEL" IS '전화번호';

COMMENT ON COLUMN "PLACE"."TITLE" IS '콘텐츠제목';

COMMENT ON COLUMN "PLACE"."MODIFIEDTIME" IS '콘텐츠수정일';

COMMENT ON COLUMN "PLACE"."GETTIME" IS 'API 가져온 시각';


CREATE TABLE "PLAN" (
	"PLAN_ID"	NUMBER		NOT NULL,
	"PLAN_AREA_CODE"	NUMBER		NOT NULL,
	"PLAN_TITLE"	VARCHAR2(100)		NOT NULL,
	"PLAN_START_DAY"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PLAN_END_DAY"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PLAN_MAKE_DAY"	DATE	DEFAULT SYSDATE	NOT NULL,
	"PLAN_DELETE_DAY"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "PLAN"."PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "PLAN"."PLAN_AREA_CODE" IS '지역 코드(1~17)';

COMMENT ON COLUMN "PLAN"."PLAN_TITLE" IS '일정 제목';

COMMENT ON COLUMN "PLAN"."PLAN_START_DAY" IS '시작날짜';

COMMENT ON COLUMN "PLAN"."PLAN_END_DAY" IS '종료날짜';

COMMENT ON COLUMN "PLAN"."PLAN_MAKE_DAY" IS '생성일자';

COMMENT ON COLUMN "PLAN"."PLAN_DELETE_DAY" IS '삭제일자';


CREATE TABLE "CART" (
	"ITEM_CODE"	VARCHAR2(20)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "CART"."ITEM_CODE" IS '상품코드(10개)';

COMMENT ON COLUMN "CART"."MEM_EMAIL" IS '회원 이메일';


CREATE TABLE "PLAN_SPOT" (
	"SPOT_DAY"	DATE		NOT NULL,
	"SPOT_PLAN_ID"	NUMBER		NOT NULL,
	"SPOT_TYPE"	NUMBER		NOT NULL,
	"SPOT_CONTENTID"	NUMBER		NOT NULL,
	"SPOT_ORDER"	NUMBER		NULL,
	"SPOT_STAY_TIME"	VARCHAR2(50)	DEFAULT 7200	NULL,
	"SPOT_MEMO"	VARCHAR2(300)		NULL
);

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_DAY" IS '방문 날짜';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_PLAN_ID" IS '일정ID';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_TYPE" IS '장소 타입(필요한것만 분류, 나머지 0)';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_CONTENTID" IS '장소 ID';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_ORDER" IS '일별 장소 방문순서';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_STAY_TIME" IS '머무는 시간 초단위 (기본2시간)';

COMMENT ON COLUMN "PLAN_SPOT"."SPOT_MEMO" IS '메모(최대100자)';


CREATE TABLE "PLAN_MEMBER" (
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"PLAN_ID"	NUMBER		NOT NULL,
	"PLAN_MEM_ROLE"	CHAR(1)		NOT NULL
);

COMMENT ON COLUMN "PLAN_MEMBER"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "PLAN_MEMBER"."PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "PLAN_MEMBER"."PLAN_MEM_ROLE" IS '권한 [생성자(1) /  공유자(0)]';


CREATE TABLE "AREA" (
	"AREA_CODE"	NUMBER		NOT NULL,
	"AREA_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_SHORT_NAME"	VARCHAR2(10)		NOT NULL,
	"AREA_ENG_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_FILE_NAME"	VARCHAR2(50)		NOT NULL,
	"AREA_LANDMARK"	VARCHAR2(50)		NOT NULL,
	"AREA_X"	VARCHAR2(50)		NOT NULL,
	"AREA_Y"	VARCHAR2(50)		NOT NULL,
	"AREA_EXPLAIN"	VARCHAR2(1000)		NOT NULL,
	"AREA_FILE_SERVER"	VARCHAR2(500)		NOT NULL,
	"AREA_ADRESS"	VARCHAR2(200)		NOT NULL
);

COMMENT ON COLUMN "AREA"."AREA_CODE" IS '지역 코드(1~17)';

COMMENT ON COLUMN "AREA"."AREA_NAME" IS '지역명';

COMMENT ON COLUMN "AREA"."AREA_SHORT_NAME" IS '지역 약어(2글자)';

COMMENT ON COLUMN "AREA"."AREA_ENG_NAME" IS '지역 영문명';

COMMENT ON COLUMN "AREA"."AREA_FILE_NAME" IS '지역 이미지 파일명';

COMMENT ON COLUMN "AREA"."AREA_LANDMARK" IS '대표 장소명';

COMMENT ON COLUMN "AREA"."AREA_X" IS 'X좌표lng';

COMMENT ON COLUMN "AREA"."AREA_Y" IS 'Y좌표lat';

COMMENT ON COLUMN "AREA"."AREA_EXPLAIN" IS '지역 설명';

COMMENT ON COLUMN "AREA"."AREA_FILE_SERVER" IS '지역 이미지 서버 주소';

COMMENT ON COLUMN "AREA"."AREA_ADRESS" IS '지역 주소';


CREATE TABLE "PLAN_SCHEDULE" (
	"SCHEDULE_DAY"	DATE		NOT NULL,
	"SCHEDULE_PLAN_ID"	NUMBER		NOT NULL,
	"SCHEDULE_START"	VARCHAR2(20)		NOT NULL,
	"SCHEDULE_END"	VARCHAR2(20)		NOT NULL
);

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_DAY" IS '여행 날짜';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_PLAN_ID" IS '일정ID';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_START" IS '일별 여행 시작 시간';

COMMENT ON COLUMN "PLAN_SCHEDULE"."SCHEDULE_END" IS '일별 여행 종료 시간';


CREATE TABLE "DIARY" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"DIARY_MEM_EMAIL"	VARCHAR2(100)		NULL,
	"DIARY_PLAN_ID"	NUMBER		NOT NULL,
	"DIARY_TITLE"	VARCHAR2(100)		NOT NULL,
	"DIARY_CONTENT"	CLOB		NOT NULL,
	"DIARY_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"DIARY_OPEN"	CHAR(1)	DEFAULT 1	NOT NULL,
	"DIARY_VIEWS"	NUMBER		NULL,
	"DIARY_THEME"	VARCHAR2(50)		NULL
);

COMMENT ON COLUMN "DIARY"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY"."DIARY_MEM_EMAIL" IS '회원 이메일';

COMMENT ON COLUMN "DIARY"."DIARY_PLAN_ID" IS '일정 ID';

COMMENT ON COLUMN "DIARY"."DIARY_TITLE" IS '게시글 타이틀';

COMMENT ON COLUMN "DIARY"."DIARY_CONTENT" IS '게시글 내용';

COMMENT ON COLUMN "DIARY"."DIARY_DATE" IS '글 작성 날짜';

COMMENT ON COLUMN "DIARY"."DIARY_OPEN" IS '공개 여부 1이면 공개 0이면 비공개';

COMMENT ON COLUMN "DIARY"."DIARY_VIEWS" IS '조회수';

COMMENT ON COLUMN "DIARY"."DIARY_THEME" IS '테마';


CREATE TABLE "DIARY_LIKES" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NULL
);

COMMENT ON COLUMN "DIARY_LIKES"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY_LIKES"."MEM_EMAIL" IS '좋아요를 남긴 회원 이메일';


CREATE TABLE "DIARY_REPORTS" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NULL,
	"REPORT_STATE"	CHAR(1)	DEFAULT 1	NOT NULL
);

COMMENT ON COLUMN "DIARY_REPORTS"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY_REPORTS"."MEM_EMAIL" IS '신고하기남긴 회원 이메일';

COMMENT ON COLUMN "DIARY_REPORTS"."REPORT_STATE" IS '게시글 상태(일반 1, 제한됨 0 )';


CREATE TABLE "LOG" (
	"LOG_TIME"	TIMESTAMP	DEFAULT SYSTIMESTAMP	NOT NULL,
	"LOG_IP"	VARCHAR2(30)		NULL,
	"LOG_TF"	CHAR(1)		NOT NULL,
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL
);

COMMENT ON COLUMN "LOG"."LOG_TIME" IS '로그인 시간';

COMMENT ON COLUMN "LOG"."LOG_IP" IS '로그인 IPv4(000:000:000:000)';

COMMENT ON COLUMN "LOG"."LOG_TF" IS '로그인 성공 여부[T, F]';

COMMENT ON COLUMN "LOG"."MEM_EMAIL" IS '회원 이메일';


CREATE TABLE "QUIT_MEMBER" (
	"MEM_EMAIL"	VARCHAR2(100)		NOT NULL,
	"MEM_NICK"	NVARCHAR2(8)		NOT NULL,
	"MEM_ROLE"	VARCHAR2(30)		NOT NULL,
	"MEM_ENABLED"	NUMBER	DEFAULT 1	NOT NULL,
	"MEM_TYPE"	NUMBER(2)		NOT NULL,
	"MEM_JOIN_DATE"	DATE		NOT NULL,
	"MEM_QUIT_DATE"	DATE	DEFAULT SYSDATE	NOT NULL,
	"MEM_BIRTH"	DATE		NOT NULL,
	"MEM_TEL"	VARCHAR2(12)		NOT NULL
);

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_EMAIL" IS '이메일';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_NICK" IS '회원 닉네임(한글 2~8자)';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_ROLE" IS '회원 권한 등급 [휴면회원(ROLE_SLEEP), 일반회원(ROLE_MEM), 폰트적용회원(ROLE_VIP), 관리자(ROLE_ADMIN)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_ENABLED" IS '활성 여부 [비활성(0), 활성(1)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_TYPE" IS 'SNS 여부 [이메일(8), 카카오(4), 네이버(2), 구글(1)]';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_JOIN_DATE" IS '가입날짜';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_QUIT_DATE" IS '탈퇴날짜';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_BIRTH" IS '생일';

COMMENT ON COLUMN "QUIT_MEMBER"."MEM_TEL" IS '휴대폰 번호';



CREATE TABLE "DIARY_SAVE" (
	"DIARY_ID"	NUMBER		NOT NULL,
	"DIARY_IMAGE"	VARCHAR2(500)		NULL,
	"DIARY_PREVIEW"	VARCHAR2(1500)		NULL
);

COMMENT ON COLUMN "DIARY_SAVE"."DIARY_ID" IS '여행기 ID';

COMMENT ON COLUMN "DIARY_SAVE"."DIARY_IMAGE" IS '파일 서버 이미지 UPL 가져오기';

COMMENT ON COLUMN "DIARY_SAVE"."DIARY_PREVIEW" IS '글 text 500자 정도 꺼내기';

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"MEM_EMAIL"
);

ALTER TABLE "BUY" ADD CONSTRAINT "PK_BUY" PRIMARY KEY (
	"BUY_ID",
	"BUY_DATE",
	"ITEM_CODE"
);

ALTER TABLE "ITEM" ADD CONSTRAINT "PK_ITEM" PRIMARY KEY (
	"ITEM_CODE"
);

ALTER TABLE "PLACE" ADD CONSTRAINT "PK_PLACE" PRIMARY KEY (
	"TYPE",
	"CONTENTID"
);

ALTER TABLE "PLAN" ADD CONSTRAINT "PK_PLAN" PRIMARY KEY (
	"PLAN_ID"
);

ALTER TABLE "CART" ADD CONSTRAINT "PK_CART" PRIMARY KEY (
	"ITEM_CODE",
	"MEM_EMAIL"
);

ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "PK_PLAN_SPOT" PRIMARY KEY (
	"SPOT_DAY",
	"SPOT_PLAN_ID",
	"SPOT_TYPE",
	"SPOT_CONTENTID",
    "SPOT_ORDER"
);

ALTER TABLE "PLAN_MEMBER" ADD CONSTRAINT "PK_PLAN_MEMBER" PRIMARY KEY (
	"MEM_EMAIL",
	"PLAN_ID"
);

ALTER TABLE "AREA" ADD CONSTRAINT "PK_AREA" PRIMARY KEY (
	"AREA_CODE"
);

ALTER TABLE "PLAN_SCHEDULE" ADD CONSTRAINT "PK_PLAN_SCHEDULE" PRIMARY KEY (
	"SCHEDULE_DAY",
	"SCHEDULE_PLAN_ID"
);

ALTER TABLE "DIARY" ADD CONSTRAINT "PK_DIARY" PRIMARY KEY (
	"DIARY_ID"
);

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "PK_DIARY_LIKES" PRIMARY KEY (
	"DIARY_ID",
	"MEM_EMAIL"
);

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "PK_DIARY_REPORTS" PRIMARY KEY (
	"DIARY_ID",
	"MEM_EMAIL"
);

ALTER TABLE "LOG" ADD CONSTRAINT "PK_LOG" PRIMARY KEY (
	"LOG_TIME",
	"LOG_IP"
);

ALTER TABLE "DIARY_SAVE" ADD CONSTRAINT "PK_DIARY_SAVE" PRIMARY KEY (
	"DIARY_ID"
);

ALTER TABLE "BUY" ADD CONSTRAINT "FK_ITEM_TO_BUY_1" FOREIGN KEY (
	"ITEM_CODE"
)
REFERENCES "ITEM" (
	"ITEM_CODE"
);

ALTER TABLE "PLAN" ADD CONSTRAINT "FK_AREA_TO_PLAN_1" FOREIGN KEY (
	"PLAN_AREA_CODE"
)
REFERENCES "AREA" (
	"AREA_CODE"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_ITEM_TO_CART_1" FOREIGN KEY (
	"ITEM_CODE"
)
REFERENCES "ITEM" (
	"ITEM_CODE"
);

ALTER TABLE "CART" ADD CONSTRAINT "FK_MEMBER_TO_CART_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
) ON DELETE CASCADE; 

-- ORA-02270 수정
ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "FK_PLAN_SCHEDULE_TO_PLAN_SPOT_1" FOREIGN KEY (
	"SPOT_DAY", "SPOT_PLAN_ID"
)
REFERENCES "PLAN_SCHEDULE" (
	"SCHEDULE_DAY", "SCHEDULE_PLAN_ID"
);

-- ORA-02270
ALTER TABLE "PLAN_SPOT" ADD CONSTRAINT "FK_PLACE_TO_PLAN_SPOT_1" FOREIGN KEY (
	"SPOT_TYPE", "SPOT_CONTENTID"
)
REFERENCES "PLACE" (
	"TYPE", "CONTENTID"
);

ALTER TABLE "PLAN_MEMBER" ADD CONSTRAINT "FK_PLAN_TO_PLAN_MEMBER_1" FOREIGN KEY (
	"PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
);

ALTER TABLE "PLAN_SCHEDULE" ADD CONSTRAINT "FK_PLAN_TO_PLAN_SCHEDULE_1" FOREIGN KEY (
	"SCHEDULE_PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
);
-- *** ON DELETE SET NULL
ALTER TABLE "DIARY" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_1" FOREIGN KEY (
	"DIARY_MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
) ON DELETE SET NULL;

ALTER TABLE "DIARY" ADD CONSTRAINT "FK_PLAN_TO_DIARY_1" FOREIGN KEY (
	"DIARY_PLAN_ID"
)
REFERENCES "PLAN" (
	"PLAN_ID"
)ON DELETE CASCADE;

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "FK_DIARY_TO_DIARY_LIKES_1" FOREIGN KEY (
	"DIARY_ID"
)
REFERENCES "DIARY" (
	"DIARY_ID"
) ON DELETE CASCADE;

ALTER TABLE "DIARY_LIKES" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_LIKES_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
) ON DELETE CASCADE;

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "FK_DIARY_TO_DIARY_REPORTS_1" FOREIGN KEY (
	"DIARY_ID"
)
REFERENCES "DIARY" (
	"DIARY_ID"
) ON DELETE CASCADE;

ALTER TABLE "DIARY_REPORTS" ADD CONSTRAINT "FK_MEMBER_TO_DIARY_REPORTS_1" FOREIGN KEY (
	"MEM_EMAIL"
)
REFERENCES "MEMBER" (
	"MEM_EMAIL"
) ON DELETE CASCADE;

ALTER TABLE "DIARY_SAVE" ADD CONSTRAINT "FK_DIARY_TO_DIARY_SAVE_1" FOREIGN KEY (
	"DIARY_ID"
)
REFERENCES "DIARY" (
	"DIARY_ID"
) ON DELETE CASCADE;
-- ***



-- VIEW
---- 여행 세부 정보 목록
CREATE OR REPLACE VIEW V_DETAILINFO AS (
select SPOT_PLAN_ID PLAN_ID, to_char(schedule_day,'YYYY-MM-DD(DY)') TRAVEL_DATE, SCHEDULE_START, SCHEDULE_END,TYPE PLACE_TYPE,SPOT_CONTENTID CONTENTID, SPOT_ORDER TRAVEL_ORDER,SPOT_STAY_TIME STAY_TIME, SPOT_MEMO MEMO, TITLE,ADDRESS, FIRSTIMAGE, LNG,LAT from plan_schedule 
left join (select * from plan_spot s left join (select TYPE, contentid,title , add1 address,firstimage,mapx lng,mapy lat from place) p on s.spot_contentid = p.contentid ) on schedule_plan_id = spot_plan_id 
where schedule_day = spot_day --order by PLAN_ID asc ,TRAVEL_DATE asc ,TRAVEL_ORDER ASC
)with read only;
---- 관리자 페이지 결제 취소 목록
create or replace view V_PAY_LIST as(
select b.buy_id, m.mem_nick, m.mem_email, i.item_name, b.buy_date, b.item_code from buy b
join member m on m.mem_email = b.mem_email
    join item i on b.item_code = i.item_code
) with read only;


--view diary
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "TRIPANT"."VIEW_DIARY_MEMBER" ("DIARY_ID", "DIARY_MEM_EMAIL", "DIARY_PLAN_ID", "DIARY_TITLE", "DIARY_CONTENT", "DIARY_DATE", "DIARY_OPEN", "DIARY_VIEWS", "DIARY_THEME", "MEM_NICK") AS 
  (
select d."DIARY_ID",d."DIARY_MEM_EMAIL",d."DIARY_PLAN_ID",d."DIARY_TITLE",d."DIARY_CONTENT",d."DIARY_DATE",d."DIARY_OPEN",d."DIARY_VIEWS",d."DIARY_THEME", m.mem_nick 
-- add column
from diary d
left outer join member m on (d.diary_mem_email = m.mem_email)
)
with read only;

-- diary title 연결 
create or replace view view_plan_member 
as (select * from plan join plan_member using (plan_id) )
;
-- TRIGGER
---- 회원
------ 회원 탈퇴 시 insert into quit_member-> delete from member
create or replace NONEDITIONABLE TRIGGER trg_member_quit
    BEFORE delete ON member
    REFERENCING OLD AS OLD
    FOR EACH ROW
DECLARE
BEGIN
   insert into quit_member values (
   :OLD.MEM_EMAIL, 
   :OLD.MEM_NICK, 
   :OLD.MEM_ROLE, 
   :OLD.MEM_ENABLED, 
   :OLD.MEM_TYPE, 
   :OLD.MEM_JOIN_DATE, 
   default, 
   :OLD.MEM_BIRTH, 
   :OLD.MEM_TEL
   );
END;
/
------ 회원별 신고 누적 10개 시 정지
create or replace NONEDITIONABLE TRIGGER trg_member_stop
    after insert ON diary_reports
    REFERENCING new AS new
    FOR EACH ROW
DECLARE
stop_email diary.diary_mem_email%type;
report_num member.mem_report_num%type;
BEGIN
    -- 신고된 diary_id의 작성자(mem_email)
    select diary_mem_email into stop_email from diary where diary_id = :new.diary_id;
    -- mem_email의 mem_report_num 1 증가
    update member set mem_report_num = mem_report_num + 1 where mem_email = stop_email;
    -- mem_email의 mem_report_num 선택
    select mem_report_num into report_num from member where mem_email = stop_email;
    -- 그 수가 10 이상이면
    if (report_num >= 10) then
    -- 정지
    update member set mem_enabled = 0 where mem_email = stop_email;
    end if;
END;
/
---- 스토어
------ 글꼴 구매 시 글꼴 기간 연장
create or replace NONEDITIONABLE TRIGGER trg_member_font
    after insert ON buy
    REFERENCING new AS new
    FOR EACH ROW
DECLARE
font_dur item.item_dur%type;
BEGIN
-- 구매한 글꼴 기간
select item_dur into font_dur from item where item_code = :new.item_code;
-- 글꼴을 구매했다면
if(substr(:new.item_code, 1, 1) = 'F') then
-- 글꼴 구매 기간만큼 기간 추가
update member set mem_font_dur = mem_font_dur + font_dur where mem_email = :new.mem_email;
-- 구매하면 VIP로 변경
update member set mem_role = 'ROLE_VIP' where mem_email = :new.mem_email;
end if;
END;
/
------ 글꼴 구매 취소 시 글꼴 기간 단축
create or replace NONEDITIONABLE TRIGGER trg_member_font_cancel
    before delete ON buy
    REFERENCING old as old
    FOR EACH ROW
DECLARE
font_dur member.mem_font_dur%type;
del_dur item.item_dur%type;
BEGIN
    select mem_font_dur into font_dur from member where mem_email = :old.mem_email;
    select item_dur into del_dur from item where item_code = :old.item_code;
    if(substr(:old.item_code, 1, 1) = 'F') then
        if(font_dur < del_dur) then
        update member set mem_font_dur = 0 where mem_email = :old.mem_email;
        update member set mem_role = 'ROLE_MEM' where mem_email = :old.mem_email;
        elsif (font_dur >= del_dur) then
        update member set mem_font_dur = mem_font_dur - del_dur where mem_email = :old.mem_email;
        end if;
    end if;
END;
/

-- 스케줄러
---- 회원
------ 글꼴 여부로 등급 변경
create or replace procedure pro_mem_is_vip
as
begin
    -- 글꼴 기간 1일 감소
    update member set mem_font_dur = mem_font_dur - 1;
    -- 글꼴 기간 0이면 일반 회원으로 변경
    update member set mem_role = 'ROLE_MEM' where mem_font_dur = 0;
    commit;
end;
/
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'mem_is_vip',
            job_type => 'stored_procedure',
            job_action => 'pro_mem_is_vip',
            number_of_arguments => 0,
            start_date => TRUNC(SYSDATE),
            repeat_interval => 'FREQ=DAILY;INTERVAL=1',
            end_date => NULL,
            enabled => TRUE,
            auto_drop => FALSE,
            comments => '글꼴 보유 여부');
END;
/
------ 휴면 회원 여부 확인
create or replace NONEDITIONABLE procedure pro_mem_sleep
as
begin
    FOR K IN (select mem_email from member left outer join log using(mem_email) where mem_role != 'ROLE_ADMIN' and log_time is null) LOOP
        update member set mem_role = 'ROLE_SLEEP' where mem_email = K.mem_email;
    END LOOP;
    FOR K IN (select mem_email from (select max(log_time) last_log_time, mem_email from log where log_tf = 'T' group by mem_email) t1 join member using(mem_email) where mem_role != 'ROLE_ADMIN' and (sysdate - cast(last_log_time as date)) > 180) LOOP
        update member set mem_role = 'ROLE_SLEEP' where mem_email = K.mem_email;
    END LOOP;
    commit;
end;
/
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
            job_name => 'mem_sleep',
            job_type => 'stored_procedure',
            job_action => 'pro_mem_sleep',
            number_of_arguments => 0,
            start_date => TRUNC(SYSDATE),
            repeat_interval => 'FREQ=DAILY;INTERVAL=1',
            end_date => NULL,
            enabled => TRUE,
            auto_drop => FALSE,
            comments => '휴면 회원 여부');
END;
/

-- 뷰, 프로시저

-- 지역 정보 넣기
INSERT INTO area SELECT * FROM area_temp;

DECLARE
	vn_num1 NUMBER := 1;
BEGIN
	LOOP
		INSERT INTO PLACE (TYPE, CONTENTID, CONTENTTYPEID, ADD1, AREACODE, MAPX, MAPY, TITLE, GETTIME) 
SELECT 100, AREA_CODE, 100, AREA_ADRESS, AREA_CODE, AREA_X, AREA_Y, AREA_LANDMARK, '20240707' FROM AREA WHERE AREA_CODE = vn_num1;
		vn_num1 := vn_num1 + 1;			
		EXIT WHEN vn_num1 > 8;			
	END LOOP;
END;
/

DECLARE
	vn_num1 NUMBER := 31;
BEGIN
	LOOP
		INSERT INTO PLACE (TYPE, CONTENTID, CONTENTTYPEID, ADD1, AREACODE, MAPX, MAPY, TITLE, GETTIME) 
SELECT 100, AREA_CODE, 100, AREA_ADRESS, AREA_CODE, AREA_X, AREA_Y, AREA_LANDMARK, '20240707' FROM AREA WHERE AREA_CODE = vn_num1;
		vn_num1 := vn_num1 + 1;			
		EXIT WHEN vn_num1 > 39;			
	END LOOP;
END;
/

--다이어리 뷰
create or replace view view_diary_member_plan
as 
(
select d.*, m.mem_nick, p.plan_area_code
-- add column
from diary d
left outer join member m on (d.diary_mem_email = m.mem_email)
left outer join plan p on (d.diary_plan_id = p.plan_id)
)
with read only
;

commit;