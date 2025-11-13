import 'package:agro_app/global_widgets/custom_appbar_global_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:agro_app/utils/supabase_services.dart';
import 'package:agro_app/constants/color_constant.dart';
import 'package:agro_app/constants/textstyle_constant.dart';
import 'package:get/get.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final SupabaseServices _supabase = SupabaseServices();
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;

  // Semua metric baru
  double _totalTanam = 0;
  double _totalPanen = 0;
  double _totalOlah = 0;
  double _standingCrop = 0;
  double _totalBero = 0;
  double _totalLuasLahan = 0;

  // Data Histori dummy
  final List<Map<String, String>> _historyDummy = [
    {'title': 'Penanaman di desa Kaligondang-2', 'date': 'Selasa, 17'},
    {'title': 'Penanaman di desa Kaligondang-1', 'date': 'Selasa, 10'},
    {'title': 'Penanaman di desa Kutoarjo', 'date': 'Selasa, 03'},
  ];

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    setState(() => _isLoading = true);

    final all = await _supabase.getAllDataTanaman();
    // Reset
    _totalTanam = 0;
    _totalPanen = 0;
    _totalOlah = 0;
    _standingCrop = 0;
    _totalBero = 0;
    _totalLuasLahan = 0;

    final year = _selectedDate.year;
    final month = _selectedDate.month;

    double sumTanamAktif = 0;

    // Loop semua data dan hitung sesuai kebutuhan
    for (var r in all) {
      final tanggal =
          DateTime.tryParse(r['tanggal_penanaman']) ?? DateTime.now();
      final luasTanam = double.tryParse(r['luas_tanam'].toString()) ?? 0;
      final luasPanen = double.tryParse(r['luas_panen'].toString()) ?? 0;
      final luasOlah = double.tryParse(r['luas_olah_lahan'].toString()) ?? 0;
      final luasBero = double.tryParse((r['luas_bero'] ?? '0').toString()) ?? 0;
      final status = r['status'] == true;

      // Standing crop: jumlah tanam yang belum panen (status==false)
      if (!status) {
        sumTanamAktif += luasTanam;
      }

      // Hanya untuk bulan & tahun yang dipilih:
      if (tanggal.year == year && tanggal.month == month) {
        _totalTanam += luasTanam;
        _totalPanen += luasPanen;
        _totalOlah += luasOlah;
        _totalBero += luasBero;
      }
    }

    // Setelah loop:
    _standingCrop = sumTanamAktif;
    _totalLuasLahan = _totalTanam + _totalPanen + _totalOlah;

    setState(() => _isLoading = false);
  }

  Future<void> _pickMonth() async {
    final picked = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      await _loadMetrics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,

      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBarGlobalWidget(
                      title: 'Laporan Kumulatif',
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    // ===== Periode: label + dropdown di satu row =====
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Periode',
                          style: TextStyleConstant.primaryTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: ColorConstant.secondaryCarbonColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickMonth,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: ColorConstant.whiteColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ColorConstant.grayColor3,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat(
                                    'MMMM yyyy',
                                    'id',
                                  ).format(_selectedDate),
                                  style: TextStyleConstant.primaryTextStyle
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // ===== Grid Metrics: 2 kolom, 3 baris (6 item) =====
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildMetricCard(
                          '${_totalTanam.toStringAsFixed(1)} Ha',
                          'Total luas tanam',
                        ),
                        _buildMetricCard(
                          '${_totalPanen.toStringAsFixed(1)} Ha',
                          'Total luas panen',
                        ),
                        _buildMetricCard(
                          '${_totalOlah.toStringAsFixed(1)} Ha',
                          'Total luas olah lahan',
                        ),
                        _buildMetricCard(
                          '${_standingCrop.toStringAsFixed(1)} Ha',
                          'Standing Crop',
                        ),
                        _buildMetricCard(
                          '${_totalBero.toStringAsFixed(1)} Ha',
                          'BERO',
                        ),
                        _buildMetricCard(
                          '${_totalLuasLahan.toStringAsFixed(1)} Ha',
                          'Total Luas Lahan',
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ===== Judul Histori di bulan ini =====
                    Text(
                      'Histori di bulan ini',
                      style: TextStyleConstant.primaryTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    // ===== Daftar Histori Dummy =====
                    // Bagian ListView.separated
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _historyDummy.length,
                      // Divider 1px di antara item
                      separatorBuilder:
                          (_, __) => const Divider(
                            height: 1,
                            color: Color(0xFFE0E0E0),
                          ),
                      itemBuilder: (context, idx) {
                        final item = _historyDummy[idx];
                        return Padding(
                          padding: EdgeInsets.only(
                            top: idx == 0 ? 0 : 12.0,
                            bottom: 12.0,
                          ),
                          child: Row(
                            children: [
                              // Ikon hijau bundar
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE8F5E9),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/plant.svg',
                                    color: const Color(0xFF43A047),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Judul dan tanggal
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title']!,
                                      style: TextStyleConstant.primaryTextStyle
                                          .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['date']!,
                                      style: TextStyleConstant.primaryTextStyle
                                          .copyWith(
                                            fontSize: 12,
                                            color: ColorConstant.grayColor3,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildMetricCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6D6D6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyleConstant.secondaryTextStyle.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyleConstant.primaryTextStyle.copyWith(
              fontSize: 12,
              color: ColorConstant.grayColor3,
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyData {
  final String month;
  double value;
  MonthlyData(this.month, this.value);
}
