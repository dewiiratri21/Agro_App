// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:agro_app/utils/supabase_services.dart';
import 'package:agro_app/views/splashscreen/controllers/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditInformasiController extends GetxController {
  final SupabaseServices _supabaseServices = SupabaseServices();
  final SplashscreenController _splashscreenController =
      SplashscreenController();

  final namaDesaController = TextEditingController();
  final luasLahanController = TextEditingController();
  final luasTanamController = TextEditingController();
  final luasPanenController = TextEditingController();
  final luasOlahLahanController = TextEditingController();

  final namaDesa = ''.obs;
  final luasLahan = ''.obs;
  final luasTanam = ''.obs;
  final luasPanen = ''.obs;
  final luasOlahLahan = ''.obs;
  final selectedDate = DateTime.now().obs;
  final isLuasBeroEnabled = false.obs;
  final isLoading = false.obs;
  final tanamanId = 0.obs;
  final originalDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final data = Get.arguments as Map<String, dynamic>;
      initializeData(data);
    }
  }

  void initializeData(Map<String, dynamic> data) {
    tanamanId.value = data['tanaman_id'];
    namaDesa.value = data['nama_desa'];
    namaDesaController.text = data['nama_desa'];
    originalDate.value = data['tanggal_penanaman'];
    selectedDate.value = DateTime.parse(data['tanggal_penanaman']);
    luasLahan.value = data['luas_lahan'].toString();
    luasLahanController.text = data['luas_lahan'].toString();
    luasTanam.value = data['luas_tanam'].toString();
    luasTanamController.text = data['luas_tanam'].toString();
    luasPanen.value = data['luas_panen'].toString();
    luasPanenController.text = data['luas_panen'].toString();
    luasOlahLahan.value = data['luas_olah_lahan'].toString();
    luasOlahLahanController.text = data['luas_olah_lahan'].toString();
    isLuasBeroEnabled.value = data['luas_bero'] != null;
  }

  String get formattedDate {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate.value);
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    Get.back();
  }

  void toggleLuasBero(bool value) {
    isLuasBeroEnabled.value = value;
  }

  bool get isLuasLahanFilled {
    return luasLahan.value.isNotEmpty && luasLahan.value.isNotEmpty;
  }

  bool get isLuasTanamPanenFilled {
    return luasTanam.value.isNotEmpty && luasPanen.value.isNotEmpty;
  }

  bool get canCalculateLuasBero {
    return luasOlahLahan.value.isNotEmpty && luasTanam.value.isNotEmpty;
  }

  String get stadingCropHintText {
    if (!isLuasTanamPanenFilled) return "Akan terisi otomatis";

    try {
      final tanam = double.parse(luasTanam.value);
      final panen = double.parse(luasPanen.value);
      final result = tanam - panen;
      return result.toStringAsFixed(2);
    } catch (e) {
      return "Error kalkulasi";
    }
  }

  String get luasBeroHintText {
    if (!canCalculateLuasBero || !isLuasBeroEnabled.value)
      return "Akan terisi otomatis";

    try {
      final olahLahan = double.parse(luasOlahLahan.value);
      final tanam = double.parse(luasTanam.value);
      final result = olahLahan - tanam;
      return result.toStringAsFixed(2);
    } catch (e) {
      return "Error kalkulasi";
    }
  }

  Future<void> updateData() async {
    if (namaDesa.value.isEmpty) {
      Get.snackbar('Error', 'Nama Desa tidak boleh kosong');
      return;
    }
    if (luasLahan.value.isEmpty) {
      Get.snackbar('Error', 'Luas lahan tidak boleh kosong');
      return;
    }

    if (luasTanam.value.isEmpty) {
      Get.snackbar('Error', 'Luas tanam tidak boleh kosong');
      return;
    }

    if (luasPanen.value.isEmpty) {
      Get.snackbar('Error', 'Luas panen tidak boleh kosong');
      return;
    }

    if (luasOlahLahan.value.isEmpty) {
      Get.snackbar('Error', 'Luas olah lahan tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true;
      final deviceId = await _splashscreenController.getdeviceId();

      await _supabaseServices.updateDataTanaman(
        tanamanId: tanamanId.value,
        deviceId: deviceId ?? "",
        namaDesa: namaDesa.value,
        tanggalPenanaman: originalDate.value,
        luasLahan: luasLahan.value,
        luasTanam: luasTanam.value,
        luasPanen: luasPanen.value,
        luasOlahLahan: luasOlahLahan.value,
        stadingCrop: stadingCropHintText,
        luasBero: isLuasBeroEnabled.value ? luasBeroHintText : null,
        status: false,
      );

      Get.back(result: true);
      Get.snackbar('Sukses', 'Data berhasil diperbarui');
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    namaDesaController.dispose();
    luasLahanController.dispose();
    luasTanamController.dispose();
    luasPanenController.dispose();
    luasOlahLahanController.dispose();
    super.onClose();
  }
}
