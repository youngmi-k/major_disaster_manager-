import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  final List<Notice> notices;

  NoticePage({required this.notices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        title: Text('공지사항'),
        centerTitle: true,
        backgroundColor: Colors.white,),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Card(
              color: Colors.grey.shade100,
              child: ExpansionTile(
                title: Text(notice.title),
                subtitle: Text(notice.date),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(notice.content),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// 공지사항 데이터 모델 정의
class Notice {
  final String title; //제목
  final String date; //작성일
  final String content; //내용

  Notice({required this.title, required this.date, required this.content});
}

// 샘플 데이터 생성
List<Notice> notices = [
  Notice(
    title: '중대재해처벌법 운영솔루션 개설안내',
    date: '2024-06-26',
    content: """안녕하세요.

해당 사이트는 중대재해처벌법대응을 위한 운영솔루션을 제공하며
자산관리(업무관련), 위험성평가, 아차사고예방을 위한 신고제도 등
전 사원의 안전과 보건을 위한 안전보건관리체계를 구축하는 시스템 입니다.

안전한 작업환경 조성을 위해 정기(수시로) 위험성평가를 진행하며
안전보건 관계 법령 및 규정을 수립하여 실행하고 개선해 나가기 위한 자료로 활용할 예정 입니다.

임직원 모두 안전보건활동에 대해 책임과 의무를 가지고 임하여 주시길 바랍니다.

감사합니다.""",
  ),
  Notice(
    title: '24년 7월 장마대비 유의사항',
    date: '2024-08-09',
    content: """7월 장마철 대비 유의 사항 공지

1. 시설물의 빗물 취약점 발견시 안전팀에 신고.

2. 시간당 40mm 이상 비 예보시 외부 작업 중지 권고.

3. 지게차등 외부에 있는 시설의 안전관리 대비""",
  ),
  Notice(
    title: '8월 폭염 주의도',
    date: '2024-08-11',
    content: """폭염에 대해 작업 지시 권고 사항

1. 8월1일~15일까지 35도가 넘는 폭염 예보가 있음.

2. 충분한 수분 섭취를 위해 공장내 물 공급 상비 배치

3. 35도 이상시 외부 업무중지.

4. 40분 업무 후 20분 휴식 진행.

5. 긴급환자 발생시 안전관리팀신고 및 119응급차 신고

6. 어지러움, 구토등의 증상이 발생시 안전관리팀 신고""",
  ),
  Notice(
    title: '교육-전기화재의 원인',
    date: '2024-08-28',
    content: """전사 전기화재 교육

전기화재란 전기에 의한 발여이 발화원이 되어 발생하는 화재를 말한다.

전기화재 발생원인의 3요건
1. 발화원 2. 착화물 3. 출화의 경과

이같이 전기 화재 발생원인이 발생할 경우 안전관리팀에 신고.""",
  ),
  Notice(
    title: '밀폐공간에서의 적정공기 수준 기준',
    date: '2024-09-15',
    content: """1. 산소결핍이란 공기중의 산소농도가 18퍼센트 미만인 상태를 말한다.

2. 작업장의 적정 공기 수준
- 산소농도의 범위가 18%이상 23.5%미만
- 탄소가스의 농도가 1.5% 미만
- 일산화탄소의 농도가 30ppm 미만
- 황화수소의 농도가 10ppm 미만

3. 안전관리팀에서는 2번의 적정 공기 수준을 위하여 2시간 단위로 측정 관리 중.""",
  ),
  // 더 많은 데이터를 추가할 수 있습니다.
];