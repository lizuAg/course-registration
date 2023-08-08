create or replace function Date2EnrollSemester(dDate IN DATE)
RETURN NUMBER
IS
   v_semester NUMBER;
   
BEGIN
   IF(to_char(dDate, 'MM') >= '05' and to_char(dDate, 'MM') <= '10') THEN
      v_semester := 2;
   ELSE
      v_semester := 1;
   END IF;

   RETURN v_semester;
END;
/
