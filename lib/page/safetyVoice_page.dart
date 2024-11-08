import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';  // 파일 처리에 필요

class SafetyVoicePage extends StatefulWidget {
  @override
  _SafetyVoicePageState createState() => _SafetyVoicePageState();
}

class _SafetyVoicePageState extends State<SafetyVoicePage> {
  List<File> _selectedImages = [];  // 여러 장의 이미지를 저장할 리스트
  final ImagePicker _picker = ImagePicker();  // ImagePicker 인스턴스 생성

  // 카메라 촬영 또는 앨범에서 이미지 선택
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));  // 이미지 파일 경로를 리스트에 추가
      });
    }
  }

  // 이미지 삭제 기능
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);  // 선택된 이미지를 리스트에서 삭제
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,  // 키보드가 올라왔을 때 화면이 조정되도록 설정
      appBar: AppBar(
        title: Text('안전보이스 작성'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '사업장',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),  // 타원형 테두리
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    items: ['본관', '공학관', '보건의료관', '스포츠과학관', '원화관', '인문관', '자연과학관']
                        .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    )).toList(),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '작성구분',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),  // 타원형 테두리
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    items: ['안전신고', '안전제안']
                        .map((label) => DropdownMenuItem(
                      child: Text(label),
                      value: label,
                    )).toList(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

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
                hintText: '접수된 안전보이스는 순차적으로 조치를 취하고 있습니다. 내용을 상세히 기재해 주셔야 정확한 조치가 가능합니다.',
                hintStyle: TextStyle(color: Colors.grey[400]),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(),
              ),
              maxLines: 7,
            ),
            SizedBox(height: 20),

            // '사진 첨부' 텍스트
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '사진 첨부 (최대 3장)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 5),

            // 이미지 버튼 및 선택된 이미지 리스트
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showImageSourceActionSheet();  // 이미지 선택 방법 선택
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: Icon(Icons.add_a_photo, size: 40),
                  ),
                ),
                SizedBox(width: 16),
                // 선택된 이미지가 있을 때만 보여주기 (최대 3장)
                Expanded(
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.file(_selectedImages[index], fit: BoxFit.cover),
                            ),
                            // 이미지 삭제 버튼
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
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // 하단 고정된 작성완료 버튼
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: EdgeInsets.all(16),
            shape: StadiumBorder(),
          ),
          onPressed: () {
            // 작성완료 기능
          },
          child: Text('작성 완료', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  // 이미지 소스 선택 다이얼로그 (카메라 or 갤러리)
  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('카메라로 촬영'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);  // 카메라 촬영
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('앨범에서 선택'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);  // 갤러리에서 이미지 선택
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

void main() => runApp(MaterialApp(home: SafetyVoicePage()));