import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextFormFieldWidget({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: GoogleFonts.inter(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: Color(0XFF050506),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          obscureText: obscureText,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          validator: validator,
          style: GoogleFonts.inter(
            color: const Color(0xFF7A7C81),
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF7A7C81),
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color(0XFFE6E9F0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color(0XFFE6E9F0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Color(0XFFE6E9F0), width: 1),
            ),
            contentPadding: EdgeInsets.all(screenWidth * 0.03),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
