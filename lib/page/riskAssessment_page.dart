import 'package:flutter/material.dart';
import 'package:untitled/page/riskDetail_page.dart';
import 'package:untitled/page/riskRegistration_page.dart';

class RiskAssessmentPage extends StatefulWidget {
  @override
  _RiskAssessmentPageState createState() => _RiskAssessmentPageState();
}

class _RiskAssessmentPageState extends State<RiskAssessmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("위험성 평가"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //위험성 평가 목록
            Expanded(
              child: ListView(
                children: [
                  _buildRiskAssessmentItem('(주)데모', '원재료 입고', '보건의료관', '수시', '2024-10-30', '강영미', false),
                  _buildRiskAssessmentItem('(주)데모', '정육원 보관', '본관', '최초', '2024-08-28', '박상영', true),
                  _buildRiskAssessmentItem('(주)데모', '지게차 입출고', '인문관', '정기', '2024-06-28', '유선호', false),
                ],
              ),
            ),
          ],
        ),
      ),

      // 하단에 등록 버튼 구현
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RiskRegistrationPage()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: [
              Icon(Icons.library_add, size: 24), // 추가 아이콘
              SizedBox(width: 8), // 텍스트와 아이콘 사이의 간격
              Text(
                '위험성 평가',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),


    );
  }

  Widget _buildRiskAssessmentItem(String company, String title, String workplace, String type, String date, String name, bool inspection) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: inspection ? Colors.blueAccent : Colors.grey,
          child: Text(
            inspection ? '결재' : '대기',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('사업장: $workplace', style: TextStyle(color: Colors.grey)),
            Text('평가일: $date', style: TextStyle(color: Colors.grey)),
            Text('평가자: $name', style: TextStyle(color: Colors.grey)),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RiskDetailPage(
                company: company,
                title: title,
                workplace: workplace,
                type: type,
                date: date,
                name: name,
                inspection: inspection,
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: RiskAssessmentPage()));
}
