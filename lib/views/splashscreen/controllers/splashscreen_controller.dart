import 'dart:io';

import 'package:agro_app/utils/getx_routes.dart';
import 'package:agro_app/utils/supabase_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  final SupabaseServices _supabaseServices = SupabaseServices();

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Get device ID
      final deviceId = await getdeviceId();
      if (deviceId != null) {
        // Insert device ID ke Supabase
        await _supabaseServices.insertDeviceId(deviceId);
      }
    } catch (e) {
      print('Error initializing app: $e');
    } finally {
      // Pindah ke halaman home setelah 3 detik
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed(GetxRoutes.home);
      });
    }
  }

  Future<String?> getdeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Gunakan Android ID sebagai alternatif
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // iOS Identifier
    }
    return null;
  }
}