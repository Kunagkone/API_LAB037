import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AiProduct {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  AiProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory AiProduct.fromJson(Map<String, dynamic> json) {
    return AiProduct(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }
}

Future<List<AiProduct>> fetchAiProducts() async {
  try {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => AiProduct.fromJson(item)).toList();
    } else {
      throw 'เกิดข้อผิดพลาดจากเซิร์ฟเวอร์ (Status: ${response.statusCode})';
    }
  } on TimeoutException {
    throw 'การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง';
  } on http.ClientException {
    throw 'ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาตรวจสอบการเชื่อมต่อ';
  } on FormatException {
    throw 'รูปแบบข้อมูลที่ได้รับไม่ถูกต้อง';
  } catch (e) {
    throw 'เกิดข้อผิดพลาดที่ไม่ทราบสาเหตุ: $e';
  }
}