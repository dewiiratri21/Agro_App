import 'package:agro_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/views/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class StatusTabWidget extends StatelessWidget {
  final HomeController controller;

  const StatusTabWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol Belum Selesai
          _buildTabButton(
            context: context, 
            isSelected: !controller.isCompletedSelected.value,
            label: 'Belum Selesai',
            onTap: () => controller.toggleTaskStatus(false),
          ),
          // Tombol Selesai
          _buildTabButton(
            context: context, 
            isSelected: controller.isCompletedSelected.value,
            label: 'Selesai',
            onTap: () => controller.toggleTaskStatus(true),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required BuildContext context,
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.44,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstant.primaryColor.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : ColorConstant.borderColor,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyleConstant.primaryTextStyle.copyWith(
              color: isSelected
                  ? ColorConstant.primaryColor
                  : Colors.black,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
} 