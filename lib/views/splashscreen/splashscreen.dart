import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/views/splashscreen/controllers/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(SplashscreenController());
    
    return Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: ColorConstant.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/plant.svg',
              width: 50,
              height: 50,
            ),
          ),
        ),
      ),
    );
  }
}