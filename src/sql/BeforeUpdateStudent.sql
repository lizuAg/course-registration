CREATE OR REPLACE TRIGGER BeforeUpdateMember
BEFORE
UPDATE ON Member
FOR EACH ROW

DECLARE
   underflow_length   EXCEPTION;
   invalid_value      EXCEPTION;
			name_underflow EXCEPTION;
   nLength         NUMBER;
   nBlank         NUMBER;
	nameLen NUMBER;

BEGIN
   SELECT length(:NEW.m_pwd), instr(:NEW.m_pwd, ' '), length(:NEW.m_name)
   INTO nLength, nBlank, nameLen
   FROM dual;

   IF(nLength < 4) THEN
      RAISE underflow_length;
   END IF;

   IF(nBlank > 0) THEN
      RAISE invalid_value;
   END IF;

   IF(nameLen < 2) THEN
      RAISE name_underflow;
   END IF;
	

   DBMS_OUTPUT.PUT_LINE('수정 완료');

   
   EXCEPTION
      WHEN underflow_length THEN
       RAISE_APPLICATION_ERROR(-20002, '암호는 4자리 이상이어야 합니다.');
      WHEN invalid_value THEN
       RAISE_APPLICATION_ERROR(-20003, '암호에 공란은 입력되지 않습니다.');
      WHEN name_underflow THEN
       RAISE_APPLICATION_ERROR(-20004, '이름은 2자리 이상이어야 합니다.');
END;
/
