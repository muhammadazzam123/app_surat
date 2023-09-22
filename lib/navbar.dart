import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
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
                  'SIPS',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 25,
                    fontWeight: regular,
                    color: whiteColor,
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
                  'Admin',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                    color: whiteColor,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Divider(color: grayColor),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 20,
              color: whiteColor,
            ),
            title: Text(
              'Dashboard',
              style: poppinsTextStyle.copyWith(
                fontSize: 13,
                color: whiteColor,
                fontWeight: medium,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 20,
              color: whiteColor,
            ),
            title: Text(
              'Pegawai',
              style: poppinsTextStyle.copyWith(
                fontSize: 13,
                color: whiteColor,
                fontWeight: medium,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.dashboard,
              size: 20,
              color: whiteColor,
            ),
            title: Text(
              'Jabatan',
              style: poppinsTextStyle.copyWith(
                fontSize: 13,
                color: whiteColor,
                fontWeight: medium,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.lock_person,
              size: 20,
              color: whiteColor,
            ),
            title: Text(
              'Hak Akses',
              style: poppinsTextStyle.copyWith(
                fontSize: 13,
                color: whiteColor,
                fontWeight: medium,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
