import 'package:flutter/material.dart';
import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';

class NotifikasiView extends StatelessWidget {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data notifikasi
    final Map<String, List<Map<String, String>>> notifikasi = {
      '18 Mei 2025': [
        {'title': 'Tanam pohon Ganja'},
        {'title': 'Tanam pohon Shabu'},
      ],
      '15 Mei 2025': [
        {'title': 'Tanam pohon Ganja'},
        {'title': 'Tanam pohon Shabu'},
        {'title': 'Tanam pohon Shabu'},
      ],
    };

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifikasi', style: TextStyleConstant.secondaryTextStyle),
        centerTitle: false,
        elevation: 0,
        backgroundColor: ColorConstant.whiteColor,
        foregroundColor: ColorConstant.primaryCarbonColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          ...notifikasi.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: ColorConstant.grayColor3,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: TextStyleConstant.secondaryTextStyle.copyWith(
                        color: ColorConstant.primaryCarbonColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...entry.value.asMap().entries.map((e) {
                  final notif = e.value;
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorConstant.grayColor,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.eco,
                              color: ColorConstant.primaryColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ada jadwal untuk hari ini!',
                                  style: TextStyleConstant.secondaryTextStyle
                                      .copyWith(fontSize: 15),
                                ),
                                Text(
                                  '"${notif['title']}" telah diatur untuk hari ini!',
                                  style: TextStyleConstant.primaryTextStyle
                                      .copyWith(
                                        fontSize: 13,
                                        color: ColorConstant.grayColor3,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          color: ColorConstant.grayColor3,
                          thickness: 0.5,
                          height: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
