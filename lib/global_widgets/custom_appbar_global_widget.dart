import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';

class CustomAppBarGlobalWidget extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onPressed;
  const CustomAppBarGlobalWidget({
    super.key,
    required this.title,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorConstant.borderColor),
              ),
              child: IconButton(onPressed: onPressed, icon: Icon(icon)),
            ),
            const SizedBox(width: 12),
            Text(title, style: TextStyleConstant.secondaryTextStyle),
          ],
        ),
      ],
    );
  }
}
