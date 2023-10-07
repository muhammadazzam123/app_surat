import 'dart:io';

import 'package:app_surat/models/surat_keluar_model.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/services/surat_keluar_service.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SuratKeluarDetailPage extends StatelessWidget {
  const SuratKeluarDetailPage({super.key});

  checkFilePermission(int suratKeluarId, suratKeluarFileName, context) async {
    final Directory? directory = await getExternalStorageDirectory();
    if (await Permission.storage.isGranted) {
      final res = await SuratKeluarService().downloadSuratKeluar(suratKeluarId,
          '${directory!.path}/Media/${DateTime.now()}$suratKeluarFileName');

      if (res == 'OK') {
        SnackBarService().showSnackBar('Berkas berhasil diunduh', context);
      } else {
        SnackBarService().showSnackBar(
            'Gagal mengunduh berkas. Cobalah beberapa saat lagi.', context);
      }
    } else {
      return Permission.storage.request();
    }
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Detail Surat Masuk',
        style: poppinsTextStyle.copyWith(
            fontSize: 20, fontWeight: semiBold, color: blackColor),
      ),
    );
  }

  Widget _body(SuratKeluar suratKeluar, context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nomor Surat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.noSurat}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Kode Surat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.kodeSurat!.namaKode}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Tanggal Keluar',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.tglKeluar}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Pembuat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.pegawai!.nama}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Perihal',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.perihalindexSk}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Lampiran',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.lampiran}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Isi Surat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.isiRingkas}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Text(
            'Catatan',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratKeluar.catatan}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              checkFilePermission(suratKeluar.id!, suratKeluar.fileSk, context);
            },
            child: Container(
              width: 95,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 27),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'PDF',
                    style: poppinsTextStyle.copyWith(
                        fontSize: 11, fontWeight: semiBold, color: whiteColor),
                  ),
                  Icon(
                    Icons.download,
                    size: 15,
                    color: whiteColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SuratKeluar;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
          child: Column(
            children: [
              _title(),
              const SizedBox(height: 25),
              _body(args, context),
            ],
          ),
        ),
      ),
    );
  }
}
