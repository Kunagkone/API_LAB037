import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  // ⚠️ อย่าลืมนำ API Key จริงของคุณมาใส่แทนที่ 'YOUR_API_KEY'
  static const _apiKey = '7d97d894de2f309676414f1851399cf7';

  Future<Weather> fetchWeather(String city) async {
    final uri = Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric&lang=th');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // กรณีสำเร็จ: แปลง JSON Response Body เป็น Weather Object
        return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        // กรณีหาเมืองไม่เจอ (Status 404)
        throw Exception('ไม่พบข้อมูลเมืองที่ค้นหา กรุณาตรวจสอบชื่อเมืองอีกครั้ง');
      } else {
        // กรณี Error อื่นๆ จาก Server
        throw Exception('เกิดข้อผิดพลาดจากเซิร์ฟเวอร์ (รหัสสถานะ: ${response.statusCode})');
      }
    } on TimeoutException {
      // ดักจับกรณีหมดเวลาเชื่อมต่อ (เกิน 10 วินาที)
      throw Exception('การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง');
    } on http.ClientException {
      // ดักจับกรณีไม่มีอินเทอร์เน็ต / เชื่อมต่อ Server ไม่ได้
      throw Exception('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้ กรุณาตรวจสอบการเชื่อมต่อ');
    } on FormatException {
      // ดักจับกรณี Response ไม่ใช่ JSON ที่ถูกต้อง
      throw Exception('รูปแบบข้อมูลที่ได้รับจากเซิร์ฟเวอร์ไม่ถูกต้อง');
    } catch (e) {
      rethrow;
    }
  }
}