import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantCardWidget extends StatelessWidget {
  final String title;
  final Map<String, String> details;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onViewDetail;
  final bool status;
  final Function(bool) onStatusChanged;

  const PlantCardWidget({
    Key? key,
    required this.title,
    required this.details,
    this.onEdit,
    this.onDelete,
    this.onViewDetail,
    required this.status,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 442),
      decoration: BoxDecoration(
        color: ColorConstant.primaryCarbonColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyleConstant.primaryTextStyle.copyWith(
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: onEdit,
                  child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: onDelete,
                  child: SvgPicture.asset(
                    'assets/icons/trash.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.secondaryCarbonColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildDetailsList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: onViewDetail,
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Lihat Detail',
                    style: TextStyleConstant.primaryTextStyle.copyWith(
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetailsList() {
    final List<Widget> detailWidgets = [];

    details.forEach((key, value) {
      // Tambahkan row untuk setiap pasangan key-value
      detailWidgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              key,
              style: TextStyleConstant.secondaryTextStyle.copyWith(
                color: ColorConstant.whiteColor,
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: TextStyleConstant.primaryTextStyle.copyWith(
                color: ColorConstant.whiteColor,
              ),
            ),
          ],
        ),
      );

      // Tambahkan spacer dan divider (kecuali untuk item terakhir)
      if (key != details.keys.last) {
        detailWidgets.add(SizedBox(height: 12));
        detailWidgets.add(
          Divider(
            color: ColorConstant.dividerCarbonColor,
          ),
        );
        detailWidgets.add(SizedBox(height: 12));
      }
    });

    return detailWidgets;
  }
} 