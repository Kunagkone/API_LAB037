import 'dart:convert';
import 'models/item.dart';

void main() {
  // ตัวอย่าง JSON ข้อมูลสินค้าใน Campus Marketplace
  const String sampleJson = '''
  {
    "id": 501,
    "title": "หนังสือเรียน Mobile Application Development (Flutter)",
    "price": 280.00,
    "description": "สภาพดีมาก 98% ไร้รอยขีดเขียน นัดรับได้ที่ศูนย์อาหารกลาง",
    "category": "หนังสือและอุปกรณ์การเรียน",
    "imageUrl": "https://picsum.photos/200/300"
  }
  ''';

  // แปลง JSON String เป็น Map
  final Map<String, dynamic> jsonMap = jsonDecode(sampleJson);

  // ทดสอบเรียก Item.fromJson()
  final item = Item.fromJson(jsonMap);

  // แสดงผลค่าทั้ง 6 ฟิลด์ออกทาง Console
  print('==================================================');
  print('  [ทดสอบ Checkpoint 7.1] Item.fromJson()');
  print('==================================================');
  print('1. Field [id]          : ${item.id}');
  print('2. Field [title]       : ${item.title}');
  print('3. Field [price]       : ${item.price} บาท');
  print('4. Field [description] : ${item.description}');
  print('5. Field [category]    : ${item.category}');
  print('6. Field [imageUrl]    : ${item.imageUrl}');
  print('==================================================');
}