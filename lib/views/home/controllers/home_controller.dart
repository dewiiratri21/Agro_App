import 'package:get/get.dart';
import 'package:agro_app/utils/supabase_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final SupabaseServices _supabaseServices = SupabaseServices();
  final RxList<Map<String, dynamic>> dataTanaman = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> filteredDataTanaman = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final selectedDate = DateTime.now().obs;
  final selectedDay = DateTime.now().obs;
  final isCompletedSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedDay.value = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    fetchDataTanaman();

    // Observe perubahan tanggal dan status
    ever(selectedDay, (_) => filterData());
    ever(isCompletedSelected, (_) => filterData());
  }

  void filterData() {
    final selectedDateStr = DateFormat('yyyy-MM-dd').format(selectedDay.value);
    
    filteredDataTanaman.value = dataTanaman.where((tanaman) {
      final tanggalPenanaman = tanaman['tanggal_penanaman'] as String;
      final status = tanaman['status'] as bool;
      
      bool dateMatches = tanggalPenanaman == selectedDateStr;
      bool statusMatches = status == isCompletedSelected.value;
      
      return dateMatches && statusMatches;
    }).toList();
  }

  Future<void> fetchDataTanaman() async {
    try {
      isLoading.value = true;
      final data = await _supabaseServices.getAllDataTanaman();
      dataTanaman.assignAll(data);
      filterData();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengambil data: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleTanamanStatus(int id, bool newStatus) async {
    try {
      await _supabaseServices.updateStatusTanaman(id, newStatus);
      await fetchDataTanaman(); // Refresh data setelah update
      Get.snackbar(
        'Sukses',
        'Status tanaman berhasil diupdate',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengupdate status: $e',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> deleteDataTanaman(int id, String namaTanaman) async {
    try {
      // Tampilkan dialog konfirmasi
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data tanaman "$namaTanaman"?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Hapus'),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        isLoading.value = true;
        await _supabaseServices.deleteDataTanaman(id);
        await fetchDataTanaman(); // Refresh data setelah delete
        Get.snackbar(
          'Sukses',
          'Data tanaman berhasil dihapus',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menghapus data: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Format angka dengan 2 desimal dan pemisah ribuan
  String formatNumber(String value) {
    try {
      double number = double.parse(value);
      return number.toStringAsFixed(2).replaceAll(RegExp(r'\.'), ',');
    } catch (e) {
      return '0,00';
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void setSelectedDay(DateTime date) {
    selectedDay.value = DateTime(
      date.year,
      date.month,
      date.day,
    );
  }
  
  void toggleTaskStatus(bool isCompleted) {
    isCompletedSelected.value = isCompleted;
  }
}