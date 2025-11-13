import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final bool showUnit;
  final String? unit;
  final Color? backgroundColor;

  const InfoField({
    super.key,
    required this.label,
    required this.value,
    this.showUnit = false,
    this.unit,
    this.backgroundColor,
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
            color: backgroundColor ?? ColorConstant.whiteColor,
            border: Border.all(color: ColorConstant.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    value,
                    style: TextStyleConstant.primaryTextStyle.copyWith(
                      fontSize: 14,
                      color: ColorConstant.primaryCarbonColor,
                    ),
                  ),
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