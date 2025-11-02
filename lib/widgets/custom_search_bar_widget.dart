import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomSearchBarWidget extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchTap;
  final bool showBackButton;
  final bool showMenuButton;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;
  final Color? textColor;

  const CustomSearchBarWidget({
    super.key,
    this.hintText,
    this.onBackPressed,
    this.onMenuPressed,
    this.onSearchTap,
    this.showBackButton = true,
    this.showMenuButton = true,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0XFFE6E9F0),
    this.iconColor = const Color(0XFF333333),
    this.textColor = const Color(0xFF5B5C63),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton)
          IconButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context),
            icon: const Icon(
              PhosphorIconsRegular.caretLeft,
              color: Color(0XFF050506),
              size: 24,
            ),
          ),
        if (showBackButton) const SizedBox.square(dimension: 12),
        Expanded(
          child: GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: borderColor!, width: 2),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Icon(
                    PhosphorIconsRegular.magnifyingGlass,
                    color: iconColor,
                    size: 16,
                  ),
                  const SizedBox.square(dimension: 8),
                  Text(
                    hintText ?? '',
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showMenuButton) const SizedBox.square(dimension: 12),
        if (showMenuButton)
          IconButton(
            onPressed: onMenuPressed,
            icon: const Icon(
              PhosphorIconsRegular.dotsThreeVertical,
              color: Color(0XFF050506),
              size: 24,
            ),
          ),
      ],
    );
  }
}
