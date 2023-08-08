CREATE OR REPLACE PROCEDURE InsertCourse(
sStudentId IN VARCHAR2,
sCourseId IN VARCHAR2, 
nCourseIdNo IN NUMBER, 
sCourseName IN VARCHAR2,
nCourseUnit IN NUMBER,
sCourseMajor IN VARCHAR2,
nCourseTime IN NUMBER,
sCourseSite IN VARCHAR2,
nCourseMax IN NUMBER,
result OUT VARCHAR2)

IS
nPTCnt NUMBER := 0;
nSTCnt NUMBER := 0;
nNICnt NUMBER := 0;
sIdName VARCHAR2(64);
sProfessorname Varchar2(16);

/* 한 교수가 같은 시간에 수업을 입력 */
duplicate_ProfandTime EXCEPTION;
/* 이미 같은 장소, 시간에 수업이 존재 */
duplicate_SiteandTime EXCEPTION;
/* 과목명, 분반이 중복 */
duplicate_NameandIdNo EXCEPTION;
/* 다른 강의에 강의번호가 중복  */
duplicate_IdandName EXCEPTION;

BEGIN
result := '';

SELECT COUNT(m.m_id)
INTO nPTCnt
FROM course c, member m, teach t
WHERE c.m_id = m.m_id and c.c_id = t.c_id and t.t_time = nCourseTime and m.m_id = sStudentId;

IF (nPTCnt > 0)
THEN 
RAISE duplicate_ProfandTime;
END IF;

SELECT COUNT(c.c_site)
INTO nSTCnt
FROM course c, teach t
WHERE c.c_id = t.c_id and c.c_site = sCourseSite and t.t_time = nCourseTime;

IF (nSTCnt > 0)
THEN 
RAISE duplicate_SiteandTime;
END IF;

SELECT COUNT(c_name)
INTO nNICnt
FROM course
WHERE c_name = sCourseName and c_id_no = nCourseIdNo;

IF (nNICnt > 0)
THEN 
RAISE duplicate_NameandIdNo;
END IF;

SELECT c_name
INTO sIdName
FROM course
WHERE c_id = sCourseId;

IF (sIdName != sCourseName)
THEN 
RAISE duplicate_IdandName;
END IF;

INSERT INTO course (c_id, c_id_no, c_name, c_major, c_unit, c_site, m_id) VALUES (sCourseId, nCourseIdNo, sCourseName, sCourseMajor, nCourseUnit, sCourseSite, sStudentId);
INSERT INTO teach (c_id, c_id_no, t_year, t_semester, t_time, t_max) VALUES (sCourseId, nCourseIdNo, Date2EnrollYear(SYSDATE), Date2EnrollSemester(SYSDATE), nCourseTime, nCourseMax);

COMMIT;

result := '강의 입력이 완료되었습니다.';
dbms_output.put_line(result);

EXCEPTION
WHEN duplicate_ProfandTime THEN result := '입력한 시간에 이미 수업이 있습니다.';
WHEN duplicate_SiteandTime THEN result := '입력한 장소에 이미 수업이 있습니다.';
WHEN duplicate_NameandIdNo THEN result := '입력한 강의의 해당 분반이 이미 있습니다.';
WHEN duplicate_IdandName THEN result := '입력한 강의번호의 이미 강의가 있습니다.';

WHEN OTHERS THEN ROLLBACK;
result := SQLCODE;
END;
/
