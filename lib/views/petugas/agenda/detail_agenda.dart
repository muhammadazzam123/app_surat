import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class DetailAgenda extends StatelessWidget {
  const DetailAgenda({super.key});

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

  Widget _body() {
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
            '14/11/2022',
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
            '10:58',
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
            'Adelya Agustina',
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
            'Plaju, Palembang, Sumatera Selatan',
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
            'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nisi eveniet deleniti, fugiat quae excepturi doloremque ',
            style: poppinsTextStyle.copyWith(
                fontSize: 11, fontWeight: medium, color: blackColor),
          ),
        ],
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
          child: Column(
            children: [
              _title(),
              const SizedBox(height: 25),
              _body(),
            ],
          ),
        ),
      ),
    );
  }
}
