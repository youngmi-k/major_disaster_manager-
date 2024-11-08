import 'package:flutter/material.dart';

class SeriousAccidentNoticePage extends StatelessWidget {
  final List<SeriousAccidentNotice> SeriousAccidentNotices;

  SeriousAccidentNoticePage({required this.SeriousAccidentNotices});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        title: Text('중대재해 알림'),
        centerTitle: true,
        backgroundColor: Colors.white,),
      body: ListView.builder(
        itemCount: SeriousAccidentNotices.length,
        itemBuilder: (context, index) {
          final notice = SeriousAccidentNotices[index];
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
                  notice.image.isNotEmpty ? Image.network(notice.image) : Container(), // 빈 문자열일 때는 빈 컨테이너 반환
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
class SeriousAccidentNotice {
  final String title; //제목
  final String date; //작성일
  final String content; //내용
  final String image; // 이미지
  // 이미지가 없을 때는 image 변수에 '' 빈 문자열을 넣어주세요.

  SeriousAccidentNotice({required this.title, required this.date, required this.content, required this.image});
}

// 샘플 데이터 생성
List<SeriousAccidentNotice> SeriousAccidentNotices = [
  SeriousAccidentNotice(
    title: '서비스업 생활폐기물 수거 중 끼임',
    date: '2024-08-28',
    content: """생활폐기물 수거 중 끼임

► 사고발생 원인
- (인적) 적재함에 탑승한 근로자의 위치를 확인하지 않은 상태에서 파워게이트 조작
- (탑승) 폐기물을 받아 적재하기 위해 적재함에 탑승한 채 이동함
- (신호) 작업자 간 신호 방법 부재
- (작업계획서) 화물자동차 상차 방법 작업계획서 미수립
""",
    image: 'http://203.231.136.21:8001/imgupload/notice/17248185405244a7b5e960c40aa0f8bc92888b43f3ba0.png'
  ),
  // 더 많은 데이터를 추가할 수 있습니다.
];
