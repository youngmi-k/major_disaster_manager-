import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart'; // firebase_core 임포트
import 'package:untitled/page/checkListDetail_page.dart'; // ChecklistDetailPage 파일을 가져옵니다.

class ChecklistPage extends StatefulWidget {
  final String userNm; // 로그인한 사용자의 이름

  // 사용자 이름을 받는 생성자
  ChecklistPage({required this.userNm});

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // 현재 날짜 가져오기
    final String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('체크리스트'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상단 점검 정보
            Card(
              color: Colors.white,
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          today, // 현재 날짜
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '보건의료관',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('오늘 점검 항목입니다.', style: TextStyle(fontSize: 20)),
                        Row(
                          children: [
                            Icon(Icons.fact_check, color: Colors.amber, size: 30),
                            SizedBox(width: 8),
                            Text(
                              '8', // 점검 항목 숫자
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Divider(thickness: 1.5, color: Colors.grey.shade300),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: _buildCounter('점검된 항목', 2, Colors.black),
                        ),
                        Expanded(
                          child: _buildCounter('미점검 항목', 6, Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // 체크리스트 목록
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('checklist')
                    .where('check_user_nm', isEqualTo: widget.userNm) // 로그인한 사용자 이름 필터링
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('데이터를 가져오는 데 실패했습니다: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('조회된 체크리스트가 없습니다.'));
                  }

                  var checklistItems = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: checklistItems.length,
                    itemBuilder: (context, index) {
                      var checklist = checklistItems[index].data() as Map<String, dynamic>; // 데이터 형변환
                      return _buildChecklistItem(
                        checklist['checklist_nm'],
                        checklist['check_cycle_nm'],
                        checklist['check_yn'] == '점검됨',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int count, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        SizedBox(height: 4),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
            children: [
              TextSpan(
                text: '$count',
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistItem(String title, String cycle, bool inspection) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: inspection ? Colors.blueAccent : Colors.red,
          child: Text(
            inspection ? '점검' : '미점검',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        title: Text(title),
        subtitle: Text('점검종류: $cycle', style: TextStyle(color: Colors.grey)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChecklistDetailPage(
                title: title,
                inspection: inspection,
              ),
            ),
          );
        },
      ),
    );
  }
}
