import 'package:app_surat/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class EditPegawai extends StatefulWidget {
  const EditPegawai({super.key});

  @override
  State<EditPegawai> createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  final _formState = GlobalKey<FormState>();
  TextEditingController nipTextController = TextEditingController();
  TextEditingController namaTextController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController tempatTextController = TextEditingController();
  TextEditingController tanggalTextController = TextEditingController();
  TextEditingController nomorTextController = TextEditingController();
  TextEditingController alamatTextController = TextEditingController();
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
        'Edit Pegawai',
        style: poppinsTextStyle.copyWith(
            fontSize: 20, fontWeight: semiBold, color: blackColor),
      ),
    );
  }

  Widget _formNIP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NIP',
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
          controller: nipTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan NIP...',
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

  Widget _formNamaPegawai() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama Pegawai',
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
          controller: namaTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan nama pegawai...',
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

  Widget _formJenisKelamin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Kelamin',
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
            constraints: const BoxConstraints(maxHeight: 130),
          ),
          items: const [
            'Laki-laki',
            'Perempuan',
          ],
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultMargin2, vertical: defaultMargin2 / 2),
              hintText: "Silahkan Pilih",
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

  Widget _formTempatLahir() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tempat Lahir',
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
          controller: tempatTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan tempat lahir...',
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

  Widget _formTanggalLahir(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tanggal lahir',
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
          controller: tanggalTextController,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.date_range_outlined,
              size: 20,
              color: grayColor,
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
                tanggalTextController.text = formattedDate;
              });
            }
          },
        )
      ],
    );
  }

  Widget _formNoTelp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nomor Telepon',
          style: poppinsTextStyle.copyWith(
            fontSize: 10,
            fontWeight: semiBold,
            color: blackColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: nomorTextController,
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
              'masukkan asal nomor telepon..',
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

  Widget _formAlamat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat',
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
          controller: alamatTextController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: primaryColor)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: Text(
              'masukkan alamat...',
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
          'Edit',
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
                _formNIP(),
                const SizedBox(height: 15),
                _formNamaPegawai(),
                const SizedBox(height: 15),
                _formJenisKelamin(),
                const SizedBox(height: 15),
                _formTempatLahir(),
                const SizedBox(height: 15),
                _formTanggalLahir(context),
                const SizedBox(height: 15),
                _formNoTelp(),
                const SizedBox(height: 15),
                _formAlamat(),
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
