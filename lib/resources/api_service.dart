import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String localIp = '192.168.1.18';
  static const String onlineIp='117.247.181.113:8000';

  Future<void> changeDeviceMovement({required String movement}) async {
    final url = Uri.parse('http://$localIp/dume/1/');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Movement': movement,
          },
        ),
      ).timeout(const Duration(seconds: 2),onTimeout: () async {
      await  changeDeviceMovementWithOnlineIp(movement: movement);
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');

    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future<void> changeDeviceMovementWithOnlineIp({required String movement}) async {
    print('called online ip with $movement');

    final url = Uri.parse('http://$onlineIp/dume/1/');
    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Movement': movement,
          },
        ),
      ).timeout(const Duration(seconds: 10),onTimeout: () async {
        return http.Response('Error', 404);
      });

    } catch (e) {
      print('ERROR:$e');
    }
  }
}


