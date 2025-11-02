import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomActionButtonWidget extends StatelessWidget {
  final String cancelText;
  final String confirmText;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final Color confirmColor;
  final IconData? confirmIcon;
  final bool showBorderOnCancel;
  final bool isConfirmEnabled;

  const CustomActionButtonWidget({
    super.key,
    required this.cancelText,
    required this.confirmText,
    required this.onCancel,
    required this.onConfirm,
    this.confirmColor = const Color(0XFFFF7900),
    this.confirmIcon = PhosphorIconsRegular.check,
    this.showBorderOnCancel = true,
    this.isConfirmEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: showBorderOnCancel
                    ? const BorderSide(color: Color(0XFFE7EAF0), width: 1)
                    : BorderSide.none,
              ),
            ),
            onPressed: onCancel,
            child: Text(
              cancelText,
              style: GoogleFonts.inter(
                color: const Color(0xFF020C1F),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: isConfirmEnabled
                  ? confirmColor
                  : const Color(0xFFC0C5CC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: isConfirmEnabled ? onConfirm : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  confirmText,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (confirmIcon != null) ...[
                  const SizedBox(width: 8),
                  Icon(confirmIcon, color: Colors.white, size: 20),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
