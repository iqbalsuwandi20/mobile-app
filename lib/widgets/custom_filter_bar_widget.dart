import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomFilterBarWidget extends StatelessWidget {
  final String filterLabel;
  final String sortLabel;
  final VoidCallback? onFilterTap;
  final VoidCallback? onSortTap;

  const CustomFilterBarWidget({
    super.key,
    required this.filterLabel,
    required this.sortLabel,
    this.onFilterTap,
    this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: onFilterTap,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0XFFE6E9F0), width: 1),
                ),
                child: Row(
                  children: [
                    Text(
                      filterLabel,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF050506),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      PhosphorIconsRegular.caretDown,
                      size: 16,
                      color: Color(0XFF050506),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onSortTap,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: const Color(0XFFE6E9F0), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.arrowsDownUp,
                      size: 16,
                      color: Color(0XFF050506),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      sortLabel,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF050506),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
