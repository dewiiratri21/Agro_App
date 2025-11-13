import 'package:agro_app/utils/supabase_services.dart';
import 'package:get/get.dart';

class DetailInformasiController extends GetxController {
  final SupabaseServices _supabaseServices = SupabaseServices();

  final namaDesa = ''.obs;
  final tanggalPenanaman = ''.obs;
  final luasLahan = ''.obs;
  final luasTanam = ''.obs;
  final luasPanen = ''.obs;
  final luasOlahLahan = ''.obs;
  final stadingCrop = ''.obs;
  final luasBero = ''.obs;
  final isLoading = false.obs;
  final tanamanId = 0.obs;

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
    tanggalPenanaman.value = data['tanggal_penanaman'];
    luasLahan.value = data['luas_lahan'].toString();
    luasTanam.value = data['luas_tanam'].toString();
    luasPanen.value = data['luas_panen'].toString();
    luasOlahLahan.value = data['luas_olah_lahan'].toString();
    stadingCrop.value = data['stading_crop'].toString();
    luasBero.value = data['luas_bero']?.toString() ?? '0';
  }

  Future<void> tandaiSelesai() async {
    try {
      isLoading.value = true;
      await _supabaseServices.updateStatusTanaman(tanamanId.value, true);
      Get.back(result: true);
      Get.snackbar('Sukses', 'Data berhasil ditandai selesai');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menandai data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
