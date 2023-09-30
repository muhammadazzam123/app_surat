import 'package:app_surat/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TambahSurat extends StatefulWidget {
  const TambahSurat({super.key});

  @override
  State<TambahSurat> createState() => _TambahSuratState();
}

class _TambahSuratState extends State<TambahSurat> {
  final _formState = GlobalKey<FormState>();
  TextEditingController nomorTextController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController asalTextController = TextEditingController();
  TextEditingController perihalTextController = TextEditingController();
  TextEditingController isiTextController = TextEditingController();
  TextEditingController pembuatTextController = TextEditingController();
  TextEditingController lampiranTextController = TextEditingController();
  TextEditingController kodeTextController = TextEditingController();
  late DateFormat dateFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('id');
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Tambah Surat Masuk',
        style: poppinsTextStyle.copyWith(
            fontSize: 20, fontWeight: semiBold, color: blackColor),
      ),
    );
  }

  Widget _formNomorSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomor Surat',
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
          controller: nomorTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan no surat..',
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
            label: Text(
              'masukkan tanggal surat..',
              style: poppinsTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
                color: grayColor,
              ),
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

  Widget _formAsalSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Asal Surat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: asalTextController,
          validator: (value) {
            if (value == '') {
              return "data tidak boleh kosong";
            }
            return null;
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan asal surat..',
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

  Widget _formPerihalIndex() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Perihal Index',
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
          controller: perihalTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan perihal index...',
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
              'masukkan isi surat...',
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

  Widget _formpembuatSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pembuat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        DropdownSearch<String>(
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            disabledItemFn: (String s) => s.startsWith('I'),
            constraints: const BoxConstraints(maxHeight: 170),
          ),
          items: const [
            'Ayam',
            'Sapi',
            'Kambing',
          ],
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin2, vertical: defaultMargin2 / 2),
              hintText: "pilih pembuat",
              hintStyle: poppinsTextStyle.copyWith(
                  color: grayColor, fontWeight: medium, fontSize: 12),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _formLampiranSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lampiran',
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
          controller: lampiranTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan lampiran..',
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

  Widget _formKodeSurat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kode Surat',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        DropdownSearch<String>(
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            disabledItemFn: (String s) => s.startsWith('I'),
            constraints: const BoxConstraints(maxHeight: 170),
          ),
          items: const [
            'Ayam',
            'Sapi',
            'Kambing',
          ],
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin2, vertical: defaultMargin2 / 2),
              hintText: "pilih kode surat",
              hintStyle: poppinsTextStyle.copyWith(
                  color: grayColor, fontWeight: medium, fontSize: 12),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
      ],
    );
  }

  Widget _file() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'File',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: 13, horizontal: defaultMargin2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: grayColor, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'file belum dipilih ...',
                style: poppinsTextStyle.copyWith(
                    fontSize: 12, fontWeight: semiBold, color: grayColor),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: primaryColor,
                  ),
                  child: Text(
                    'Pilih File',
                    style: poppinsTextStyle.copyWith(
                        fontSize: 12, fontWeight: semiBold, color: whiteColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonKirim() {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formState.currentState!.validate()) {}
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          'Kirim',
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
          child: Form(
            key: _formState,
            child: Column(
              children: [
                _title(),
                const SizedBox(height: 25),
                _formNomorSurat(),
                const SizedBox(height: 15),
                _formTanggalSurat(context),
                const SizedBox(height: 15),
                _formAsalSurat(),
                const SizedBox(height: 15),
                _formPerihalIndex(),
                const SizedBox(height: 15),
                _formIsiSurat(),
                const SizedBox(height: 15),
                _formpembuatSurat(),
                const SizedBox(height: 15),
                _formLampiranSurat(),
                const SizedBox(height: 15),
                _formKodeSurat(),
                const SizedBox(height: 15),
                _file(),
                const SizedBox(height: 30),
                _buttonKirim(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
