import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/page/riskDetail_page.dart';

class RiskAssessmentPage extends StatefulWidget {
  @override
  _RiskAssessmentPageState createState() => _RiskAssessmentPageState();
}

class _RiskAssessmentPageState extends State<RiskAssessmentPage> {
  // 드롭다운 메뉴에서 선택된 값 저장
  String selectedBusiness = 'All';
  String selectedAssessmentType = 'All';
  DateTimeRange? selectedDateRange;

  // 드롭다운 메뉴 항목
  final List<String> businessOptions = ['All', '공학관', '보건의료관', '본관', '스포츠과학관', '원화관', '인문관', '자연과학관'];
  final List<String> assessmentOptions = ['All', '최초', '정기', '수시'];

  // 날짜 선택 함수
  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      initialDateRange: selectedDateRange ?? DateTimeRange(
        start: DateTime.now().subtract(Duration(days: 30)),
        end: DateTime.now(),
      ),
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

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
            Row(
              children: [
                // 사업장 선택
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '사업장',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // 타원형 테두리
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                    value: selectedBusiness,
                    items: businessOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedBusiness = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                // 위험성 평가 종류 선택
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '위험성평가종류',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), // 타원형 테두리
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                    ),
                    value: selectedAssessmentType,
                    items: assessmentOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedAssessmentType = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // 기간 선택
            Row(
              children: [
                Text("기간: ", style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDateRange(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        selectedDateRange == null
                            ? '날짜 선택'
                            : '${DateFormat('yyyy.MM.dd').format(
                            selectedDateRange!.start)} ~ ${DateFormat(
                            'yyyy.MM.dd').format(selectedDateRange!.end)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.calendar_today, color: Colors.grey),
              ],
            ),
            SizedBox(height: 16),
            //위험성 평가 목록
            Expanded(
              child: ListView(
                children: [
                  _buildRiskAssessmentItem('원재료 입고', '보건의료관', '2024-10-30', '강영미', false),
                  _buildRiskAssessmentItem('정육원 보관', '본관', '2024-08-28', '박상영', true),
                  _buildRiskAssessmentItem('지게차 입출고', '인문관', '2024-06-28', '유선호', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskAssessmentItem(String title, String workplace, String date, String name, bool inspection) {
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
                title: title,
                workplace: workplace,
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
