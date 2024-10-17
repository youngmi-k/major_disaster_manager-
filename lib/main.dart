import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  // 로그인 함수
  Future<void> login(String userId, String password) async {
    // 프록시 서버 URL로 수정
    final String url = 'http://localhost:3000/login';  // 프록시 서버 경로

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // 응답을 JSON으로 받기 위한 헤더
        },
        body: jsonEncode({
          'user_id': userId,
          'password': password,
          'user_nm': '',
          'tel_no': '',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          await saveUserInfo(userId);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        } else {
          setState(() {
            message = '로그인 실패: ${responseData['message']}';
          });
        }
      } else {
        setState(() {
          message = '서버 오류: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        message = '네트워크 오류: $e';
      });
    }
  }

  // SharedPreferences를 사용하여 로그인 정보 저장
  Future<void> saveUserInfo(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(labelText: '사용자 ID'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                login(userIdController.text, passwordController.text);
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 화면'),
      ),
      body: Center(
        child: Text('로그인 성공!'),
      ),
    );
  }
}
