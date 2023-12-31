## 주제

2023년 1학기 데이터베이스 프로그래밍 실습 프로젝트로 3인이 구현한 간단한 수강신청 사이트

## 개발 언어 및 환경



- Java(jsp)
- HTML, CSS

- Oracle DB(JDBC)
- Tomcat server

## 개요



- **로그인** : 아이디, 패스워드를 통해 로그인 (학생 사용자와 교수 사용자 구분)
- **사용자 정보 수정** : 패스워드, 이메일, 주소 변경 가능
- **수강 신청 입력** : 현재 학기에 수강할 과목을 신청할 수 있음
- **수강 신청 삭제** : 수강 신청한 과목을 수강 취소 할 수 있음
- **수강 신청 조회** : 현재 학기와 이전 학기의 수강 신청한 과목들을 확인할 수 있음(수강신청한 강의 수, 누적 학점 수 제공)
- **강의 개설 기능**: 교수 사용자는 개설 강의 목록을 확인하고, 새로운 강의를 생성할 수 있음

## 구현 기능



Oracle DB의 고급 SQL, PL/SQL을 적극적으로 활용

### 1. 프로시저

- InsertEnroll(수강신청입력) : 최대 학점 초과, 동일 과목 신청, 수강 인원 초과, 중복 시간 예외 처리
- SelectTimeTable(수강신청 조회) : 총 학점 수, 학점 개수를 Cursor를 통해 알아냄
- InsertCourse(강의 개설) : 중복 시간, 중복 강의실, 중복 교과, 과목번호 불일치 예외 처리

### 2. function

Date2EnrollYear, Date2EnrollSemester (수강신청할 연도, 학기 알아내기)

### 3. trigger

BeforeUpdateStudent(사용자 정보 수정) : 패스워드 자릿수 예외처리



## 스크린샷

|![image](https://github.com/lizuAg/course-registration/assets/68546023/59f9c33f-28d2-4855-9ee0-2ebd33d2f5ab)|![image](https://github.com/lizuAg/course-registration/assets/68546023/7262f8bc-d811-4bc8-83f0-52e9916c742a)|
|------|---|
|![image](https://github.com/lizuAg/course-registration/assets/68546023/c7d3422b-ef95-4a1a-88b4-1f371c706710)|![image](https://github.com/lizuAg/course-registration/assets/68546023/85e657c3-71a8-4e25-8bfd-a0240458ec24)
|
