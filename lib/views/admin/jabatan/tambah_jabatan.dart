import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class TambahJabatan extends StatefulWidget {
  const TambahJabatan({super.key});

  @override
  State<TambahJabatan> createState() => _TambahJabatanState();
}

class _TambahJabatanState extends State<TambahJabatan> {
  TextEditingController nomorTextController = TextEditingController();
  TextEditingController asalTextController = TextEditingController();
  final _formState = GlobalKey<FormState>();

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Tambah Jabatan',
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
          controller: nomorTextController,
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
          controller: asalTextController,
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
        onPressed: () {
          if (_formState.currentState!.validate()) {}
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
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
