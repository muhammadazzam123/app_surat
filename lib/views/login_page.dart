import 'package:app_surat/theme.dart';
import 'package:flutter/material.dart';

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
        onPressed: () {
          if (_formState.currentState!.validate()) {
            Navigator.pushNamed(context, '/home');
            usernameTextController.clear();
            passwordTextController.clear();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          'Masuk',
          style: poppinsTextStyle.copyWith(
              fontSize: 16, fontWeight: semiBold, color: Colors.white),
        ),
      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
