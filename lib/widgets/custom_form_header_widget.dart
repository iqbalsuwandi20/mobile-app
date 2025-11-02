import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormHeaderWidget extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsetsGeometry padding;
  final double spacing;

  const CustomFormHeaderWidget({
    super.key,
    required this.title,
    required this.description,
    this.padding = const EdgeInsets.only(bottom: 16),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF020C1F),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: spacing),
          Text(
            description,
            style: GoogleFonts.inter(
              color: const Color(0xFF5D6471),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
