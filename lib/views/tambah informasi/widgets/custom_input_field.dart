import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String) onChanged;
  final bool showUnit;
  final String? unit;
  final bool isReadOnly;
  final Color? backgroundColor;
  final bool isNumericOnly;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.showUnit = false,
    this.unit,
    this.isReadOnly = false,
    this.backgroundColor,
    this.isNumericOnly = false,
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
            color: backgroundColor,
            border: Border.all(color: ColorConstant.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: isReadOnly,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyleConstant.primaryTextStyle.copyWith(
                      fontSize: 14,
                      color: ColorConstant.grayColor3,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  ),
                  onChanged: onChanged,
                  inputFormatters: isNumericOnly
                      ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                      : null,
                  keyboardType: isNumericOnly
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : null,
                ),
              ),
              if (showUnit && unit != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: ColorConstant.grayColor,
                    border: Border.all(color: ColorConstant.borderColor),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    unit!,
                    style: TextStyleConstant.primaryTextStyle.copyWith(fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
} 