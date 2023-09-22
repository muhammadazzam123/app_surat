import 'package:app_surat/navbar.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout App Surat',
            style: poppinsTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
              color: blackColor,
            ),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah anda yakin ingin keluar',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                    color: thirdColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Kembali',
                style: poppinsTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: medium,
                  color: blackColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xffc51f1a))),
              onPressed: () {},
              child: Text('Keluar',
                  style: poppinsTextStyle.copyWith(
                      fontSize: 12, fontWeight: medium, color: whiteColor)),
            ),
          ],
        );
      },
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selamat Datang',
          style: poppinsTextStyle.copyWith(
            fontSize: 24,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        Text(
          'Sistem Informasi Pengelolaan Surat \n Bagian Protokol Kantor Walikota Palembang',
          style: poppinsTextStyle.copyWith(
            fontSize: 13,
            fontWeight: medium,
            color: grayColor,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  onPressed: () {
                    _showMyDialog(context);
                  },
                  icon: Icon(
                    Icons.logout_outlined,
                    color: primaryColor,
                    size: 30,
                  )),
            )
          ],
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                      color: primaryColor,
                    ))),
          ),
        ),
        drawer: const NavBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
          child: Column(
            children: [
              _title(),
            ],
          ),
        ));
  }
}
