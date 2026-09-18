class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // 1. ดึง object ย่อย 'main' และแปลงค่าอุณหภูมิทั้งสองตัวผ่าน num -> toDouble()
    final main = json['main'] as Map<String, dynamic>;
    final temperature = (main['temp'] as num).toDouble();
    final feelsLike = (main['feels_like'] as num).toDouble();

    // 2. แปลง 'weather' เป็น List<dynamic> แล้วดึงสมาชิกตัวแรกมาแปลงเป็น Map เพื่อหา description
    final weatherList = json['weather'] as List<dynamic>;
    final firstWeather = weatherList.first as Map<String, dynamic>;
    final description = firstWeather['description'] as String;

    // 3. ดึงชื่อเมืองจาก key 'name' ที่ระดับบนสุด
    final cityName = json['name'] as String;

    // 4. ส่งคืนคลาส Weather พร้อมค่าทั้ง 4 ฟิลด์
    return Weather(
      cityName: cityName,
      temperature: temperature,
      description: description,
      feelsLike: feelsLike,
    );
  }
}