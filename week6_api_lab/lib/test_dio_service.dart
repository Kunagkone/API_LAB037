import 'services/dio_weather_service.dart';

void main() async {
  final dioService = DioWeatherService();

  print('=== [Dio Test Case 1] ค้นหา Bangkok (200 OK) ===');
  try {
    final weather = await dioService.fetchWeather('Bangkok');
    print('✅ ดึงข้อมูลสำเร็จ: ${weather.cityName} | อุณหภูมิ: ${weather.temperature}°C | ${weather.description}\n');
  } catch (e) {
    print('❌ Error: $e\n');
  }

  print('=== [Dio Test Case 2] ค้นหาเมืองไม่มีจริง CityNotFound123 (404) ===');
  try {
    await dioService.fetchWeather('CityNotFound123');
  } catch (e) {
    print('✅ ดักจับ Error 404 สำเร็จ: $e\n');
  }
}