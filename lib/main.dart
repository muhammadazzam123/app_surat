import 'package:app_surat/views/login_page.dart';
import 'package:app_surat/views/petugas/agenda/agenda.dart';
import 'package:app_surat/views/petugas/agenda/detail_agenda.dart';
import 'package:app_surat/views/petugas/agenda/edit_agenda.dart';
import 'package:app_surat/views/petugas/agenda/tambah_agenda.dart';
import 'package:app_surat/views/petugas/home_petugas_page.dart';
import 'package:app_surat/views/petugas/kodesurat/edit_kode_surat.dart';
import 'package:app_surat/views/petugas/kodesurat/kodesurat.dart';
import 'package:app_surat/views/petugas/kodesurat/tambah_kode_surat.dart';
import 'package:app_surat/views/petugas/surat-masuk/detail_surat_masuk_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/edit_surat.dart';
import 'package:app_surat/views/petugas/surat-keluar/suratkeluar.dart';
import 'package:app_surat/views/petugas/surat-masuk/surat_masuk_page.dart';
import 'package:app_surat/views/petugas/surat-masuk/tambah_surat_masuk.dart';
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
        '/surat-keluar': (context) => const SuratKeluar(),
        '/detail-surat': (context) => const DetailSuratPage(),
        '/tambah-surat': (context) => const TambahSurat(),
        '/edit-surat': (context) => const EditSurat(),
        '/kode-surat': (context) => const KodeSuratPage(),
        '/tambah-kode-surat': (context) => const TambahKodeSurat(),
        '/edit-kode-surat': (context) => const EditKodeSurat(),
        '/agenda': (context) => const AgendaSurat(),
        '/detail-agenda': (context) => const DetailAgenda(),
        '/tambah-agenda': (context) => const TambahAgenda(),
        '/edit-agenda': (context) => const EditAgenda(),
        // folder-pimpinan
        // folder-admin
      },
    );
  }
}
