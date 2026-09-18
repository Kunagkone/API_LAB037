import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createDemoPost() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({
      'title': 'ทดสอบส่งข้อมูลจาก Flutter',
      'body': 'นี่คือเนื้อหาที่ส่งด้วย HTTP POST',
      'userId': 1,
    }),
  );

  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
}

// ✅ เพิ่มฟังก์ชัน updateDemoPost() สำหรับขั้นตอนที่ 3.2
Future<void> updateDemoPost() async {
  final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
    body: jsonEncode({
      'id': 1,
      'title': 'แก้ไขข้อมูลนักศึกษาด้วย PUT',
      'studentId': '67030037', // 👈 เปลี่ยนเป็นรหัสนักศึกษาจริง
      'studentName': 'คุณากร มะซอ', // 👈 เปลี่ยนเป็นชื่อจริง
      'userId': 1,
    }),
  );

  print('=== ผลลัพธ์ HTTP PUT (ขั้นตอนที่ 3.2) ===');
  print('Status Code: ${response.statusCode}');
  print('Response Body: ${response.body}');
}