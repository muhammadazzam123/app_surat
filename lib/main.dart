import 'package:app_surat/views/admin/hak_akses/edit_hakakses.dart';
import 'package:app_surat/views/admin/hak_akses/hak_akses_page.dart';
import 'package:app_surat/views/admin/hak_akses/tambah_hakakses.dart';
import 'package:app_surat/views/admin/home_admin.dart';
import 'package:app_surat/views/admin/jabatan/edit_jabatan.dart';
import 'package:app_surat/views/admin/jabatan/jabatan_page.dart';
import 'package:app_surat/views/admin/jabatan/tambah_jabatan.dart';
import 'package:app_surat/views/admin/pegawai/detail_pegawai.dart';
import 'package:app_surat/views/admin/pegawai/edit_pegawai.dart';
import 'package:app_surat/views/admin/pegawai/pegawai_page.dart';
import 'package:app_surat/views/admin/pegawai/tambah_pegawai.dart';
import 'package:app_surat/views/login_page.dart';
import 'package:app_surat/views/petugas/agenda/agenda_detail_page.dart';
import 'package:app_surat/views/petugas/agenda/agenda_page.dart';
import 'package:app_surat/views/petugas/agenda/agenda_tambah_page.dart';
import 'package:app_surat/views/petugas/home_petugas_page.dart';
import 'package:app_surat/views/petugas/kodesurat/kode_surat_page.dart';
import 'package:app_surat/views/petugas/kodesurat/kode_surat_tambah_page.dart';
import 'package:app_surat/views/petugas/surat-keluar/surat_keluar_detail_page.dart';
import 'package:app_surat/views/petugas/surat-keluar/surat_keluar_page.dart';
import 'package:app_surat/views/petugas/surat-keluar/surat_keluar_tambah_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/detail_surat_masuk_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/edit_surat_masuk_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/surat_masuk_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/tambah_surat_masuk_page.dart';
import 'package:app_surat/views/pimpinan/disposisi_page.dart';
import 'package:app_surat/views/pimpinan/edit_disposisi.dart';
import 'package:app_surat/views/pimpinan/home_pimpinan.dart';
import 'package:app_surat/views/pimpinan/tambah_disposisi.dart';
import 'package:app_surat/views/splas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(
      const MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisfo Manajemen Surat Mobile',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        // folder-petugas
        '/home-petugas': (context) => const HomePage(),
        '/surat-masuk': (context) => const SuratMasukPage(),
        '/detail-surat-masuk': (context) => const DetailSuratMasukPage(),
        '/tambah-surat-masuk': (context) => const TambahSuratMasukPage(),
        '/edit-surat-masuk': (context) => const EditSuratMasukPage(),
        '/surat-keluar': (context) => const SuratKeluarPage(),
        '/surat-keluar/tambah': (context) => const SuratKeluarTambahPage(),
        '/surat-keluar/detail': (context) => const SuratKeluarDetailPage(),
        '/kode-surat': (context) => const KodeSuratPage(),
        '/tambah-kode-surat': (context) => const KodeSuratTambahPage(),
        '/agenda': (context) => const AgendaUndanganPage(),
        '/detail-agenda': (context) => const AgendaDetailPage(),
        '/tambah-agenda': (context) => const AgendaTambahPage(),
        // folder-pimpinan
        '/home-pimpinan': (context) => const HomePimpinan(),
        '/disposisi-page': (context) => const DisposisiPage(),
        '/tambah-disposisi': (context) => const TambahDisposisi(),
        '/edit-disposisi': (context) => const EditDisposisi(),
        // folder-admin
        '/home-admin': (context) => const HomeAdmin(),
        '/pegawai-page': (context) => const PegawaiPage(),
        '/detail-pegawai': (context) => const DetailPegawai(),
        '/tambah-pegawai': (context) => const TambahPegawai(),
        '/edit-pegawai': (context) => const EditPegawai(),
        '/jabatan-page': (context) => const JabatanPage(),
        '/tambah-jabatan': (context) => const TambahJabatan(),
        '/edit-jabatan': (context) => const EditJabatan(),
        '/hak-akses-page': (context) => const HakAksesPage(),
        '/tambah-hak-akses': (context) => const TambahHakAkses(),
        '/edit-hak-akses': (context) => const EditHakAkses(),
      },
    );
  }
}
