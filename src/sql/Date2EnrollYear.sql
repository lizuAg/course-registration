create or replace function Date2EnrollYear(dDate IN DATE)
RETURN NUMBER
IS
   v_year NUMBER;
BEGIN
   
   SELECT extract(YEAR FROM dDate)
   INTO v_year
   FROM dual;

   IF(to_char(dDate, 'MM') >= '11') THEN
      v_year := v_year + 1;
   END IF;

   RETURN v_year;
END;
/
