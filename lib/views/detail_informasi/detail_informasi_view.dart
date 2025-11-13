import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/global_widgets/custom_appbar_global_widget.dart';
import 'package:agro_app/views/detail_informasi/controllers/detail_informasi_controller.dart';
import 'package:agro_app/views/detail_informasi/widgets/info_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailInformasiView extends StatelessWidget {
  DetailInformasiView({super.key});

  final DetailInformasiController controller = Get.put(DetailInformasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarGlobalWidget(
                  title: 'Detail Informasi',
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Nama Desa",
                  value: controller.namaDesa.value,
                )),
                const SizedBox(height: 16),
                Obx(() => InfoField(
                  label: "Tanggal Penanaman",
                  value: DateFormat('dd MMMM yyyy', 'id_ID').format(
                    DateTime.parse(controller.tanggalPenanaman.value)
                  ),
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Luas Lahan",
                  value: controller.luasLahan.value,
                  showUnit: true,
                  unit: "Ha",
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Luas Tanam",
                  value: controller.luasTanam.value,
                  showUnit: true,
                  unit: "Ha",
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Luas Panen",
                  value: controller.luasPanen.value,
                  showUnit: true,
                  unit: "Ha",
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Luas Olah Lahan",
                  value: controller.luasOlahLahan.value,
                  showUnit: true,
                  unit: "Ha",
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Stading Crop",
                  value: controller.stadingCrop.value,
                  showUnit: true,
                  unit: "Ha",
                  backgroundColor: ColorConstant.grayColor2,
                )),
                const SizedBox(height: 24),
                Obx(() => InfoField(
                  label: "Luas Bero",
                  value: controller.luasBero.value,
                  showUnit: true,
                  unit: "Ha",
                  backgroundColor: ColorConstant.grayColor2,
                )),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.tandaiSelesai,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          "Tandai Selesai",
                          style: TextStyleConstant.primaryTextStyle.copyWith(
                            fontSize: 14,
                            color: ColorConstant.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  )),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}