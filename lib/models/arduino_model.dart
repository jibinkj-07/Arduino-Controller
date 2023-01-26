class ArduinoModel{
  late int id;
  late String movement;
  late int battery;
  late bool isCharging;
  late bool isVacuum;
  late int speed;

  ArduinoModel.fromJson(jsonData){
    id=jsonData['id'];
    movement=jsonData['Movement'];
    battery=jsonData['Battery_Level'];
    isCharging=jsonData['Charging_Status'];
    isVacuum=jsonData['Vacuum'];
    speed=jsonData['speed'];
  }
}