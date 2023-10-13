import 'package:app_surat/models/agenda_model.dart';
import 'package:app_surat/services/agenda_service.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AgendaEditPage extends StatefulWidget {
  const AgendaEditPage({super.key, this.agendaUndangan});

  final AgendaUndangan? agendaUndangan;

  @override
  State<AgendaEditPage> createState() => _AgendaEditPageState();
}

class _AgendaEditPageState extends State<AgendaEditPage> {
  final _formState = GlobalKey<FormState>();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController waktuTextController = TextEditingController();
  TextEditingController pesertaTextController = TextEditingController();
  TextEditingController tempatTextController = TextEditingController();
  TextEditingController isiTextController = TextEditingController();
  late DateFormat dateFormat;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat('yyyy-MM-dd', 'id');
    _setData();
  }

  _setData() {
    tanggalController.text = '${widget.agendaUndangan!.tglAgenda}';
    waktuTextController.text = '${widget.agendaUndangan!.waktu}';
    pesertaTextController.text = '${widget.agendaUndangan!.peserta}';
    tempatTextController.text = '${widget.agendaUndangan!.tempat}';
    isiTextController.text = '${widget.agendaUndangan!.isiAcara}';
  }

  void _validateForm() {
    if (_formState.currentState!.validate()) {
      _editAgendaUndangan();
    }
  }

  void _editAgendaUndangan() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> data = {
        'tgl_agenda': dateFormat.parse(tanggalController.text),
        'waktu': waktuTextController.text,
        'peserta': pesertaTextController.text,
        'tempat': tempatTextController.text,
        'isi_acara': isiTextController.text
      };

      final Response response = await AgendaUndanganService()
          .patchAgendaUndangan(data, widget.agendaUndangan!.id);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/agenda');
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
        'Edit Agenda Undangan',
        style: poppinsTextStyle.copyWith(
            fontSize: 18, fontWeight: semiBold, color: blackColor),
      ),
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
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year + 3),
              initialEntryMode: DatePickerEntryMode.calendarOnly,
            );

            if (pickedDate != null) {
              debugPrint(pickedDate.toString());
              String formattedDate = dateFormat.format(pickedDate);
              setState(() {
                tanggalController.text = formattedDate;
              });
            }
          },
        )
      ],
    );
  }

  Widget _waktuAgenda() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waktu Agenda',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: waktuTextController,
          validator: (value) {
            if (value == '') {
              return "data tidak boleh kosong";
            }
            return null;
          },
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              '10:58',
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

  Widget _formPesertaIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Peserta',
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
          controller: pesertaTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan peserta...',
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

  Widget _formTempat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tempat',
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan tempat...',
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan Isi Surat..',
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
              _formTanggalSurat(context),
              const SizedBox(height: 15),
              _waktuAgenda(),
              const SizedBox(height: 15),
              _formPesertaIndex(),
              const SizedBox(height: 15),
              _formTempat(),
              const SizedBox(height: 15),
              _formIsiSurat(),
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
