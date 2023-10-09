import 'package:app_surat/models/kode_surat_model.dart';
import 'package:app_surat/services/kode_surat_service.dart';
import 'package:app_surat/services/snackbar_service.dart';
import 'package:app_surat/theme.dart';
import 'package:app_surat/views/petugas/kodesurat/kode_surat_edit_page.dart';
import 'package:app_surat/views/petugas/navbar_petugas.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class KodeSuratPage extends StatefulWidget {
  const KodeSuratPage({super.key});

  @override
  State<KodeSuratPage> createState() => _KodeSuratPageState();
}

class _KodeSuratPageState extends State<KodeSuratPage> {
  TextEditingController searchTextController = TextEditingController();
  late List<KodeSurat> _kodeSurats;
  List<KodeSurat> _filteredKodeSurats = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getKodeSurats();
  }

  void _getKodeSurats() async {
    setState(() {
      _isLoading = true;
    });
    _kodeSurats = await KodeSuratService().getKodeSurats();
    _filteredKodeSurats = _kodeSurats;
    setState(() {
      _isLoading = false;
    });
  }

  void _deleteKodeSurat(int? kodeSuratId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Response response =
          await KodeSuratService().deleteKodeSurat(kodeSuratId!);

      if (response.statusCode == 200) {
        _getKodeSurats();
        if (mounted) {
          Navigator.pop(context);
          SnackBarService()
              .showSnackBar('${response.data['message']}', context);
        }
      } else {
        if (mounted) {
          SnackBarService()
              .showSnackBar('${response.data['message']}', context);
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        SnackBarService().showSnackBar('e', context);
      }
    }
  }

  void _searchKodeSurat(String text) {
    setState(() {
      _filteredKodeSurats = _kodeSurats
          .where((element) =>
              element.namaKode!.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _showMyDialog(BuildContext context, int kodeSuratId) async {
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
                  'Apakah Anda yakin ingin menghapus kode surat ini?',
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
              onPressed: () {
                _deleteKodeSurat(kodeSuratId);
              },
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
          'Kode Surat',
          style: poppinsTextStyle.copyWith(
            fontSize: 26,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(width: 15),
        SizedBox(
          height: 25,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/kode-surat/tambah');
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
        onChanged: (String value) => _searchKodeSurat(value),
        controller: searchTextController,
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
            'Cari kode surat ...',
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
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            _getKodeSurats();
          });
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          itemCount: _filteredKodeSurats.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: defaultMargin2),
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: defaultMargin2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                boxShadow: [defaultShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_filteredKodeSurats[index].kode}',
                    style: poppinsTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_filteredKodeSurats[index].namaKode}',
                    style: poppinsTextStyle.copyWith(
                      fontSize: 11,
                      fontWeight: semiBold,
                      color: grayColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_filteredKodeSurats[index].keterangan}',
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KodeSuratEditPage(
                                      kodeSurat: _filteredKodeSurats[index])));
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
                          _showMyDialog(
                              context, _filteredKodeSurats[index].id!);
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
              const SizedBox(height: 12),
              _columnSerach(),
              const SizedBox(height: 27),
              _isLoading ? const CircularProgressIndicator() : _listData(),
            ],
          ),
        ),
      ),
    );
  }
}
