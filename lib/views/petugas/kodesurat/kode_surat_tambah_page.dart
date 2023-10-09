import 'package:app_surat/services/kode_surat_service.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class KodeSuratTambahPage extends StatefulWidget {
  const KodeSuratTambahPage({super.key});

  @override
  State<KodeSuratTambahPage> createState() => _KodeSuratTambahPageState();
}

class _KodeSuratTambahPageState extends State<KodeSuratTambahPage> {
  TextEditingController namaKodeTextController = TextEditingController();
  TextEditingController keteranganTextController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  bool _isLoading = false;

  void _validateForm() {
    if (_formState.currentState!.validate()) {
      _addKodeSurat();
    }
  }

  void _addKodeSurat() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {
        'nama_kode': namaKodeTextController.text,
        'keterangan': keteranganTextController.text
      };

      final Response response = await KodeSuratService().postKodeSurat(data);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/kode-surat');
          SnackBarService().showSnackBar(response.data['message'], context);
        }
      } else if (response.statusCode == 500) {
        if (context.mounted) {
          SnackBarService().showSnackBar(
              'Terjadi kesalahan pada server. Coba beberapa saat lagi',
              context);
        }
      } else {
        if (context.mounted) {
          SnackBarService().showSnackBar('${response.data}', context);
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) SnackBarService().showSnackBar('$e', context);
    }
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Tambah Kode Surat',
        style: poppinsTextStyle.copyWith(
            fontSize: 20, fontWeight: semiBold, color: blackColor),
      ),
    );
  }

  Widget _formNomorSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama Kode',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value == '') {
              return "data tidak boleh kosong";
            }
            return null;
          },
          controller: namaKodeTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan nama kode surat..',
              style: poppinsTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
                color: grayColor,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: defaultMargin2, vertical: 17),
          ),
        )
      ],
    );
  }

  Widget _formAsalSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Keterangan',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: (value) {
            if (value == '') {
              return "data tidak boleh kosong";
            }
            return null;
          },
          controller: keteranganTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan keterangan...',
              style: poppinsTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
                color: grayColor,
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: defaultMargin2, vertical: 17),
          ),
        )
      ],
    );
  }

  Widget _buttonKirim() {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _validateForm,
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: _isLoading
            ? const CircularProgressIndicator()
            : Text(
                'Kirim',
                style: poppinsTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold, color: Colors.white),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                _title(),
                const SizedBox(height: 25),
                _formNomorSurat(),
                const SizedBox(height: 15),
                _formAsalSurat(),
                const SizedBox(height: 30),
                _buttonKirim(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
