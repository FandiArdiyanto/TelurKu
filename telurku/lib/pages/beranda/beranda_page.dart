import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/action_card.dart';
import '../../widgets/form_input_sheet.dart';
import '../../widgets/form_export_sheet.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  void _showFormInput(
    BuildContext context,
    String judul,
    IconData ikon,
    Color warna, {
    bool isJual = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FormInputSheet(
        judul: judul,
        ikon: ikon,
        warnaIkon: warna,
        isJual: isJual,
      ),
    );
  }

  void _showFormExport(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const FormExportSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PrimalLog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, Juragan! 👨‍🌾',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Peternakan Makmur',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.orange[100],
                  child: const Icon(Icons.person, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Panen Hari Ini',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1,250',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Butir Telur',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Pencatatan Cepat',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 16),
            ActionCard(
              title: 'Catat Panen Baru',
              subtitle: 'Input hasil telur hari ini',
              icon: Icons.add_circle_rounded,
              color: AppColors.panen,
              onTap: () => _showFormInput(
                context,
                'Panen Baru',
                Icons.add_circle_rounded,
                AppColors.panen,
              ),
            ),
            ActionCard(
              title: 'Catat Penjualan',
              subtitle: 'Input data transaksi telur',
              icon: Icons.point_of_sale_rounded,
              color: AppColors.jual,
              onTap: () => _showFormInput(
                context,
                'Penjualan',
                Icons.point_of_sale_rounded,
                AppColors.jual,
                isJual: true,
              ),
            ),
            ActionCard(
              title: 'Lapor Telur Pecah',
              subtitle: 'Catat telur yang rusak',
              icon: Icons.warning_rounded,
              color: AppColors.pecah,
              onTap: () => _showFormInput(
                context,
                'Telur Pecah',
                Icons.warning_rounded,
                AppColors.pecah,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                  ),
                ),
                icon: const Icon(
                  Icons.description_outlined,
                  color: AppColors.textDark,
                ),
                label: const Text(
                  'Export Laporan ke Excel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                onPressed: () => _showFormExport(context),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
