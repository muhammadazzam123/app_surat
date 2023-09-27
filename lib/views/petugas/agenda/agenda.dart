import 'package:app_surat/theme.dart';
import 'package:app_surat/views/pegawai/navbar.dart';
import 'package:flutter/material.dart';

class AgendaSurat extends StatelessWidget {
  const AgendaSurat({super.key});

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Apakah Anda yakin ingin menghapus agenda undangan ini?',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                    color: blackColor,
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
                  fontWeight: semiBold,
                  color: blackColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(color4)),
              onPressed: () {},
              child: Text('Hapus',
                  style: poppinsTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold, color: whiteColor)),
            ),
          ],
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    return Row(
      children: [
        Text(
          'Agenda Undangan',
          style: poppinsTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(width: 15),
        SizedBox(
          height: 25,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/tambah-agenda');
            },
            icon: Icon(
              Icons.add,
              size: 15,
              color: whiteColor,
            ),
            label: Text(
              'Tambah Data',
              style: poppinsTextStyle.copyWith(
                fontSize: 11,
                fontWeight: semiBold,
                color: whiteColor,
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: primaryColor,
            ),
          ),
        )
      ],
    );
  }

  Widget _columnSerach() {
    return SizedBox(
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_outlined,
            size: 20,
            color: grayColor,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: primaryColor)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Text(
            'Mau cari apa....',
            style: poppinsTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
              color: grayColor,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: defaultMargin2, vertical: 17),
        ),
      ),
    );
  }

  Widget _listData() {
    return Flexible(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: defaultMargin2),
            padding:
                EdgeInsets.symmetric(vertical: 10, horizontal: defaultMargin2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: whiteColor,
              boxShadow: [defaultShadow],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Elena Ryan',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '07 Sep 1991',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 11,
                    fontWeight: semiBold,
                    color: grayColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '4698 Fisher Forges Apt. 446 Hoegerfort, MO 63503-0900',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 11,
                    fontWeight: medium,
                    color: grayColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/detail-agenda');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 13),
                        decoration: BoxDecoration(
                          color: color1,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Detail',
                          style: poppinsTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: semiBold,
                              color: whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/edit-agenda');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 13),
                        decoration: BoxDecoration(
                          color: color3,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Edit',
                          style: poppinsTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: semiBold,
                              color: whiteColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () {
                        _showMyDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 13),
                        decoration: BoxDecoration(
                          color: color4,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Hapus',
                          style: poppinsTextStyle.copyWith(
                              fontSize: 11,
                              fontWeight: semiBold,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
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
          child: Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    size: 25,
                    color: blackColor,
                  ))),
        ),
      ),
      drawer: const NavBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 1.1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
          child: Column(
            children: [
              _title(context),
              const SizedBox(height: 20),
              _columnSerach(),
              const SizedBox(height: 27),
              _listData(),
            ],
          ),
        ),
      ),
    );
  }
}
