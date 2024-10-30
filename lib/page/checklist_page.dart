import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChecklistPage extends StatefulWidget {
  final String userId;

  ChecklistPage({required this.userId});

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  List<dynamic> checklists = [];
  bool isLoading = true; // To show loading indicator

  @override
  void initState() {
    super.initState();
    fetchChecklists(); // Fetch checklist data
  }

  Future<void> fetchChecklists() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/checklists?user_id=${widget.userId}'));

      if (response.statusCode == 200) {
        final List<dynamic> allChecklists = json.decode(response.body); // Parse all checklist data

        // Filter checklists with "확정" state
        setState(() {
          checklists = allChecklists.where((checklist) => checklist['state'] == '확정').toList();
          isLoading = false; // Set loading to false after fetching data
        });
      } else {
        throw Exception('Failed to fetch checklists.');
      }
    } catch (error) {
      print('Error occurred: $error');
      setState(() {
        isLoading = false; // Set loading to false even on error
      });
      // Optionally show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('체크리스트'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : checklists.isEmpty
          ? Center(child: Text('체크리스트가 없습니다.')) // Message if no checklists
          : ListView.builder(
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          final checklist = checklists[index];
          return ListTile(
            title: Text(checklist['checklist_nm']),
            subtitle: Text('등록일: ${checklist['reg_date']} - ${checklist['check_shpere_nm']}'),
            onTap: () {
              // Navigate to detail view of the checklist
              // You can implement a detailed view for each checklist item here
            },
          );
        },
      ),
    );
  }
}
