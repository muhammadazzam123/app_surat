import 'package:app_surat/theme.dart';
import 'package:app_surat/views/pegawai/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _showSnackBar() {
    SnackBar snackBar = SnackBar(
      content: const Text('Yay! A SnackBar!'),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
                  'Apakah anda yakin ingin keluar',
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
                  backgroundColor: MaterialStatePropertyAll(primaryColor)),
              onPressed: () {},
              child: Text('Keluar',
                  style: poppinsTextStyle.copyWith(
                      fontSize: 12, fontWeight: semiBold, color: whiteColor)),
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
          'Hello,',
          style: poppinsTextStyle.copyWith(
            fontSize: 15,
            fontWeight: semiBold,
            color: grayColor,
          ),
        ),
        Text(
          'Adelya Agustina',
          style: poppinsTextStyle.copyWith(
            fontSize: 26,
            fontWeight: semiBold,
            color: blackColor,
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
                  color: blackColor,
                  size: 25,
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
                    size: 25,
                    color: blackColor,
                  ))),
        ),
      ),
      drawer: const NavBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 1), _showSnackBar);
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              _title(),
              SizedBox(height: defaultMargin2),
              InkWell(
                child: ListContainer(color1,
                    Image.asset('assets/masuk.png', width: 85), 'Surat Masuk'),
                onTap: () {
                  Navigator.pushNamed(context, '/surat-masuk');
                },
              ),
              InkWell(
                child: ListContainer(
                    color2,
                    Image.asset('assets/keluar.png', width: 85),
                    'Surat keluar'),
                onTap: () {},
              ),
              InkWell(
                child: ListContainer(color3,
                    Image.asset('assets/kode.png', width: 85), 'Kode Surat'),
                onTap: () {
                  Navigator.pushNamed(context, '/kode-surat');
                },
              ),
              InkWell(
                child: ListContainer(color4,
                    Image.asset('assets/agenda.png', width: 85), 'Agenda'),
                onTap: () {
                  Navigator.pushNamed(context, '/agenda');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListContainer extends StatelessWidget {
  final Color color;
  final Image image;
  final String titleText;
  const ListContainer(this.color, this.image, this.titleText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultMargin2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin1, vertical: defaultMargin2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '0',
                  style: poppinsTextStyle.copyWith(
                    fontSize: 40,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                ),
                Text(
                  titleText,
                  style: poppinsTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
            image,
          ],
        ),
      ),
    );
  }
}