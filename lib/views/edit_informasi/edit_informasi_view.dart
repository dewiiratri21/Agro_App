import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:agro_app/global_widgets/custom_appbar_global_widget.dart';
import 'package:agro_app/views/edit_informasi/controllers/edit_informasi_controller.dart';
import 'package:agro_app/views/edit_informasi/widgets/custom_input_field.dart';
import 'package:agro_app/views/edit_informasi/widgets/date_picker_field.dart';
import 'package:agro_app/views/edit_informasi/widgets/luas_bero_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditInformasiView extends StatelessWidget {
  EditInformasiView({super.key});

  final EditInformasiController controller = Get.put(EditInformasiController());

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
                  title: 'Edit Informasi',
                  icon: Icons.arrow_back,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Nama Desa",
                  hintText: "Ketik disini...",
                  onChanged: (value) => controller.namaDesa.value = value,
                  controller: controller.namaDesaController,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => DatePickerField(
                    label: "Tanggal Penanaman",
                    selectedDate: controller.selectedDate.value,
                    onDateSelected: controller.setDate,
                  ),
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Luas Lahan",
                  hintText: "Ketik disini...",
                  onChanged: (value) => controller.luasLahan.value = value,
                  showUnit: true,
                  unit: "Ha",
                  controller: controller.luasLahanController,
                  isNumericOnly: true,
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Luas Tanam",
                  hintText: "Ketik disini...",
                  onChanged: (value) => controller.luasTanam.value = value,
                  showUnit: true,
                  unit: "Ha",
                  controller: controller.luasTanamController,
                  isNumericOnly: true,
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Luas Panen",
                  hintText: "Ketik disini...",
                  onChanged: (value) => controller.luasPanen.value = value,
                  showUnit: true,
                  unit: "Ha",
                  controller: controller.luasPanenController,
                  isNumericOnly: true,
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Luas Olah Lahan",
                  hintText: "Ketik disini...",
                  onChanged: (value) => controller.luasOlahLahan.value = value,
                  showUnit: true,
                  unit: "Ha",
                  controller: controller.luasOlahLahanController,
                  isNumericOnly: true,
                ),
                const SizedBox(height: 24),
                CustomInputField(
                  label: "Stading Crop",
                  hintText: "Akan terisi otomatis",
                  onChanged: (_) {},
                  showUnit: true,
                  unit: "Ha",
                  isReadOnly: true,
                  backgroundColor: ColorConstant.grayColor2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Akan terisi otomatis apabila mengisi luas tanam & Panen",
                  style: TextStyleConstant.primaryTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => LuasBeroField(
                    isEnabled: controller.isLuasBeroEnabled.value,
                    value: controller.luasBeroHintText,
                    onToggle: controller.toggleLuasBero,
                    canCalculate: controller.canCalculateLuasBero,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.updateData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          controller.isLoading.value
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                "Simpan Perubahan",
                                style: TextStyleConstant.primaryTextStyle
                                    .copyWith(
                                      fontSize: 14,
                                      color: ColorConstant.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                    ),
                  ),
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
