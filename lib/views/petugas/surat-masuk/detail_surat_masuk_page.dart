import 'dart:io';

import 'package:app_surat/models/surat_masuk_model.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/services/surat_masuk_service.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailSuratMasukPage extends StatelessWidget {
  const DetailSuratMasukPage({super.key});

  checkFilePermission(int suratMasukId, suratMasukFileName, context) async {
    final Directory? directory = await getExternalStorageDirectory();
    if (await Permission.storage.isGranted) {
      final res = await SuratMasukService().downloadSuratMasuk(suratMasukId,
          '${directory!.path}/Media/${DateTime.now()}$suratMasukFileName');

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

  Widget _body(SuratMasuk suratMasuk, context) {
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
            '${suratMasuk.noSurat}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Tanggal Surat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratMasuk.tglMasuk}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Asal Surat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratMasuk.asalSurat}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Index',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratMasuk.perihalindex}',
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
            '${suratMasuk.isiSurat}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 10),
          Text(
            'Pembuat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${suratMasuk.pegawai!.nama}',
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
            '${suratMasuk.lampiran}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              checkFilePermission(suratMasuk.id!, suratMasuk.fileSm, context);
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
    final args = ModalRoute.of(context)!.settings.arguments as SuratMasuk;
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
