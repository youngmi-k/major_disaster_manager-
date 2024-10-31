import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class RiskDetailPage extends StatefulWidget {
  final String title;
  final String workplace;
  final String date;
  final String name;
  final bool inspection;

  RiskDetailPage({required this.title, required this.workplace, required this.date, required this.name, required this.inspection});

  @override
  _RiskDetailPageState createState() => _RiskDetailPageState();
}

class _RiskDetailPageState extends State<RiskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('위험성 평가(3단계)'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 위험성 평가 정보 섹션 추가
          Card(
            color: Colors.yellow[50],
            margin: EdgeInsets.only(bottom: 16.0),
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '사업장: ${widget.workplace}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '일시: ${widget.date}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '평가자: ${widget.name}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '결재여부: ${widget.inspection ? "결재 상신" : "결재 대기"}',
                    style: TextStyle(fontSize: 16, color: widget.inspection ? Colors.blue : Colors.red),
                  ),
                ],
              ),
            ),
          ),
          // 체크리스트 항목들
          ...RiskItems.map((item) {
            return Card(
              color: Colors.grey.shade100,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '단위작업: ${item.unitOperation}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '유해.위험요인: ${item.riskFactor}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text('위험수준: '),
                    Row(
                      children: item.options.map<Widget>((option) {
                        return Expanded(
                          child: RadioListTile(
                            title: Text(option),
                            value: option,
                            groupValue: item.selectedOption,
                            onChanged: (value) {
                              setState(() {
                                item.selectedOption = value;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '개선 대책: ${item.measure}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '개선 예정일: ${item.scheduledDate}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '개선 완료일: ${item.completionDate}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '개선 담당자: ${item.manager}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
      // 결재상신 버튼을 하단에 고정
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
            print("결재 상신 버튼 클릭됨");
          },
          child: Text('결재 상신', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

// 위험성평가 데이터 모델 정의
class RiskItem {
  final String unitOperation; // 단위작업
  final String riskFactor; // 위험요인
  final List<String> options;
  final String measure; // 개선대책
  final String scheduledDate; // 개선 예정일
  final String completionDate; // 개선 완료일
  final String manager; // 개선 담당자
  String? selectedOption;

  RiskItem({
    required this.unitOperation,
    required this.riskFactor,
    this.options = const ['상', '중', '하'],
    this.selectedOption,
    required this.measure,
    required this.scheduledDate,
    required this.completionDate,
    required this.manager,
  });
}

// 샘플 데이터 생성
final List<RiskItem> RiskItems = [
  RiskItem(unitOperation: '원재료 하차', riskFactor: '지게차 충돌', measure: '신호수 배치', scheduledDate: '2024-10-30', completionDate: '2024-10-30', manager: '강영미'),
  RiskItem(unitOperation: '재료 입고', riskFactor: '컨배이어밸트 끼임', measure: '안전교육, 장갑 착용', scheduledDate: '2024-10-30', completionDate: '2024-10-30', manager: '강영미'),
];
