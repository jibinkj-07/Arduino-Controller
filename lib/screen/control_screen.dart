import 'package:arduino_controller/models/arduino_model.dart';
import 'package:arduino_controller/resources/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final ApiService _apiService = ApiService();
  ArduinoModel? _arduinoData;
  bool _isAuto = false;
  bool _isVacuum = false;
  int _speed = 0;

  Future<void> getData() async {
    final data = await _apiService.getInfo();
    setState(() {
      _arduinoData = data;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('controller is $_arduinoData');
    if (_arduinoData != null) {
      _isAuto = _arduinoData!.auto ? true : false;
      _isVacuum = _arduinoData!.isVacuum ? true : false;
      _speed = _arduinoData!.speed;
    }


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0.0,
        leading: null,
        title: const Text('Arduino Controller'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _arduinoData != null
                  ? const Text(
                      'Connected',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'Not connected',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
              //car image
              buildImage(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: const Color(0xff3C3C3C),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildAutoToggler(),
                    buildVacuumToggler(),
                  ],
                ),
              ),
              const SizedBox(height: 30.0),
              buildController(),
              const SizedBox(height: 30.0),
              Text(
                'Speed $_speed',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Slider(
                    min: 0.0,
                    max: 225.0,
                    label: _speed.toString(),
                    value: double.parse(_speed.toString()),
                    onChanged: (value) async{
                      await _apiService.changeSpeed(speed: value.toInt());
                      getData();
                    }),
              )
              //controller
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset(
      'assets/images/robot_car.png',
      height: 200.0,
    );
  }

  Widget buildAutoToggler() {
    return Row(
      children: [
        const Text(
          "Auto",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(width: 10.0),
        Switch(
            value: _isAuto,
            onChanged: (value) async {
              await _apiService.changeAutoMode(isAuto: !_isAuto);
              await getData();
            }),
      ],
    );
  }

  Widget buildVacuumToggler() {
    return Row(
      children: [
        const Text(
          "Vacuum",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(width: 10.0),
        Switch(
            value: _isVacuum,
            onChanged: (value) async {
              await _apiService.changeVacuumMode(isVacuum: !_isVacuum);
              await getData();
            }),
      ],
    );
  }

  Widget buildController() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 250,
          height: 250,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff646464),
                Color(0xff3C3C3C),
                Color(0xff1E1E1E),
                Color(0xff141414),
              ],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          width: 240,
          height: 240,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        Container(
          width: 230,
          height: 230,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff141414),
                Color(0xff1E1E1E),
                Color(0xff3C3C3C),
                Color(0xff646464),
              ],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          width: 220,
          height: 220,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0x88000000),
                Color(0xff605F5F),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                child: forwardButton(),
              ),
              Positioned(
                left: 0,
                child: leftButton(),
              ),
              Positioned(
                bottom: 0,
                child: backwardButton(),
              ),
              Positioned(
                right: 0,
                child: rightButton(),
              ),
            ],
          ),
        ),
        pauseButton(),
      ],
    );
  }

  Widget forwardButton() {
    return IconButton(
      onPressed: () async {
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Forward');
      },
      icon: const Icon(Icons.keyboard_arrow_up_rounded),
      color: const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget leftButton() {
    return IconButton(
      onPressed: () async {
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Left');
      },
      icon: const Icon(Icons.keyboard_arrow_left_rounded),
      color: const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget backwardButton() {
    return IconButton(
      onPressed: () async {
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Backward');
      },
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      color: const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget rightButton() {
    return IconButton(
      onPressed: () async {
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Right');
      },
      icon: const Icon(Icons.keyboard_arrow_right_rounded),
      color: const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget pauseButton() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff646464),
                Color(0xff3C3C3C),
                Color(0xff1E1E1E),
                Color(0xff141414),
              ],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          width: 95,
          height: 95,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xff141414),
                Color(0xff1E1E1E),
                Color(0xff3C3C3C),
                Color(0xff646464),
              ],
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          width: 85,
          height: 85,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                colors: [
                  Color(0x11000000),
                  Color(0xff605F5F),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 1.0]),
          ),
          child: IconButton(
            onPressed: () async {
              HapticFeedback.mediumImpact();
              await _apiService.changeDeviceMovement(movement: 'Stop');
            },
            icon: const Icon(Icons.pause_rounded),
            color: const Color(0xffD9D9D9),
            iconSize: 40.0,
          ),
        ),
      ],
    );
  }
}
