import 'package:flutter/material.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/views/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateSelectorWidget extends StatelessWidget {
  final HomeController controller;

  const DateSelectorWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedMonth = DateFormat(
        'MMMM yyyy',
        'id_ID',
      ).format(controller.selectedDate.value);
      return Row(
        children: [
          Text(
            selectedMonth,
            style: TextStyleConstant.secondaryTextStyle,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              // Previous month
              final newDate = DateTime(
                controller.selectedDate.value.year,
                controller.selectedDate.value.month - 1,
                1,
              );
              controller.setSelectedDate(newDate);
            },
            child: Icon(Icons.arrow_back_ios_new, size: 20),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              // Next month
              final newDate = DateTime(
                controller.selectedDate.value.year,
                controller.selectedDate.value.month + 1,
                1,
              );
              controller.setSelectedDate(newDate);
            },
            child: Icon(Icons.arrow_forward_ios, size: 20),
          ),
        ],
      );
    });
  }
} 