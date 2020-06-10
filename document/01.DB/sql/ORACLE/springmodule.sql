--------------------------------------------------------
--  DDL for Table TB_USER_LOGIN
--------------------------------------------------------

  CREATE TABLE  "TB_USER_LOGIN" 
   (	"USER_ID" VARCHAR2(100 BYTE), 
	"PASSWORD" VARCHAR2(500 BYTE), 
	"REGISTER_DATE" DATE, 
	"REGISTER_ID" VARCHAR2(100 BYTE), 
	"MODIFY_DATE" DATE, 
	"MODIFY_ID" VARCHAR2(100 BYTE)
   ) ;

   COMMENT ON COLUMN  "TB_USER_LOGIN"."USER_ID" IS '사용자ID';
   COMMENT ON COLUMN  "TB_USER_LOGIN"."PASSWORD" IS '암호';
   COMMENT ON COLUMN  "TB_USER_LOGIN"."REGISTER_DATE" IS '등록일시';
   COMMENT ON COLUMN  "TB_USER_LOGIN"."REGISTER_ID" IS '등록자ID';
   COMMENT ON COLUMN  "TB_USER_LOGIN"."MODIFY_DATE" IS '수정일시';
   COMMENT ON COLUMN  "TB_USER_LOGIN"."MODIFY_ID" IS '수정자ID';
   COMMENT ON TABLE "TB_USER_LOGIN"  IS '사용자 로그인 테이블';
--------------------------------------------------------
--  DDL for Index TB_USER_LOGIN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX  "TB_USER_LOGIN_PK" ON  "TB_USER_LOGIN" ("USER_ID") ;
--------------------------------------------------------
--  Constraints for Table TB_USER_LOGIN
--------------------------------------------------------

  ALTER TABLE  "TB_USER_LOGIN" MODIFY ("USER_ID" NOT NULL ENABLE);
  ALTER TABLE  "TB_USER_LOGIN" MODIFY ("PASSWORD" NOT NULL ENABLE);
  ALTER TABLE  "TB_USER_LOGIN" ADD CONSTRAINT "TB_USER_LOGIN_PK" PRIMARY KEY ("USER_ID");
