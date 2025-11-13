import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LuasBeroField extends StatelessWidget {
  final bool isEnabled;
  final String value;
  final Function(bool) onToggle;
  final bool canCalculate;

  const LuasBeroField({
    super.key,
    required this.isEnabled,
    required this.value,
    required this.onToggle,
    required this.canCalculate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Luas Bero", style: TextStyleConstant.secondaryTextStyle),
            const Spacer(),
            Transform.scale(
              scale: 0.7,
              child: Switch(
                value: isEnabled,
                activeColor: ColorConstant.primaryColor,
                onChanged: onToggle,
              ),
            ),
          ],
        ),
        Container(
          height: 49,
          decoration: BoxDecoration(
            color: ColorConstant.grayColor2,
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
                      color:
                          canCalculate && isEnabled
                              ? ColorConstant.primaryCarbonColor
                              : ColorConstant.grayColor3,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: ColorConstant.grayColor,
                  border: Border.all(color: ColorConstant.borderColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  "Ha",
                  style: TextStyleConstant.primaryTextStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
