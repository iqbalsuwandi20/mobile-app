import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWithLabelWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  const CustomTextFieldWithLabelWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF020C1F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isRequired)
              Baseline(
                baseline: 14,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  '*',
                  style: GoogleFonts.inter(
                    color: const Color(0XFFEB2F2F),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          style: GoogleFonts.inter(
            color: const Color(0xFF050506),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF7C828C),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0XFFE7EAF0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0XFFE7EAF0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0XFFE7EAF0), width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}
