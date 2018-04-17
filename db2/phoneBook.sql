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
-- 1. ȸ��ģ���� ��� �����͸� �˻��ϱ� ���� ���� (JOIN), 
--    : �̸����� �˻�, ��ȭ��ȣ�� �˻�
-- ���� 
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
;
-- �˻�
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
    AND B.FR_NAME='ȫ�浿'
;
SELECT *
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
    AND BB.FR_PHONENUMBER LIKE '%8548%'
;
-- VIEW �� �̿��� �˻�
SELECT * FROM PB_COM_VIEW;
SELECT * FROM PB_COM_VIEW WHERE NAME LIKE '%ȫ%';



-- 2. ����ģ���� ��� �����͸� �˻��ϱ� ���� ���� (JOIN)
--    : �̸����� �˻�, ��ȭ��ȣ�� �˻�
-- JOIN
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
;
-- �̸��˻�
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
    AND B.FR_NAME LIKE '%����%'
;
SELECT * 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
    AND B.FR_PHONENUMBER LIKE '%����%'
;
-- VIEW�� �̿��� �˻�
SELECT * FROM PB_UNIV_VIEW;
SELECT * FROM PB_UNIV_VIEW WHERE FR_NAME LIKE '%��%' ;
   
   -- 3. ȸ��ģ��, ����ģ�� �����͸� �������� �� VIEW�� ���� �սô�.
-- ȸ��ģ�� ��
DROP VIEW PB_COM_VIEW;
CREATE OR REPLACE VIEW PB_COM_VIEW
(IDX, NAME, PNUM, EMAIL, ADDR, REGDATE, COM_NAME)
AS
SELECT B.IDX, B.FR_NAME, B.FR_PHONENUMBER, B.FR_EMAIL, B.FR_ADDRESS, B.FR_REGDATE
, C.FR_C_COMPANY
FROM PHONEINFO_BASIC B, PHONEINFO_COM C
WHERE B.IDX=C.FR_REF
;
-- ����ģ�� ��
DROP VIEW PB_UNIV_VIEW;
CREATE OR REPLACE VIEW PB_UNIV_VIEW
AS
SELECT B.IDX, B.FR_NAME, B.FR_PHONENUMBER, B.FR_ADDRESS, B.FR_EMAIL, B.FR_REGDATE, U.FR_U_MAJOR, U.FR_U_YEAR 
FROM phoneInfo_basic B, phoneInfo_univ U
WHERE B.IDX=U.FR_REF
;


-- 4. �����̺��� �⺻Ű�� ������ �������� �����սô�.
-- �⺻���̺��� ���� ������
CREATE SEQUENCE PB_B_SEQ
START WITH 0
MINVALUE 0
MAXVALUE 1000000
INCREMENT BY 1;

-- ȸ��ģ�� ���̺� ������
CREATE SEQUENCE PB_COM_SEQ; -- ���� 1 ������ 1 �ּҰ� 1
-- �б�ģ�� ���̺� ������ 
CREATE SEQUENCE PB_UNIV_SEQ; -- ���� 1 ������ 1 �ּҰ� 1




-- 5. ȸ��ģ��, ����ģ���� �����͸� �Է��ϱ����� INSERT ���� �ۼ��սô�.

-- ȸ��ģ�� �Է� ( �⺻���� �Է� --> ȸ������ �Է� )
INSERT INTO PHONEINFO_BASIC (IDX, FR_NAME, FR_PHONENUMBER)
    VALUES (PB_B_SEQ.NEXTVAL, 'ȫ�浿', '111-1111-1111');
INSERT INTO phoneInfo_COM (IDX, FR_REF) 
    VALUES (PB_COM_SEQ.NEXTVAL, PB_B_SEQ.CURRVAL);    
  
INSERT INTO PHONEINFO_BASIC (IDX, FR_NAME, FR_PHONENUMBER)
    VALUES (PB_B_SEQ.NEXTVAL, '�迬��', '333-3333-3333');
INSERT INTO phoneInfo_COM VALUES (PB_COM_SEQ.NEXTVAL, 'NAVER', PB_B_SEQ.CURRVAL);    


-- ����ģ�� �Է� ( �⺻���� �Է� --> �������� �Է� )
INSERT INTO PHONEINFO_BASIC
    VALUES (PB_B_SEQ.NEXTVAL, '������', '000-0000-0000', 'PJS@NAVER.COM', '����', SYSDATE );
INSERT INTO PHONEINFO_UNIV VALUES (PB_UNIV_SEQ.NEXTVAL, '�౸', 2, PB_B_SEQ.CURRVAL);

SELECT * FROM PHONEINFO_BASIC;



-- 6. ȸ��ģ��, ����ģ�� ���� �� ���� SQL�� �ۼ��սô�.
-- �ڽ����̺��� ������ ���� ���� -> �θ� ���̺� ������ ����
-- ȸ��ģ�� ����
DELETE FROM PHONEINFO_COM WHERE FR_REF=2;
DELETE FROM PHONEINFO_BASIC WHERE IDX=2;
-- ����ģ�� ����
DELETE FROM PHONEINFO_UNIV WHERE FR_REF=3;
DELETE FROM PHONEINFO_BASIC WHERE IDX=3;


-- 7. �����˻��� ���� �ε��� ������ �սô�. ( �̸�, ��ȭ��ȣ )
-- �̸��� ���� 
CREATE INDEX PB_B_NAME_INDEX
ON phoneInfo_basic(fr_name);
-- ��ȭ��ȣ�� ����
CREATE INDEX PB_B_PNUM_INDEX
ON phoneInfo_basic(fr_phonenumber);
    
    
    