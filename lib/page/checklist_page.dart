import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/page/checkListDetail_page.dart'; // ChecklistDetailPage 파일을 가져옵니다.

class ChecklistPage extends StatefulWidget {
  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
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
              child: ListView(
                children: [
                  _buildChecklistItem('보건의료관 104호(체력단련실)', '수시점검', true),
                  _buildChecklistItem('보건의료관 116호(강의실)', '정기점검', true),
                  _buildChecklistItem('보건의료관 207호(모의 수술 실습실)', '수시점검', false),
                  _buildChecklistItem('보건의료관 215호(강의실)', '정기점검', false),
                  _buildChecklistItem('보건의료관 305호(치과 임상 실습실)', '수시점검', false),
                  _buildChecklistItem('보건의료관 316호(영상실습실)', '수시점검', false),
                  _buildChecklistItem('보건의료관 403호(스프린트실)', '수시점검', false),
                  _buildChecklistItem('보건의료관 410호(환자 관리학 강의실)', '수시점검', false),
                ],
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

void main() => runApp(MaterialApp(home: ChecklistPage()));
