import 'package:app_surat/models/kode_surat_model.dart';
import 'package:app_surat/services/kode_surat_service.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class KodeSuratEditPage extends StatefulWidget {
  const KodeSuratEditPage({super.key, required this.kodeSurat});

  final KodeSurat kodeSurat;

  @override
  State<KodeSuratEditPage> createState() => _KodeSuratEditPageState();
}

class _KodeSuratEditPageState extends State<KodeSuratEditPage> {
  final _formState = GlobalKey<FormState>();
  TextEditingController namaKodeTextController = TextEditingController();
  TextEditingController keteranganTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setData();
  }

  _setData() {
    namaKodeTextController.text = '${widget.kodeSurat.namaKode}';
    keteranganTextController.text = '${widget.kodeSurat.keterangan}';
  }

  void _validateForm() {
    if (_formState.currentState!.validate()) {
      _editKodeSurat();
    }
  }

  void _editKodeSurat() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {
        'nama_kode': namaKodeTextController.text,
        'keterangan': keteranganTextController.text
      };

      final Response response =
          await KodeSuratService().patchSuratMasuk(data, widget.kodeSurat.id);

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
        'Edit Kode Surat',
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
                'Edit',
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
    );
  }
}
