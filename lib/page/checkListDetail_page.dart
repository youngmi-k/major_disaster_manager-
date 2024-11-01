import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ChecklistDetailPage extends StatefulWidget {
  final String title;
  final bool inspection;

  ChecklistDetailPage({required this.title, required this.inspection});

  @override
  _ChecklistDetailPageState createState() => _ChecklistDetailPageState();
}

class _ChecklistDetailPageState extends State<ChecklistDetailPage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat('yyyy.MM.dd').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('체크리스트 작성'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 점검표 정보 섹션 추가
          Card(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.black, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 모든 요소를 가운데 정렬
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // 텍스트 가운데 정렬
                  ),
                  SizedBox(height: 8),
                  Text(
                    '일시: $today',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center, // 텍스트 가운데 정렬
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: widget.inspection ? Colors.blueAccent.withOpacity(0.1) : Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.inspection ? Colors.blueAccent : Colors.redAccent,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      '${widget.inspection ? "점검 완료" : "점검 미완료"}',
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.inspection ? Colors.blueAccent : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // 텍스트 가운데 정렬
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 체크리스트 항목들
          ...checklistItems.map((item) {
            return Card(
              color: Colors.grey.shade100,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.number}. ${item.question}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
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
                    if (item.selectedOption == '부적합') ...[
                      SizedBox(height: 16),
                      Text('부적합 사유:', style: TextStyle(fontSize: 16)),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: '부적합 사유를 작성해주세요.',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('사진 첨부:', style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey[300],
                              child: Icon(Icons.add_a_photo, size: 40),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(_selectedImages.length, (index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 16),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                        ),
                                        child: Image.file(
                                          _selectedImages[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: () => _removeImage(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black.withOpacity(0.5),
                                            ),
                                            child: Icon(Icons.close, color: Colors.white, size: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
      // 작성완료 버튼을 하단에 고정
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
            print("점검 완료 버튼 클릭됨");
          },
          child: Text('점검 완료', style: TextStyle(fontSize: 18)),
        ),
      )
          : null, // inspection이 true일 때는 bottomNavigationBar가 없음
    );
  }
}

// 체크리스트 데이터 모델 정의
class ChecklistItem {
  final int number;
  final String question;
  final List<String> options;
  String? selectedOption;

  ChecklistItem({
    required this.number,
    required this.question,
    this.options = const ['적합', '부적합'],
    this.selectedOption,
  });
}

// 샘플 데이터 생성
final List<ChecklistItem> checklistItems = [
  ChecklistItem(number: 1, question: '퇴실한 장소의 전기제품 전원이 차단되었는지 확인한다.'),
  ChecklistItem(number: 2, question: '전기제품 위에 물병, 화분 등이 올려져 있는지 확인한다.'),
  ChecklistItem(number: 3, question: '난방기는 가연물질과 멀리 떨어져 있는지 확인한다.'),
  ChecklistItem(number: 4, question: '전원 플러그가 콘센트에 완전히 접속되었는지 확인한다.'),
  ChecklistItem(number: 5, question: '전기라디에이터, 에어컨 등 전력소모량이 많은 전기제품의 전원코드를 한 개의 콘센트에 문어발식으로 접속하였는지 확인한다.'),
  ChecklistItem(number: 6, question: '냉온수기, 음료자판기 외관 및 설치 상태를 확인한다.'),
  ChecklistItem(number: 7, question: '유도등이 파손되거나 탈락되었는지 확인한다.'),
  ChecklistItem(number: 8, question: '분전함이 잠겨있는지 확인한다.'),
  ChecklistItem(number: 9, question: '콘센트가 파손되거나 물기가 침입하였는지 확인한다.'),
  ChecklistItem(number: 10, question: '노출 설치된 케이블, 전선배관이 파손되었는지 확인한다.'),
  ChecklistItem(number: 11, question: '환풍기가 파손되었거나 먼지가 심하게 쌓였는지 확인한다.'),
  ChecklistItem(number: 12, question: '환풍기 회전을 방해하는 장애물이 있는지 확인한다.'),
  ChecklistItem(number: 13, question: '콘센트는 방수형으로 설치되었는지 확인한다.'),
  ChecklistItem(number: 14, question: '심야축열기 등 난방기에 물기가 침입하였는지 확인한다.'),
  ChecklistItem(number: 15, question: '냉·난방기 외관의 설치 상태는 정상인지 확인한다.'),
  ChecklistItem(number: 16, question: '최종 퇴관시 분전반 차단기를 차단한다.'),
  ChecklistItem(number: 17, question: '조명기구, 안정기의 정상 부착 여부를 확인한다.'),
  ChecklistItem(number: 18, question: '비상발전기가 상시 작동 가능한지 확인한다.'),
];
