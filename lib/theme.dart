import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColor = const Color(0xff016ABF);
Color secondaryColor = const Color(0xffFFCA28);
Color thirdColor = const Color(0xff34393F);
Color grayColor = const Color(0xff9E9E9E);
Color blackColor = const Color(0xff333333);
Color whiteColor = const Color(0xfffafafa);

TextStyle poppinsTextStyle = GoogleFonts.poppins();

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

double defaultMargin1 = 30.0;
double defaultMargin2 = 20.0;

final defaultShadow = BoxShadow(
  offset: const Offset(0, 5),
  blurRadius: 20,
  color: const Color(0xff333333).withOpacity(0.15),
);
