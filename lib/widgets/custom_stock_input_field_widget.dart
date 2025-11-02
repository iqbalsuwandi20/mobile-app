import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomStockInputFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String selectedUnit;
  final List<String> units;
  final ValueChanged<String?> onUnitChanged;

  const CustomStockInputFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.selectedUnit,
    required this.units,
    required this.onUnitChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0XFFE7EAF0), width: 1),
                ),
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '0',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF7C828C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF020C1F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0XFFE7EAF0), width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedUnit,
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
                    onChanged: onUnitChanged,
                    items: units
                        .map(
                          (unit) => DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
