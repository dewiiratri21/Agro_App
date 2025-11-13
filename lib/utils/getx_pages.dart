import 'package:agro_app/utils/getx_routes.dart';
import 'package:agro_app/views/detail_informasi/detail_informasi_view.dart';
import 'package:agro_app/views/edit_informasi/edit_informasi_view.dart';
import 'package:agro_app/views/home/home_view.dart';
import 'package:agro_app/views/notifikasi/notifikasi_view.dart';
import 'package:agro_app/views/report_kumulatif/report_view.dart';
import 'package:agro_app/views/tambah informasi/tambah_informasi_view.dart';
import 'package:get/get.dart';

class GetxPages {
  static final List<GetPage> pages = [
    GetPage(name: GetxRoutes.home, page: () => const HomeView()),
    GetPage(
      name: GetxRoutes.tambahInformasi,
      page: () => TambahInformasiView(),
    ),
    GetPage(name: GetxRoutes.editInformasi, page: () => EditInformasiView()),
    GetPage(
      name: GetxRoutes.detailInformasi,
      page: () => DetailInformasiView(),
    ),
    GetPage(name: GetxRoutes.notifikasi, page: () => NotifikasiView()),
    GetPage(name: GetxRoutes.report, page: () => const ReportView()),
  ];
}
