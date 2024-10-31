import 'package:flutter/material.dart';
import 'package:untitled/page/notice_page.dart';
import 'package:untitled/page/safetyVoice_page.dart';
import 'package:untitled/page/checkList_page.dart';
import 'package:untitled/page/riskAssessment_page.dart';
import 'package:untitled/page/education_page.dart';
import 'main.dart'; // 로그인 페이지 임포트

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // 배경색을 흰색으로 설정
      appBar: AppBar(
        toolbarHeight: 40.0,  // 높이를 100으로 설정
        title: Text(''),
        centerTitle: true,
        backgroundColor: Color(0xFFFDD126),
        actions: [
          // OutlinedButton으로 테두리 있는 로그아웃 버튼 생성
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: OutlinedButton(
              onPressed: () {
                // 로그아웃 기능
                print("로그아웃 버튼 클릭됨");
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 1.0), // 테두리 설정
              ),
              child: Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이미지 추가
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset('assets/title_image.png'),  // 이미지 파일 경로
            ),
            SizedBox(height: 13),
            // 사용자 정보 카드
            UserCard(),

            // 메뉴 버튼들 - Expanded 대신 shrinkWrap을 사용하여 GridView 스크롤을 활성화
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,  // GridView의 높이를 자식 요소에 맞춤
              physics: NeverScrollableScrollPhysics(),  // GridView 자체 스크롤 비활성화
              padding: const EdgeInsets.all(8.0),
              children: [
                MenuButton(
                  icon: Icons.checklist,
                  label: '체크리스트',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChecklistPage()),
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.report,
                  label: '안전보이스',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SafetyVoicePage()),
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.campaign,
                  label: '공지사항',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoticePage(notices: notices)),
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.shield,
                  label: '위험성 평가',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RiskAssessmentPage()),
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.notifications,
                  label: '중대재해 알림',
                  onPressed: () {
                    // 중대재해 알림 버튼 클릭 시 액션
                  },
                ),
                MenuButton(
                  icon: Icons.menu_book,
                  label: '교육현황',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EducationPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,  // 그림자 깊이 설정 (1.0 ~ 10.0 등 값 조정 가능)
      color: Colors.white,  // 카드의 배경색 설정
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),  // 모서리를 둥글게 처리
        side: BorderSide(color: Colors.yellow, width: 1.5),  // 테두리 색상 및 두께
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user_image.png'), // 사용자 이미지
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '강영미',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '42258261',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'AI소프트웨어학과',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '보건의료관',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// 메뉴 버튼 위젯
class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onPressed;

  MenuButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Card(
        elevation: 2.0,  // 그림자 깊이
        color: Colors.white,  // 버튼 내부 배경색을 흰색으로 설정
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),  // 모서리를 둥글게 처리
          side: BorderSide(color: Colors.yellow, width: 1.5),  // 테두리 색상 노란색으로 설정
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: HomeScreen(),
));
