import 'package:app_surat/views/login_page.dart';
import 'package:app_surat/views/pegawai/agenda/agenda.dart';
import 'package:app_surat/views/pegawai/agenda/detail_agenda.dart';
import 'package:app_surat/views/pegawai/agenda/edit_agenda.dart';
import 'package:app_surat/views/pegawai/agenda/tambah_agenda.dart';
import 'package:app_surat/views/pegawai/home_page.dart';
import 'package:app_surat/views/pegawai/kodesurat/edit_kode_surat.dart';
import 'package:app_surat/views/pegawai/kodesurat/kodesurat.dart';
import 'package:app_surat/views/pegawai/kodesurat/tambah_kode_surat.dart';
import 'package:app_surat/views/pegawai/suratmasukkeluar/detail_surat.dart';
import 'package:app_surat/views/pegawai/suratmasukkeluar/edit_surat.dart';
import 'package:app_surat/views/pegawai/suratmasukkeluar/suratkeluar.dart';
import 'package:app_surat/views/pegawai/suratmasukkeluar/suratmasuk.dart';
import 'package:app_surat/views/pegawai/suratmasukkeluar/tambah_surat.dart';
import 'package:app_surat/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Sisfo Monitoring Pegawai Dishub Sumsel Bagian Lalin',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        // folder-pegawai
        '/home': (context) => const HomePage(),
        '/surat-masuk': (context) => const SuratMasuk(),
        '/surat-keluar': (context) => const SuratKeluar(),
        '/detail-surat': (context) => const DetailSurat(),
        '/tambah-surat': (context) => const TambahSurat(),
        '/edit-surat': (context) => const EditSurat(),
        '/kode-surat': (context) => const KodeSurat(),
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
