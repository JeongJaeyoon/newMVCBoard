--DDL
drop table phoneInfo_univ;
drop table phoneInfo_com;
drop table phoneInfo_basic;



create table phoneInfo_basic(
    idx number(6),
    fr_name VARCHAR2(20) not null, 
    fr_phonenumber VARCHAR2(20) not null,
    fr_email VARCHAR(20), 
    fr_address VARCHAR(20),
    fr_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT phoneInfo_basic_idx_pk PRIMARY KEY(idx)
    );
    
    create table phoneInfo_univ(
    idx number(6),
    fr_u_major VARCHAR(20) DEFAULT 'N' not null,
    fr_u_year NUMBER(1) DEFAULT(1) not null,
    fr_ref number(7) not null,
    CONSTRAINT phoneInfo_univ_idx_pk PRIMARY KEY(idx),
    CONSTRAINT phoneInfo_univ_fr_u_year_CK CHECK(fr_u_year > 0 AND fr_u_year <5),
    CONSTRAINT phoneInfo_univ_fr_ref_FK FOREIGN KEY(fr_ref)REFERENCES phoneInfo_basic(idx)
    );
    
    create table phoneInfo_com(
    idx number(6),
    fr_c_company VARCHAR(20) DEFAULT 'N' not null,
    fr_ref NUMBER(6) not null,
    CONSTRAINT phoneInfo_basic_idx_CPK PRIMARY KEY(idx),
    CONSTRAINT phoneInfo_com_ref_CFK FOREIGN KEY(fr_ref)REFERENCES phoneInfo_basic(idx)
    );
    
    -- dml
    
--PHONEBOOK DML
-- 1. 회사친구의 모든 데이터를 검색하기 위한 질의 (JOIN), 
--    : 이름으로 검색, 전화번호로 검색
-- 조인 
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
;
-- 검색
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
    AND B.FR_NAME='홍길동'
;
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
    AND BB.FR_PHONENUMBER LIKE '%8548%'
;
-- VIEW 를 이용한 검색
SELECT * FROM PB_COM_VIEW;
SELECT * FROM PB_COM_VIEW WHERE NAME LIKE '%홍%';



-- 2. 대학친구의 모든 데이터를 검색하기 위한 질의 (JOIN)
--    : 이름으로 검색, 전화번호로 검색
-- JOIN
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
;
-- 이름검색
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
    AND B.FR_NAME LIKE '%영진%'
;
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
    AND B.FR_PHONENUMBER LIKE '%영진%'
;
-- VIEW를 이용한 검색
SELECT * FROM PB_UNIV_VIEW;
SELECT * FROM PB_UNIV_VIEW WHERE FR_NAME LIKE '%박%' ;
   
   -- 3. 회사친구, 대학친구 데이터를 보기위한 각 VIEW를 생성 합시다.
-- 회사친구 뷰
DROP VIEW PB_COM_VIEW;
CREATE OR REPLACE VIEW PB_COM_VIEW
(IDX, NAME, PNUM, EMAIL, ADDR, REGDATE, COM_NAME)
AS
SELECT B.IDX, B.FR_NAME, B.FR_PHONENUMBER, B.FR_EMAIL, B.FR_ADDRESS, B.FR_REGDATE
, C.FR_C_COMPANY
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
;
-- 대학친구 뷰
DROP VIEW PB_UNIV_VIEW;
CREATE OR REPLACE VIEW PB_UNIV_VIEW
AS
SELECT B.IDX, B.FR_NAME, B.FR_PHONENUMBER, B.FR_ADDRESS, B.FR_EMAIL, B.FR_REGDATE, U.FR_U_MAJOR, U.FR_U_YEAR 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
;


-- 4. 각테이블의 기본키에 적용할 시퀀스를 생성합시다.
-- 기본테이블을 위한 시퀀스
CREATE SEQUENCE PB_B_SEQ
START WITH 0
MINVALUE 0
MAXVALUE 1000000
INCREMENT BY 1;

-- 회사친구 테이블 시퀀스
CREATE SEQUENCE PB_COM_SEQ; -- 시작 1 증가값 1 최소값 1
-- 학교친구 테이블 시퀀스 
CREATE SEQUENCE PB_UNIV_SEQ; -- 시작 1 증가값 1 최소값 1




-- 5. 회사친구, 대학친구의 데이터를 입력하기위한 INSERT 문을 작성합시다.

-- 회사친구 입력 ( 기본정보 입력 --> 회사정보 입력 )
INSERT INTO PHONEINFO_BASIC (IDX, FR_NAME, FR_PHONENUMBER)
    VALUES (PB_B_SEQ.NEXTVAL, '홍길동', '111-1111-1111');
INSERT INTO phoneInfo_COM (IDX, FR_REF) 
    VALUES (PB_COM_SEQ.NEXTVAL, PB_B_SEQ.CURRVAL);    
  
INSERT INTO PHONEINFO_BASIC (IDX, FR_NAME, FR_PHONENUMBER)
    VALUES (PB_B_SEQ.NEXTVAL, '김연아', '333-3333-3333');
INSERT INTO phoneInfo_COM VALUES (PB_COM_SEQ.NEXTVAL, 'NAVER', PB_B_SEQ.CURRVAL);    


-- 대학친구 입력 ( 기본정보 입력 --> 대학정보 입력 )
INSERT INTO PHONEINFO_BASIC
    VALUES (PB_B_SEQ.NEXTVAL, '박지성', '000-0000-0000', 'PJS@NAVER.COM', '영국', SYSDATE );
INSERT INTO PHONEINFO_UNIV VALUES (PB_UNIV_SEQ.NEXTVAL, '축구', 2, PB_B_SEQ.CURRVAL);

SELECT * FROM PHONEINFO_BASIC;



-- 6. 회사친구, 대학친구 삭제 를 위한 SQL을 작성합시다.
-- 자식테이블의 데이터 부터 삭제 -> 부모 테이블 데이터 삭제
-- 회사친구 삭제
DELETE FROM PHONEINFO_COM WHERE FR_REF=2;
DELETE FROM PHONEINFO_BASIC WHERE IDX=2;
-- 대학친구 삭제
DELETE FROM PHONEINFO_UNIV WHERE FR_REF=3;
DELETE FROM PHONEINFO_BASIC WHERE IDX=3;


-- 7. 빠른검색을 위한 인덱스 설정을 합시다. ( 이름, 전화번호 )
-- 이름에 설정 
CREATE INDEX PB_B_NAME_INDEX
ON phoneInfo_basic(fr_name);
-- 전화번호에 생성
CREATE INDEX PB_B_PNUM_INDEX
ON phoneInfo_basic(fr_phonenumber);
    
    
    