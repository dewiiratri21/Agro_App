import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/utils/getx_routes.dart';
import 'package:agro_app/views/home/widgets/date_list_widget.dart';
import 'package:agro_app/views/home/widgets/date_selector_widget.dart';
import 'package:agro_app/views/home/widgets/header_widget.dart';
import 'package:agro_app/views/home/widgets/plant_card_widget.dart';
import 'package:agro_app/views/home/widgets/status_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:agro_app/views/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(GetxRoutes.tambahInformasi);
          // Refresh data setelah kembali dari halaman tambah
          controller.fetchDataTanaman();
        },
        backgroundColor: ColorConstant.primaryColor,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: ColorConstant.whiteColor, size: 28),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(),
              const SizedBox(height: 24),
              DateSelectorWidget(controller: controller),
              const SizedBox(height: 12),
              DateListWidget(controller: controller),
              const SizedBox(height: 24),
              StatusTabWidget(controller: controller),
              const SizedBox(height: 18),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.dataTanaman.isEmpty) {
                    return Center(
                      child: Text(
                        'Belum ada data tanaman',
                        style: TextStyle(
                          color: ColorConstant.grayColor3,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  if (controller.filteredDataTanaman.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            controller.isCompletedSelected.value
                                ? Icons.task_alt_outlined
                                : Icons.pending_actions_outlined,
                            size: 64,
                            color: ColorConstant.grayColor3,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tidak ada data tanaman yang\n${controller.isCompletedSelected.value ? "selesai" : "belum selesai"}\npada tanggal ${DateFormat('dd MMMM yyyy', 'id_ID').format(controller.selectedDay.value)}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.grayColor3,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: controller.fetchDataTanaman,
                    child: ListView.builder(
                      itemCount: controller.filteredDataTanaman.length,
                      itemBuilder: (context, index) {
                        final tanaman = controller.filteredDataTanaman[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: PlantCardWidget(
                            title: tanaman['nama_desa'] ?? '',
                            details: {
                              'Luas Tanam':
                                  '${controller.formatNumber(tanaman['luas_tanam'])} ha',
                              'Luas Panen':
                                  '${controller.formatNumber(tanaman['luas_panen'])} ha',
                              'Luas Olah Lahan':
                                  '${controller.formatNumber(tanaman['luas_olah_lahan'])} ha',
                              'Standing Corp':
                                  '${controller.formatNumber(tanaman['stading_crop'])} ha',
                              if (tanaman['luas_bero'] != null)
                                'BERO':
                                    '${controller.formatNumber(tanaman['luas_bero'])} ha',
                            },
                            status: tanaman['status'] ?? false,
                            onStatusChanged: (bool newStatus) {
                              controller.toggleTanamanStatus(
                                tanaman['tanaman_id'],
                                newStatus,
                              );
                            },
                            onEdit: () async {
                              final result = await Get.toNamed(
                                GetxRoutes.editInformasi,
                                arguments: tanaman,
                              );
                              if (result == true) {
                                controller.fetchDataTanaman();
                              }
                            },
                            onDelete: () {
                              controller.deleteDataTanaman(
                                tanaman['tanaman_id'],
                                tanaman['nama_tanaman'] ?? 'Tanaman',
                              );
                            },
                            onViewDetail: () async {
                              await Get.toNamed(
                                GetxRoutes.detailInformasi,
                                arguments: tanaman,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
