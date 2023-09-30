import 'package:app_surat/services/auth_service.dart';
import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formState = GlobalKey<FormState>();
  bool passToggle = true;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool _isLoading = false;

  void _showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _validateForm() {
    if (_formState.currentState!.validate()) {
      _login();
    }
  }

  void _login() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final Map<String, dynamic> data = {
        "username": usernameTextController.text,
        "password": passwordTextController.text
      };

      final response = await AuthService().authLogin(data);

      if (response['success']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('appToken', response['token']);
        await prefs.setInt('userId', response['user']['id']);
        int level = response['user']['jabatan']['level'];
        await prefs.setInt('userLevel', level);

        if (context.mounted) {
          if (level == 1) {
            Navigator.pushReplacementNamed(context, '/home-petugas');
          } else {
            _showSnackBar('Belum ada level');
          }
        }
      } else {
        _showSnackBar(response['message']);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error :$e');
    }
  }

  Widget _logo() {
    return Image.asset(
      'assets/logo.png',
      height: 145,
    );
  }

  Widget _usernameInput() {
    return TextFormField(
      controller: usernameTextController,
      validator: (value) {
        if (value == '') {
          return "username tidak boleh kosong";
        }
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            size: 20,
            color: grayColor,
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: primaryColor)),
          label: Text(
            'username',
            style: poppinsTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
              color: grayColor,
            ),
          )),
    );
  }

  Widget _passwordInput() {
    return TextFormField(
      controller: passwordTextController,
      obscureText: passToggle,
      validator: (value) {
        if (value!.isEmpty) {
          return "password tidak boleh kosong";
        } else if (passwordTextController.text.length < 6) {
          return "password kurang dari 6 karakter";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          size: 20,
          color: grayColor,
        ),
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              passToggle = !passToggle;
            });
          },
          child: Icon(
            passToggle ? Icons.visibility : Icons.visibility_off,
            color: passToggle ? grayColor : primaryColor,
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: primaryColor)),
        label: Text(
          'password',
          style: poppinsTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium,
            color: grayColor,
          ),
        ),
      ),
    );
  }

  Widget _buttonMasuk() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: _validateForm,
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                'Masuk',
                style: poppinsTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold, color: Colors.white),
              ),
      ),
    );
  }

  Widget _testMasuk() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/home-admin');
          },
          child: Text(
            'Halaman Admin',
            style: poppinsTextStyle.copyWith(
                fontSize: 20, fontWeight: semiBold, color: grayColor),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Halaman Pimpinan',
            style: poppinsTextStyle.copyWith(
                fontSize: 20, fontWeight: semiBold, color: grayColor),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin1),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  _logo(),
                  const SizedBox(height: 50),
                  _usernameInput(),
                  const SizedBox(height: 20),
                  _passwordInput(),
                  const SizedBox(height: 50),
                  _buttonMasuk(),
                  const SizedBox(height: 20),
                  _testMasuk(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
