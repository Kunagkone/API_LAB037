import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/item.dart';

class ItemService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Item>> fetchMarketplaceItems() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((data) => Item.fromJson(data)).toList();
      } else {
        throw Exception('เซิร์ฟเวอร์ตอบกลับรหัสข้อผิดพลาด: ${response.statusCode}');
      }
    } on TimeoutException {
      throw Exception('การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง');
    } on http.ClientException {
      throw Exception('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาตรวจสอบสัญญาณเน็ต');
    } catch (e) {
      throw Exception('เกิดข้อผิดพลาดในการโหลดรายการสินค้า: $e');
    }
  }
}