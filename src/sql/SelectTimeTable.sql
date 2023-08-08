CREATE OR REPLACE PROCEDURE SelectTimeTable(
	nMemberId IN VARCHAR2,
	nYear IN NUMBER,
	nSemester IN NUMBER,
	nTotalUnit OUT NUMBER,
	nTotalCourse OUT NUMBER
)

IS
	v_course course%ROWTYPE;
	

CURSOR cur
IS
SELECT e.c_id, e.c_id_no, c.c_unit
FROM enroll e, course c
WHERE e.m_id = nMemberId and e.e_year = nYear and e.e_semester = nSemester and e.c_id = c.c_id and e.c_id_no = c.c_id_no;

BEGIN
	nTotalUnit := 0;
	nTotalCourse := 0;

	OPEN cur;
	LOOP
		FETCH cur INTO v_course.c_id, v_course.c_id_no, v_course.c_unit;
		EXIT WHEN cur%notfound;
		nTotalUnit := nTotalUnit + v_course.c_unit;
		nTotalCourse := nTotalCourse + 1;
	END LOOP;
	CLOSE cur;
END;
/
