// ignore_for_file: use_super_parameters

import 'package:agro_app/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/views/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateListWidget extends StatefulWidget {
  final HomeController controller;

  const DateListWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<DateListWidget> createState() => _DateListWidgetState();
}

class _DateListWidgetState extends State<DateListWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Trigger scroll setelah build pertama
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToSelectedDate(),
    );
  }

  void _scrollToSelectedDate() {
    if (_hasScrolled) return;
    final dates = _getDatesForMonth();
    final selectedDay = widget.controller.selectedDay.value;
    final index = dates.indexWhere(
      (date) =>
          date.year == selectedDay.year &&
          date.month == selectedDay.month &&
          date.day == selectedDay.day,
    );
    if (index != -1 && _scrollController.hasClients) {
      _scrollController.animateTo(
        (index * 69.0).toDouble(), // 61(width) + 8(padding)
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      _hasScrolled = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      child: Obx(() {
        final dates = _getDatesForMonth();
        final selectedDay = widget.controller.selectedDay.value;
        final now = DateTime.now();
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollToSelectedDate(),
        );
        return ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: dates.length,
          itemBuilder: (context, index) {
            final date = dates[index];
            final dayName = DateFormat(
              'E',
              'id_ID',
            ).format(date).substring(0, 3);

            // Check if it's today
            final isToday =
                date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;

            // Check if it's selected
            final isSelected =
                date.year == selectedDay.year &&
                date.month == selectedDay.month &&
                date.day == selectedDay.day;

            return GestureDetector(
              onTap: () {
                widget.controller.setSelectedDay(date);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 61,
                  height: 73,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? ColorConstant.primaryColor.withOpacity(0.2)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          isToday
                              ? ColorConstant.primaryColor
                              : ColorConstant.borderColor,
                      width: isToday ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName,
                        style: TextStyleConstant.primaryTextStyle.copyWith(
                          color:
                              isSelected || isToday
                                  ? ColorConstant.primaryColor
                                  : Colors.black,
                          fontWeight:
                              isSelected || isToday
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        date.day.toString(),
                        style: TextStyleConstant.secondaryTextStyle.copyWith(
                          color:
                              isSelected || isToday
                                  ? ColorConstant.primaryColor
                                  : Colors.black,
                          fontWeight:
                              isSelected || isToday
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  List<DateTime> _getDatesForMonth() {
    final selectedDate = widget.controller.selectedDate.value;
    final lastDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    );

    final List<DateTime> dates = [];
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      dates.add(DateTime(selectedDate.year, selectedDate.month, i));
    }
    return dates;
  }
}
