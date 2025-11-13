import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices {
  final supabase = Supabase.instance.client;

  Future<void> insertDeviceId(String deviceId) async {
    await supabase.from('registered_user_devices').insert({
      'device_id': deviceId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> insertDataTanaman({
    required String deviceId,
    required String namaDesa,
    required String tanggalPenanaman,
    required String luasLahan,
    required String luasTanam,
    required String luasPanen,
    required String luasOlahLahan,
    required String stadingCrop,
    required bool status,
    String? luasBero,
  }) async {
    try {
      // Pastikan device_id ada di tabel registered_user_devices
      final deviceExists = await supabase
          .from('registered_user_devices')
          .select()
          .eq('device_id', deviceId);

      if (deviceExists != null) {
        await supabase.from('data_tanaman').insert({
          'device_id': deviceId,
          'nama_desa': namaDesa,
          'tanggal_penanaman': tanggalPenanaman,
          'luas_lahan': luasLahan,
          'luas_tanam': luasTanam,
          'luas_panen': luasPanen,
          'luas_olah_lahan': luasOlahLahan,
          'stading_crop': stadingCrop,
          'luas_bero': luasBero,
          'status': status,
          'created_at': DateTime.now().toIso8601String(),
        });
      } else {
        throw Exception('Device ID tidak terdaftar');
      }
    } catch (e) {
      throw Exception('Gagal menambahkan data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllDataTanaman() async {
    try {
      final response = await supabase
          .from('data_tanaman')
          .select()
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Gagal mengambil data tanaman: $e');
    }
  }

  Future<void> deleteDataTanaman(int id) async {
    try {
      await supabase.from('data_tanaman').delete().eq('tanaman_id', id);
    } catch (e) {
      throw Exception('Gagal menghapus data tanaman: $e');
    }
  }

  Future<void> updateStatusTanaman(int id, bool status) async {
    try {
      await supabase
          .from('data_tanaman')
          .update({'status': status})
          .eq('tanaman_id', id);
    } catch (e) {
      throw Exception('Gagal mengupdate status tanaman: $e');
    }
  }

  Future<void> updateDataTanaman({
    required int tanamanId,
    required String deviceId,
    required String namaDesa,
    required String tanggalPenanaman,
    required String luasLahan,
    required String luasTanam,
    required String luasPanen,
    required String luasOlahLahan,
    required String stadingCrop,
    required bool status,
    String? luasBero,
  }) async {
    try {
      await supabase
          .from('data_tanaman')
          .update({
            'device_id': deviceId,
            'nama_desa': namaDesa,
            'tanggal_penanaman': tanggalPenanaman,
            'luas_lahan': luasLahan,
            'luas_tanam': luasTanam,
            'luas_panen': luasPanen,
            'luas_olah_lahan': luasOlahLahan,
            'stading_crop': stadingCrop,
            'luas_bero': luasBero,
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('tanaman_id', tanamanId);
    } catch (e) {
      throw Exception('Gagal mengupdate data: $e');
    }
  }
}
