import 'dart:io';

import 'package:app_surat/models/kode_surat_model.dart';
import 'package:app_surat/models/pegawai_model.dart';
import 'package:app_surat/services/kode_surat_service.dart';
import 'package:app_surat/services/pegawai_service.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/services/surat_masuk_service.dart';
import 'package:app_surat/theme.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TambahSuratPage extends StatefulWidget {
  const TambahSuratPage({super.key});

  @override
  State<TambahSuratPage> createState() => _TambahSuratPageState();
}

class _TambahSuratPageState extends State<TambahSuratPage> {
  final _formState = GlobalKey<FormState>();
  TextEditingController nomorTextController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController asalTextController = TextEditingController();
  TextEditingController perihalTextController = TextEditingController();
  TextEditingController isiTextController = TextEditingController();
  TextEditingController pembuatTextController = TextEditingController();
  TextEditingController lampiranTextController = TextEditingController();
  TextEditingController kodeTextController = TextEditingController();
  String _fileName = 'file belum dipilih ...';
  File? _suratFile;
  late List<Pegawai> _pegawais;
  late List<KodeSurat> _kodeSurats;
  final List<String> _pegawaiNames = [];
  final List<String> _kodeSuratCodes = [];
  late DateFormat dateFormat;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('id');
    _getDataNames();
  }

  _getDataNames() async {
    _kodeSurats = await KodeSuratService().getfilteredKodeSurats();
    _pegawais = await PegawaiService().getPegawais();

    setState(() {
      for (final pegawai in _pegawais) {
        _pegawaiNames.add('${pegawai.nama}');
      }

      for (final kodeSurat in _kodeSurats) {
        _kodeSuratCodes.add('${kodeSurat.kode}');
      }
    });
  }

  void _pickPembuat(String selectedPegawaiName) {
    for (final pegawai in _pegawais) {
      if (selectedPegawaiName == pegawai.nama) {
        pembuatTextController.text = pegawai.id.toString();
      }
    }
  }

  void _pickKodeSurat(String selectedKodeSurat) {
    for (final kodeSurat in _kodeSurats) {
      if (selectedKodeSurat == kodeSurat.kode) {
        kodeTextController.text = kodeSurat.id.toString();
      }
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'pdf']);

    if (result != null) {
      PlatformFile file = result.files.single;
      setState(() {
        _fileName = file.name;
        _suratFile = File('${file.path}');
      });
    }
  }

  void _validateForm() {
    if (_formState.currentState!.validate() && _suratFile != null) {
      _addSuratMasuk();
    } else {
      if (context.mounted) {
        SnackBarService().showSnackBar('file tidak boleh kosong', context);
      }
    }
  }

  void _addSuratMasuk() async {
    try {
      setState(() {
        _isLoading = true;
      });

      FormData suratData = FormData.fromMap({
        'isi_surat': isiTextController.text,
        'perihalindex': perihalTextController.text,
        'lampiran': lampiranTextController.text,
        'no_surat': nomorTextController.text,
        'tgl_masuk': dateFormat.parse(tanggalController.text),
        'file':
            await MultipartFile.fromFile(_suratFile!.path, filename: _fileName),
        'asal_surat': asalTextController.text,
        'kode_surat_id': int.parse(kodeTextController.text),
        'pegawai_id': int.parse(pembuatTextController.text)
      });

      final Response response =
          await SuratMasukService().postSuratMasuk(suratData);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/surat-masuk');
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
        'Tambah Surat Masuk',
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
          'Nomor Surat',
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
              'masukkan no surat..',
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

  Widget _formTanggalSurat(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal Surat',
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
              return "tanggal tidak boleh kosong";
            }
            return null;
          },
          controller: tanggalController,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.date_range_outlined,
              size: 20,
              color: grayColor,
            ),
            label: Text(
              'masukkan tanggal surat..',
              style: poppinsTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
                color: grayColor,
              ),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding:
                EdgeInsets.symmetric(horizontal: defaultMargin2, vertical: 17),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(DateTime.now().year + 3),
              initialEntryMode: DatePickerEntryMode.calendarOnly,
            );

            if (pickedDate != null) {
              String formattedDate = dateFormat.format(pickedDate);
              setState(() {
                tanggalController.text = formattedDate;
              });
            } else {
              tanggalController.clear();
            }
          },
        )
      ],
    );
  }

  Widget _formAsalSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Asal Surat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: asalTextController,
          validator: (value) {
            if (value == '') {
              return "data tidak boleh kosong";
            }
            return null;
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan asal surat..',
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

  Widget _formPerihalIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perihal Index',
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
              return "username tidak boleh kosong";
            }
            return null;
          },
          controller: perihalTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan perihal index...',
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

  Widget _formIsiSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Isi Surat',
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
          controller: isiTextController,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan isi surat...',
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

  Widget _formPembuatSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pembuat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return "data tidak boleh kosong";
            }
            return null;
          },
          popupProps: const PopupProps.menu(
            scrollbarProps:
                ScrollbarProps(thumbVisibility: true, thumbColor: Colors.amber),
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 170),
          ),
          items: _pegawaiNames,
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin2, vertical: defaultMargin2 / 2),
              hintText: "pilih pembuat",
              hintStyle: poppinsTextStyle.copyWith(
                  color: grayColor, fontWeight: medium, fontSize: 12),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          onChanged: (String? value) {
            _pickPembuat('$value');
          },
        ),
      ],
    );
  }

  Widget _formLampiranSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lampiran',
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
          controller: lampiranTextController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan lampiran..',
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

  Widget _formKodeSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kode Surat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        DropdownSearch<String>(
          validator: (value) {
            if (value == null) {
              return "data tidak boleh kosong";
            }
            return null;
          },
          popupProps: const PopupProps.menu(
            scrollbarProps:
                ScrollbarProps(thumbVisibility: true, thumbColor: Colors.amber),
            showSelectedItems: true,
            constraints: BoxConstraints(maxHeight: 170),
          ),
          items: _kodeSuratCodes,
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin2, vertical: defaultMargin2 / 2),
              hintText: "pilih kode surat",
              hintStyle: poppinsTextStyle.copyWith(
                  color: grayColor, fontWeight: medium, fontSize: 12),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          onChanged: (String? value) {
            _pickKodeSurat('$value');
          },
        ),
      ],
    );
  }

  Widget _file() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'File (.pdf/.jpg)',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: 13, horizontal: defaultMargin2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: grayColor, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _fileName,
                style: poppinsTextStyle.copyWith(
                    fontSize: 12, fontWeight: semiBold, color: grayColor),
              ),
              InkWell(
                onTap: _pickFile,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Pilih File',
                    style: poppinsTextStyle.copyWith(
                        fontSize: 12, fontWeight: semiBold, color: whiteColor),
                  ),
                ),
              )
            ],
          ),
        ),
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
                _formTanggalSurat(context),
                const SizedBox(height: 15),
                _formAsalSurat(),
                const SizedBox(height: 15),
                _formPerihalIndex(),
                const SizedBox(height: 15),
                _formIsiSurat(),
                const SizedBox(height: 15),
                _pegawaiNames.isEmpty
                    ? const CircularProgressIndicator()
                    : _formPembuatSurat(),
                const SizedBox(height: 15),
                _formLampiranSurat(),
                const SizedBox(height: 15),
                _kodeSuratCodes.isEmpty
                    ? const CircularProgressIndicator()
                    : _formKodeSurat(),
                const SizedBox(height: 15),
                _file(),
                const SizedBox(height: 30),
                _buttonKirim(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
