import 'dart:convert';
import 'package:arduino_controller/models/arduino_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String localIp = '';
  static const String onlineIp = '';

  Future<ArduinoModel?> getInfo() async {
    final url = Uri.parse('http://$localIp/dume/1/');
    ArduinoModel? data;
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 2),
          onTimeout: () async {

        return http.Response('Error', 404);
      });
      if (response.statusCode == 200) {
        data = ArduinoModel.fromJson(json.decode(response.body));
        return data;
      }{
        return    await getInfoWithStatic();
      }
    } catch (e) {
      return await getInfoWithStatic();
    }
  }

  Future<ArduinoModel?> getInfoWithStatic() async {
    final url = Uri.parse('http://$onlineIp/dume/1/');
    ArduinoModel? data;
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10),
          onTimeout: () {
        //call with static
        return http.Response('Error', 404);
      });
      if (response.statusCode == 200) {
        data = ArduinoModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print('error from static ip get $e');
    }
    return data;
  }

  Future<void> changeDeviceMovement({required String movement}) async {
    final url = Uri.parse('http://$localIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Movement': movement,
          },
        ),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () async {
        await changeDeviceMovementWithOnlineIp(movement: movement);
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      return await changeDeviceMovementWithOnlineIp(movement: movement);
    }
  }

  Future<void> changeDeviceMovementWithOnlineIp(
      {required String movement}) async {
    print('called online ip with $movement');

    final url = Uri.parse('http://$onlineIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Movement': movement,
          },
        ),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () async {
        return http.Response('Error', 404);
      });
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future<void> changeAutoMode({required bool isAuto}) async {
    final url = Uri.parse('http://$localIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Auto': isAuto,
          },
        ),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () async {
        await changeAutoModeWithStatic(isAuto: isAuto);
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      return await changeAutoModeWithStatic(isAuto: isAuto);
    }
  }

  Future<void> changeAutoModeWithStatic({required bool isAuto}) async {
    final url = Uri.parse('http://$onlineIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Auto': isAuto,
          },
        ),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () async {
        return http.Response('Error', 404);
      });
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future<void> changeVacuumMode({required bool isVacuum}) async {
    final url = Uri.parse('http://$localIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Vacuum': isVacuum,
          },
        ),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () async {
        await changeVacuumModeWithStatic(isVacuum: isVacuum);
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      return await changeVacuumModeWithStatic(isVacuum: isVacuum);
    }
  }

  Future<void> changeVacuumModeWithStatic({required bool isVacuum}) async {
    final url = Uri.parse('http://$onlineIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Vacuum': isVacuum,
          },
        ),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () async {
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future<void> changeSpeed({required int speed}) async {
    final url = Uri.parse('http://$localIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Speed': speed,
          },
        ),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () async {
        await changeSpeedWithStatic(speed: speed);
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      return await changeSpeedWithStatic(speed: speed);
    }
  }

  Future<void> changeSpeedWithStatic({required int speed}) async {
    final url = Uri.parse('http://$onlineIp/dume/1/');
    try {
      final response = await http
          .put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'Speed': speed,
          },
        ),
      )
          .timeout(const Duration(seconds: 10), onTimeout: () async {
        return http.Response('Error', 404);
      });
      print('status is ${response.body}');
    } catch (e) {
      print('ERROR:$e');
    }
  }
}
