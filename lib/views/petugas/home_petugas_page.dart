import 'package:app_surat/models/counted_data_model.dart';
import 'package:app_surat/services/auth_service.dart';
import 'package:app_surat/services/counted_data_service.dart';
import 'package:app_surat/theme.dart';
import 'package:app_surat/views/petugas/navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CountedDataPetugas> _countedDataPetugas;

  @override
  void initState() {
    super.initState();
    _getCountedData();
  }

  void _getCountedData() {
    setState(() {
      _countedDataPetugas = CountedDataService().getCountedDataPetugas();
    });
  }

  void _logout() async {
    try {
      final response = await AuthService().authLogout();
      if (response.statusCode == 200) {
        SharedPreferences refs = await SharedPreferences.getInstance();
        refs.remove('appToken');
        refs.remove('userId');
        refs.remove('userLevel');
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        }
      }
    } catch (e) {
      _showSnackBar('$e');
    }
  }

  _showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
    );
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
              onPressed: _logout,
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
            return Future.delayed(const Duration(seconds: 1), _getCountedData);
          },
          child: FutureBuilder(
              future: _countedDataPetugas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final countedData = snapshot.data;
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    children: [
                      _title(),
                      SizedBox(height: defaultMargin2),
                      InkWell(
                        child: ListContainer(
                            color1,
                            Image.asset('assets/masuk.png', width: 85),
                            'Surat Masuk',
                            countedData!.suratMasuks!),
                        onTap: () {
                          Navigator.pushNamed(context, '/surat-masuk');
                        },
                      ),
                      InkWell(
                        child: ListContainer(
                            color2,
                            Image.asset('assets/keluar.png', width: 85),
                            'Surat keluar',
                            countedData.suratKeluars!),
                        onTap: () {},
                      ),
                      InkWell(
                        child: ListContainer(
                            color3,
                            Image.asset('assets/kode.png', width: 85),
                            'Kode Surat',
                            countedData.kodeSurats!),
                        onTap: () {
                          Navigator.pushNamed(context, '/kode-surat');
                        },
                      ),
                      InkWell(
                        child: ListContainer(
                            color4,
                            Image.asset('assets/agenda.png', width: 85),
                            'Agenda',
                            countedData.agendaUndangans!),
                        onTap: () {
                          Navigator.pushNamed(context, '/agenda');
                        },
                      ),
                    ],
                  );
                }
                return const Text(
                    'Terjadi kesalahan. Cobalah beberapa saat lagi.');
              }),
        ),
      ),
    );
  }
}

class ListContainer extends StatelessWidget {
  final Color color;
  final Image image;
  final String titleText;
  final int jumlahData;
  const ListContainer(this.color, this.image, this.titleText, this.jumlahData,
      {super.key});

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
                  '$jumlahData',
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
