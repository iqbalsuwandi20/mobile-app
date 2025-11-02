import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterBarWidget extends StatelessWidget {
  final String? sortLabel;
  final VoidCallback? onSortTap;
  final IconData? sortTrailingIcon;
  final String? filterLabel;
  final VoidCallback? onFilterTap;
  final int? filterBadgeCount;
  final String? orderLabel;
  final VoidCallback? onOrderTap;
  final IconData? orderLeadingIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? badgeColor;
  final Color? badgeTextColor;

  const FilterBarWidget({
    super.key,
    this.sortLabel,
    this.onSortTap,
    this.sortTrailingIcon = PhosphorIconsRegular.caretDown,
    this.filterLabel,
    this.onFilterTap,
    this.filterBadgeCount,
    this.orderLabel,
    this.onOrderTap,
    this.orderLeadingIcon = PhosphorIconsRegular.arrowsDownUp,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0XFFE6E9F0),
    this.textColor = const Color(0xFF050506),
    this.badgeColor = const Color(0XFFE24040),
    this.badgeTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (sortLabel != null) ...[
          GestureDetector(
            onTap: onSortTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor!, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sortLabel!,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (sortTrailingIcon != null) ...[
                    const SizedBox(width: 4),
                    Icon(sortTrailingIcon, color: textColor, size: 16),
                  ],
                ],
              ),
            ),
          ),
          if (filterLabel != null || orderLabel != null)
            const SizedBox(width: 12),
        ],
        if (filterLabel != null) ...[
          GestureDetector(
            onTap: onFilterTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor!, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (filterBadgeCount != null && filterBadgeCount! > 0) ...[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        filterBadgeCount.toString(),
                        style: GoogleFonts.inter(
                          color: badgeTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    filterLabel!,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (orderLabel != null) const SizedBox(width: 12),
        ],
        if (orderLabel != null)
          GestureDetector(
            onTap: onOrderTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor!, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (orderLeadingIcon != null) ...[
                    Icon(orderLeadingIcon, color: textColor, size: 16),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    orderLabel!,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
