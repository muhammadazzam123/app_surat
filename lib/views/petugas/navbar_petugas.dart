import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/bi.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: blackColor2,
      child: ListView(
        children: [
          const SizedBox(height: 25),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset('assets/logo.png', height: 40),
                const SizedBox(width: 10),
                Text(
                  'SIMS',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: regular,
                    color: whiteColor.withOpacity(0.67),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: grayColor),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Image.asset(
                  'assets/avatar.png',
                  height: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 10),
                Text(
                  'Adelya Agustina',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                    color: whiteColor.withOpacity(0.67),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: grayColor),
          ListTile(
            leading: Iconify(
              Ion.home,
              size: 25,
              color: whiteColor.withOpacity(0.67),
            ),
            title: Text(
              'Dashboard',
              style: poppinsTextStyle.copyWith(
                fontSize: 16,
                color: whiteColor.withOpacity(0.67),
                fontWeight: medium,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/home-petugas');
            },
          ),
          ListTile(
            leading: Iconify(
              Ion.mail,
              size: 25,
              color: whiteColor.withOpacity(0.67),
            ),
            title: Text(
              'Surat Masuk',
              style: poppinsTextStyle.copyWith(
                fontSize: 16,
                color: whiteColor.withOpacity(0.67),
                fontWeight: medium,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/surat-masuk');
            },
          ),
          ListTile(
            leading: Iconify(
              Ion.mail_open,
              size: 25,
              color: whiteColor.withOpacity(0.67),
            ),
            title: Text(
              'Surat Keluar',
              style: poppinsTextStyle.copyWith(
                fontSize: 16,
                color: whiteColor.withOpacity(0.67),
                fontWeight: medium,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Iconify(
              Bi.tags_fill,
              size: 25,
              color: whiteColor.withOpacity(0.67),
            ),
            title: Text(
              'Kode Surat',
              style: poppinsTextStyle.copyWith(
                fontSize: 16,
                color: whiteColor.withOpacity(0.67),
                fontWeight: medium,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/kode-surat');
            },
          ),
          ListTile(
            leading: Iconify(
              Bi.calendar2_event_fill,
              size: 25,
              color: whiteColor.withOpacity(0.67),
            ),
            title: Text(
              'Agenda',
              style: poppinsTextStyle.copyWith(
                fontSize: 16,
                color: whiteColor.withOpacity(0.67),
                fontWeight: medium,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/agenda');
            },
          ),
        ],
      ),
    );
  }
}
