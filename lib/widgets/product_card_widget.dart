import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProductCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String productName;
  final String price;
  final String category;
  final String stock;
  final String? statusLabel;
  final Color? statusColor;
  final VoidCallback? onMenuTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onEditStatusTap;
  final VoidCallback? onDeleteTap;

  const ProductCardWidget({
    super.key,
    this.imageUrl,
    required this.productName,
    required this.price,
    required this.category,
    required this.stock,
    this.statusLabel,
    this.statusColor = const Color(0XFFE6871A),
    this.onMenuTap,
    this.onEditTap,
    this.onEditStatusTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageUrl != null && imageUrl!.isNotEmpty
                    ? Image.network(
                        imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0XFFE6E9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              PhosphorIconsRegular.image,
                              color: Color(0XFF5B5C63),
                              size: 24,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0XFFE6E9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0XFFE6871A),
                            ),
                          );
                        },
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0XFFE6E9F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          PhosphorIconsRegular.image,
                          color: Color(0XFF5B5C63),
                          size: 24,
                        ),
                      ),
              ),
              const SizedBox.square(dimension: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF050506),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF050506),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0XFFF5F7FA),
                        border: Border.all(
                          color: const Color(0xFFE6E9F0),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF050506),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox.square(dimension: 8),
                    Row(
                      children: [
                        Text(
                          'Stok : ',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF5B5C63),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          stock,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF050506),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (statusLabel != null) ...[
                          const SizedBox.square(dimension: 12),
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              PhosphorIconsRegular.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                          const SizedBox.square(dimension: 4),
                          Text(
                            statusLabel!,
                            style: GoogleFonts.inter(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onMenuTap,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIconsRegular.dotsThreeVertical,
                    size: 20,
                    color: Color(0XFF333333),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox.square(dimension: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEditTap,
                  icon: const Icon(
                    PhosphorIconsRegular.pencilSimple,
                    color: Color(0XFF050506),
                    size: 20,
                  ),
                  label: Text(
                    'Ubah',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF050506),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0XFFE6E9F0), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox.square(dimension: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onEditStatusTap,
                  icon: const Icon(
                    PhosphorIconsRegular.arrowClockwise,
                    color: Color(0XFF050506),
                    size: 20,
                  ),
                  label: Text(
                    'Ubah Status',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF050506),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0XFFE6E9F0), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox.square(dimension: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDeleteTap,
                  icon: const Icon(
                    PhosphorIconsRegular.trashSimple,
                    color: Color(0XFFEB2F2F),
                    size: 20,
                  ),
                  label: Text(
                    'Hapus',
                    style: GoogleFonts.inter(
                      color: const Color(0XFFEB2F2F),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0XFFEB2F2F), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
