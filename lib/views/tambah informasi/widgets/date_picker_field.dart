import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyleConstant.secondaryTextStyle),
        const SizedBox(height: 8),
        Container(
          height: 49,
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstant.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () => _showDatePicker(context),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate),
                      style: TextStyleConstant.primaryTextStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Icon(Icons.calendar_today, color: ColorConstant.borderColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                dp.DayPicker.single(
                  selectedDate: selectedDate,
                  onChanged: (date) {
                    onDateSelected(date);
                    Navigator.pop(context);
                  },
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  datePickerStyles: dp.DatePickerRangeStyles(
                    selectedDateStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedSingleDateDecoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Tutup',
                        style: TextStyle(color: ColorConstant.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 