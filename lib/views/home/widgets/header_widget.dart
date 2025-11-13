import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/utils/getx_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: Container(
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset('assets/icons/plant.svg'),
      ),
      title: Text(
        'Halo, Selamat datang!',
        style: TextStyleConstant.primaryTextStyle,
      ),
      trailing: SizedBox(
        width: 104, // 40 + 24 + 40
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // // Tombol Notifikasi
            // GestureDetector(
            //   onTap: () => Get.toNamed(GetxRoutes.notifikasi),
            //   child: Container(
            //     width: 40,
            //     height: 40,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: ColorConstant.borderColor),
            //     ),
            //     padding: const EdgeInsets.all(8.0),
            //     child: SvgPicture.asset('assets/icons/notification.svg'),
            //   ),
            // ),
            const SizedBox(width: 10),

            // Tombol Report
            GestureDetector(
              onTap: () => Get.toNamed(GetxRoutes.report),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorConstant.borderColor),
                ),
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/icons/report.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
