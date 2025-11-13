import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:agro_app/utils/supabase_services.dart';
import 'package:agro_app/views/splashscreen/controllers/splashscreen_controller.dart';

class TambahInformasiController extends GetxController {
  final SupabaseServices _supabaseServices = SupabaseServices();
  final SplashscreenController _splashscreenController = Get.put(SplashscreenController());

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString luasLahan = ''.obs;
  final RxString luasTanam = ''.obs;
  final RxString luasPanen = ''.obs;
  final RxString luasOlahLahan = ''.obs;
  final RxBool isLuasBeroEnabled = false.obs;
  final RxString namaDesa = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool status = false.obs; // Default status: Belum Selesai
  
  String get formattedDate {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(selectedDate.value);
  }

  String get formattedDateForDB {
    return DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  bool get isLuasTanamPanenFilled => 
    luasTanam.value.isNotEmpty && luasPanen.value.isNotEmpty;

  bool get canCalculateLuasBero =>
    luasOlahLahan.value.isNotEmpty && luasTanam.value.isNotEmpty;

  String get stadingCropHintText => 
    isLuasTanamPanenFilled ? calculateStadingCrop() : "Ketik luas tanaman & panen dahulu";

  String get luasBeroHintText {
    if (!isLuasBeroEnabled.value) return "-";
    if (!canCalculateLuasBero) return "Isi luas olah lahan & luas tanam dahulu";
    return calculateLuasBero();
  }

  String calculateStadingCrop() {
    try {
      double luas = double.parse(luasTanam.value);
      return luas.toStringAsFixed(2);
    } catch (e) {
      return "0.00";
    }
  }

  String calculateLuasBero() {
    try {
      double olahLahan = double.parse(luasOlahLahan.value);
      double tanam = double.parse(luasTanam.value);
      double bero = olahLahan - tanam;
      return bero > 0 ? bero.toStringAsFixed(2) : "0.00";
    } catch (e) {
      return "0.00";
    }
  }

  void toggleLuasBero(bool value) {
    isLuasBeroEnabled.value = value;
  }

  bool validateInputs() {
    if (namaDesa.value.isEmpty) {
      Get.snackbar('Error', 'Nama Desa harus diisi');
      return false;
    }
    if(luasLahan.value.isEmpty) {
      Get.snackbar('Error', 'Luas lahan harus diisi');
      return false;
    }

    if (luasTanam.value.isEmpty) {
      Get.snackbar('Error', 'Luas tanam harus diisi');
      return false;
    }
    if (luasPanen.value.isEmpty) {
      Get.snackbar('Error', 'Luas panen harus diisi');
      return false;
    }
    if (luasOlahLahan.value.isEmpty) {
      Get.snackbar('Error', 'Luas olah lahan harus diisi');
      return false;
    }
    return true;
  }

  Future<void> submitData() async {
    if (!validateInputs()) return;
    
    isLoading.value = true;

    try {
      final deviceId = await _splashscreenController.getdeviceId();
      if (deviceId == null) {
        Get.snackbar('Error', 'Device ID tidak ditemukan');
        return;
      }

      await _supabaseServices.insertDataTanaman(
        deviceId: deviceId,
        namaDesa: namaDesa.value,
        tanggalPenanaman: formattedDateForDB,
        luasLahan: luasLahan.value,
        luasTanam: luasTanam.value,
        luasPanen: luasPanen.value,
        luasOlahLahan: luasOlahLahan.value,
        stadingCrop: calculateStadingCrop(),
        status: status.value,
        luasBero: isLuasBeroEnabled.value ? calculateLuasBero() : null,
      );

      Get.snackbar(
        'Sukses',
        'Data berhasil ditambahkan',
        duration: const Duration(seconds: 2),
      );

      // Tunggu sebentar sebelum kembali
      await Future.delayed(const Duration(seconds: 1));
      
      // Pastikan view masih ada sebelum memanggil Get.back()
      if (Get.isDialogOpen ?? false) {
        Get.back();
      } else {
        Get.back(closeOverlays: true);
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleStatus(bool value) {
    status.value = value;
  }
}