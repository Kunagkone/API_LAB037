import 'package:dio/dio.dart';
import '../models/weather.dart';

class DioWeatherService {
  late final Dio _dio;
  static const _apiKey = '7d97d894de2f309676414f1851399cf7';

  DioWeatherService() {
    // 1. ตั้งค่า BaseOptions (กำหนด Base URL และ Timeout)
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.openweathermap.org/data/2.5',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    // 2. เพิ่ม Interceptor สำหรับดักจับ Log การส่ง/รับข้อมูลใน Console
    _dio.interceptors.add(
      LogInterceptor(
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Weather> fetchWeather(String city) async {
    try {
      // Dio รองรับ queryParameters โดยตรง ไม่ต้องต่อ String ใน URL เอง
      final response = await _dio.get(
        '/weather',
        queryParameters: {
          'q': city,
          'appid': _apiKey,
          'units': 'metric',
          'lang': 'th',
        },
      );

      // Dio แปลง JSON เป็น Map<String, dynamic> ให้อัตโนมัติผ่าน response.data
      return Weather.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      // 3. การจัดการ Error แบบรวมศูนย์ผ่าน DioException
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          throw Exception('ไม่พบข้อมูลเมืองที่ค้นหา กรุณาตรวจสอบชื่อเมืองอีกครั้ง');
        } else if (e.response?.statusCode == 401) {
          throw Exception('API Key ไม่ถูกต้อง หรือไม่ได้รับอนุญาต');
        }
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('การเชื่อมต่อหมดเวลา กรุณาลองใหม่อีกครั้ง');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้');
      }

      throw Exception('เกิดข้อผิดพลาดจาก Dio: ${e.message}');
    }
  }
}