import 'services/weather_service.dart';

void main() async {
  final service = WeatherService();

  print('=== เริ่มการทดสอบ WeatherService ===\n');

  // กรณีที่ 1: ค้นหาเมืองที่มีจริง (statusCode == 200)
  try {
    print('[เคส 1] ทดสอบค้นหา Bangkok (200 OK)...');
    final weather = await service.fetchWeather('Bangkok');
    print('✅ ดึงข้อมูลสำเร็จ: ${weather.cityName} | อุณหภูมิ: ${weather.temperature}°C | ${weather.description}');
  } catch (e) {
    print('❌ เกิดข้อผิดพลาด: $e');
  }

  print('\n----------------------------------------\n');

  // กรณีที่ 2: ค้นหาเมืองที่ไม่มีอยู่จริง (statusCode == 404)
  try {
    print('[เคส 2] ทดสอบค้นหาเมืองไม่มีจริง CityNotFound123 (404 Not Found)...');
    final weather = await service.fetchWeather('CityNotFound123');
    print('✅ ดึงข้อมูลสำเร็จ: ${weather.cityName}');
  } catch (e) {
    print('✅ ดักจับ Error 404 สำเร็จ: $e');
  }
}