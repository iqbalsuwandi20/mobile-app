import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductStatusSectionWidget extends StatefulWidget {
  final String? title;
  final String? description;
  final bool initialValue;
  final ValueChanged<bool> onStatusChanged;
  final TextEditingController thresholdController;

  const ProductStatusSectionWidget({
    super.key,
    this.initialValue = false,
    required this.onStatusChanged,
    required this.thresholdController,
    this.title,
    this.description,
  });

  @override
  State<ProductStatusSectionWidget> createState() =>
      _ProductStatusSectionWidgetState();
}

class _ProductStatusSectionWidgetState
    extends State<ProductStatusSectionWidget> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0XFFE7EAF0), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title ?? 'Status Produk',
                style: GoogleFonts.inter(
                  color: const Color(0xFF020C1F),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.description ??
                    'Sistem akan menandai produk sebagai “Menipis” secara otomatis jika stoknya mendekati habis.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF5D6471),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    _isActive ? 'Aktif' : 'Nonaktif',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF020C1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                      widget.onStatusChanged(value);
                    },
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFFFF7900),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color(0xFFD1D1D6),
                    trackOutlineColor: WidgetStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_isActive) ...[
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Produk Menipis',
                style: GoogleFonts.inter(
                  color: const Color(0xFF020C1F),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0XFFE7EAF0), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextFormField(
                      controller: widget.thresholdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF020C1F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0XFFF7F8FA),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Unit',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF020C1F),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
