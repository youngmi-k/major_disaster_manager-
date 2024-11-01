import 'package:flutter/material.dart';

class RiskDetailPage extends StatefulWidget {
  final String company;
  final String title;
  final String workplace;
  final String type;
  final String date;
  final String name;
  final bool inspection;

  RiskDetailPage({required this.company, required this.title, required this.workplace, required this.type, required this.date, required this.name, required this.inspection});

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
          // 위험성평가 정보 섹션 추가
          Card(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.black, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양 끝으로 정렬
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // 여백 추가로 타원 모양 조정
                        decoration: BoxDecoration(
                          color: widget.inspection ? Colors.blueAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20), // 타원 모양
                          border: Border.all(
                            color: widget.inspection ? Colors.blueAccent : Colors.redAccent,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          '${widget.inspection ? "결재 상신" : "결재 대기"}',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.inspection ? Colors.blueAccent : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, thickness: 1.5, height: 20),
                  SizedBox(height: 8),
                  _buildDetailRow("업체명", widget.company),
                  _buildDetailRow("사업장", widget.workplace),
                  _buildDetailRow("평가 종류", widget.type),
                  _buildDetailRow("일시", widget.date),
                  _buildDetailRow("평가자", widget.name),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // 위험성평가 데이터 항목들
          ...RiskItems.map((item) {
            return Card(
              color: Colors.grey.shade100,
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("단위작업", item.unitOperation),
                    _buildDetailRow("유해.위험요인", item.riskFactor),
                    Divider(thickness: 1, color: Colors.grey.shade300), // 구분선 추가
                    SizedBox(height: 16),
                    Text(
                      '위험수준: ',
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    ),
                    Row(
                      children: item.options.map<Widget>((option) {
                        return Expanded(
                          child: RadioListTile(
                            title: Text(option, style: TextStyle(fontSize: 14)),
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
                    Divider(thickness: 1, color: Colors.grey.shade300), // 구분선 추가
                    SizedBox(height: 8),
                    _buildDetailRow("개선 대책", item.measure),
                    _buildDetailRow("개선 담당자", item.manager),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '개선 예정일:',
                              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                            ),
                            Text(
                              item.scheduledDate,
                              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '개선 완료일:',
                              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                            ),
                            Text(
                              item.completionDate,
                              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }).toList(),

        ],
      ),
      // 결재상신 버튼을 하단에 고정
      bottomNavigationBar: widget.inspection == false
          ? Padding(
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
      )
          : null, // inspection이 true일 때는 bottomNavigationBar가 없음
    );
  }

  // 위험성평가 정보 세부 항목 생성 함수
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[800]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
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
