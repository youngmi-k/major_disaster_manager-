import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('중대재해 관리 앱'),
        centerTitle: true,
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
                side: BorderSide(color: Colors.black, width: 1.5), // 테두리 설정
              ),
              child: Text(
                '로그아웃',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 사용자 정보 카드
          UserCard(),
          SizedBox(height: 10),
          // "메뉴" 제목 바
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            color: Colors.grey.shade200,
            child: Text(
              '메뉴',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          // 메뉴 버튼들
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
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
                  icon: Icons.forum,
                  label: '소통마당',
                  onPressed: () {
                    // 소통마당 버튼 클릭 시 액션
                  },
                ),
                MenuButton(
                  icon: Icons.announcement,
                  label: '공지사항',
                  onPressed: () {
                    // 공지사항 버튼 클릭 시 액션
                  },
                ),
                MenuButton(
                  icon: Icons.report,
                  label: '안전보이스',
                  onPressed: () {
                    // 안전보이스 버튼 클릭 시 액션
                  },
                ),
                MenuButton(
                  icon: Icons.qr_code_scanner,
                  label: 'QR 코드',
                  onPressed: () {
                    // QR 코드 버튼 클릭 시 액션
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
          ),
          // 하단에 "선문대학교" 문구 추가
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '선문대학교',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 사용자 카드 위젯
class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
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
        elevation: 2.0,
        margin: const EdgeInsets.all(8.0),
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