import 'package:flutter/material.dart';
import 'package:untitled/page/notice_page.dart';
import 'package:untitled/page/safetyVoice_page.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final String areaInCharge;

  HomeScreen({required this.userId, required this.userName, required this.areaInCharge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: Text(''),
        centerTitle: true,
        backgroundColor: Color(0xFFFDD126),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: OutlinedButton(
              onPressed: () {
                // 로그아웃 기능
                print("로그아웃 버튼 클릭됨");
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white, width: 1.0),
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
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Image.asset('assets/title_image.png'),
            ),
            SizedBox(height: 13),
            UserCard(userName: userName, areaInCharge: areaInCharge),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              children: [
                MenuButton(
                  icon: Icons.checklist,
                  label: '체크리스트',
                  onPressed: () {
                    // 체크리스트 버튼 클릭 시 액션
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
                    // 위험성평가 버튼 클릭 시 액션
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
                    // 교육현황 버튼 클릭 시 액션
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
  final String userName;
  final String areaInCharge;

  UserCard({required this.userName, required this.areaInCharge});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.yellow, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/user_image.png'),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName, // user_nm 표시
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  areaInCharge.isNotEmpty ? areaInCharge : '담당 영역 없음', // area_in_charge 표시
                  style: TextStyle(fontSize: 16),
                ),
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
        elevation: 2.0,
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.yellow, width: 1.5),
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
