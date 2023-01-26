import 'package:arduino_controller/resources/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  ApiService _apiService=ApiService();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xff605F5F),
      appBar: AppBar(
        backgroundColor: const Color(0xff605F5F),
        foregroundColor: Colors.white,
        elevation: 0.0,
        leading: null,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.arrow_back_ios_new_rounded),
        //   splashRadius: 20.0,
        // ),
        title: const Text('Arduino Controller'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //car image
            buildImage(),
            Expanded(
              child: buildController(),
            )
            //controller
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Image.asset('assets/images/robot_car.png');
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
        ),
        Positioned(
          top: 80.0,
          child: forwardButton(),
        ),
        Positioned(
          left: 15.0,
          child: leftButton(),
        ),
        Positioned(
          bottom: 80.0,
          child: backwardButton(),
        ),
        Positioned(
          right: 15.0,
          child: rightButton(),
        ),
        pauseButton(),
      ],
    );
  }

  Widget forwardButton() {
    return IconButton(
      onPressed: () async {
        HapticFeedback.mediumImpact();
      await  _apiService.changeDeviceMovement(movement: 'Forward');

      },
      icon:const Icon(Icons.keyboard_arrow_up_rounded),
      color:const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget leftButton() {
    return IconButton(
      onPressed: ()async {
        HapticFeedback.mediumImpact();
       await _apiService.changeDeviceMovement(movement: 'Left');
      },
      icon:const Icon(Icons.keyboard_arrow_left_rounded),
      color:const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget backwardButton() {
    return IconButton(
      onPressed: () async{
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Backward');
      },
      icon:const Icon(Icons.keyboard_arrow_down_rounded),
      color:const Color(0xffD9D9D9),
      iconSize: 45.0,
    );
  }

  Widget rightButton() {
    return IconButton(
      onPressed: () async{
        HapticFeedback.mediumImpact();
        await _apiService.changeDeviceMovement(movement: 'Right');
      },
      icon:const Icon(Icons.keyboard_arrow_right_rounded),
      color:const Color(0xffD9D9D9),
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
            onPressed: () async{
              HapticFeedback.mediumImpact();
              await _apiService.changeDeviceMovement(movement: 'Stop');
            },
            icon:const Icon(Icons.pause_rounded),
            color:const Color(0xffD9D9D9),
            iconSize: 40.0,
          ),
        ),
      ],
    );
  }
}
