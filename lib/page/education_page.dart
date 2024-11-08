import 'package:flutter/material.dart';

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("교육수강현황(개인)"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildEducationItem(50, '2024 하반기 안전보건 교육', '2024-10-01', '2024-11-30', false),
          _buildEducationItem(80, '2024 상반기 안전보건 교육', '2024-06-28', '2024-06-28', true),
          // 추가 항목도 여기에 추가 가능
        ],
      ),
    );
  }

  // 교육 현황 위젯 생성 함수
  Widget _buildEducationItem(int progressRate, String title, String startDate, String endDate, bool completionStatus) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: completionStatus ? Colors.blueAccent : Colors.grey,
          child: Text(
            completionStatus ? '수료' : '미수료',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('교육기간(시작): $startDate', style: TextStyle(color: Colors.grey)),
            Text('교육기간(종료): $endDate', style: TextStyle(color: Colors.grey)),
            Text('진도율: $progressRate%', style: TextStyle(color: Colors.grey)),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              '상세 정보: 이 교육 과정은 안전 보건에 대한 기본 지식을 제공합니다.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}