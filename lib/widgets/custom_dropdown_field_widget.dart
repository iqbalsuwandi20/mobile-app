import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomDropdownFieldWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final String? selectedValue;
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.selectedValue,
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0XFFE7EAF0), width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              hint: Text(
                hintText,
                style: GoogleFonts.inter(
                  color: const Color(0xFF7C828C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              icon: const Icon(
                PhosphorIconsRegular.caretDown,
                size: 20,
                color: Color(0XFF020C1F),
              ),
              style: GoogleFonts.inter(
                color: const Color(0xFF020C1F),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              onChanged: onChanged,
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
