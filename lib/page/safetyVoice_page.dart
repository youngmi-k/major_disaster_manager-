import 'package:flutter/material.dart';

// 작성자는 로그인한 사용자, 작성일은 현재 날짜로 고정되기 때문에 생략함.
// 나중에 DB에 넣을 때 이 부분을 입력받지 않아도 사용자와 일시에 맞게 고정으로 넣어야 함.
class SafetyVoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('안전보이스 작성'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      // 드롭다운: 사업장 선택
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: '사업장',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        ),
                        items: ['본관', '공학관', '보건의료관', '스포츠과학관', '원화관', '인문관', '자연과학관']
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(width: 16), // 두 드롭다운 사이의 간격
                    Expanded(
                      // 드롭다운: 작성구분 선택
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: '작성구분',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        ),
                        items: ['안전신고', '안전제안']
                            .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // 텍스트 필드: 제목
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
                SizedBox(height: 16),

                // 내용 작성 필드
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '내용',
                    hintText: '접수된 안전보이스는 순차적으로 조치를 취하고 있습니다. 내용을 상세히 기재해 주셔야 정확한 조치가 가능합니다.', // 힌트 텍스트 추가
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    floatingLabelBehavior: FloatingLabelBehavior.always,  // 항상 라벨을 위에 표시
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 30),

                // 이미지 버튼
                Text('이미지'),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // 이미지 촬영 및 선택 기능
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[200],
                        child: Icon(Icons.add_a_photo, size: 40),
                      ),
                    ),
                    SizedBox(width: 16),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          // 하단에 고정된 작성완료 버튼
          Positioned(  // Positioned 위젯으로 버튼의 위치를 지정
            bottom: 0,  // 하단에 고정
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.white,  // 배경 색상을 지정하여 하단을 구분
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,  // 버튼 배경색을 검정색으로 설정
                  foregroundColor: Colors.white,  // 버튼 글자색을 흰색으로 설정
                  padding: EdgeInsets.all(16),  // 버튼 안쪽 패딩
                  shape: StadiumBorder(),  // 타원형 버튼으로 설정
                ),
                onPressed: () {
                  // 작성완료 기능
                },
                child: Text('작성 완료', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: SafetyVoicePage(),
));
