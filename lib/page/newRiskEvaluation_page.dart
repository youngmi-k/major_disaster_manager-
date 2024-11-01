import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewRiskEvaluationPage extends StatefulWidget {
  @override
  _NewRiskEvaluationPageState createState() => _NewRiskEvaluationPageState();
}

class _NewRiskEvaluationPageState extends State<NewRiskEvaluationPage> {
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _factorController = TextEditingController();
  final TextEditingController _measureController = TextEditingController();
  final TextEditingController _managerController = TextEditingController();

  String? _selectedRiskLevel;
  DateTime? _scheduledDate;
  DateTime? _completionDate;

  // 날짜 선택기 함수
  Future<void> _selectDate(BuildContext context, bool isScheduledDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isScheduledDate) {
          _scheduledDate = picked;
        } else {
          _completionDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 조정
      appBar: AppBar(
        title: Text('위험성 평가 추가'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView( // 화면이 넘칠 때 스크롤 가능하게 함
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 단위작업 입력 필드
            TextField(
              controller: _unitController,
              decoration: InputDecoration(
                labelText: '단위작업',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // 유해.위험요인 입력 필드
            TextField(
              controller: _factorController,
              decoration: InputDecoration(
                labelText: '유해.위험요인',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // 위험수준 선택 (상, 중, 하 라디오 버튼)
            Text('위험수준:', style: TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['상', '중', '하'].map((level) {
                return Row(
                  children: [
                    Radio<String>(
                      value: level,
                      groupValue: _selectedRiskLevel,
                      onChanged: (value) {
                        setState(() {
                          _selectedRiskLevel = value;
                        });
                      },
                    ),
                    Text(level, style: TextStyle(fontSize: 16)),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // 개선 대책 입력 필드
            TextField(
              controller: _measureController,
              decoration: InputDecoration(
                labelText: '개선 대책',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // 개선 예정일 선택
            Row(
              children: [
                Expanded(
                  child: Text(
                    _scheduledDate == null
                        ? '개선 예정일 선택'
                        : '개선 예정일: ${DateFormat('yyyy-MM-dd').format(_scheduledDate!)}',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, true),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 개선 완료일 선택
            Row(
              children: [
                Expanded(
                  child: Text(
                    _completionDate == null
                        ? '개선 완료일 선택'
                        : '개선 완료일: ${DateFormat('yyyy-MM-dd').format(_completionDate!)}',
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context, false),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 개선 담당자 입력 필드
            TextField(
              controller: _managerController,
              decoration: InputDecoration(
                labelText: '개선 담당자',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // 등록 버튼 우측 정렬
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // 각 입력 필드의 내용을 저장하여 이전 화면으로 전달
                  final newEvaluation = {
                    'unitOperation': _unitController.text,
                    'riskFactor': _factorController.text,
                    'riskLevel': _selectedRiskLevel,
                    'measure': _measureController.text,
                    'scheduledDate': _scheduledDate,
                    'completionDate': _completionDate,
                    'manager': _managerController.text,
                  };
                  Navigator.pop(context, newEvaluation);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text(
                  '등록',
                  style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
