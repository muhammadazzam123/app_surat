import 'package:app_surat/models/agenda_model.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class AgendaDetailPage extends StatelessWidget {
  const AgendaDetailPage({super.key});

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Detail Agenda Undangan',
        style: poppinsTextStyle.copyWith(
            fontSize: 18, fontWeight: semiBold, color: blackColor),
      ),
    );
  }

  Widget _body(AgendaUndangan agendaUndangan) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal Agenda',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${agendaUndangan.tglAgenda}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Waktu Agenda',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${agendaUndangan.waktu}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Peserta',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${agendaUndangan.peserta}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Tempat',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${agendaUndangan.tempat}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
          const SizedBox(height: 10),
          Text(
            'Isi Acara',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: semiBold, color: blackColor),
          ),
          const SizedBox(height: 5),
          Text(
            '${agendaUndangan.isiAcara}',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AgendaUndangan;
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
              _body(args),
            ],
          ),
        ),
      ),
    );
  }
}
