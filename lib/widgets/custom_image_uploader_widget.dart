import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomImageUploaderWidget extends StatefulWidget {
  final String buttonText;
  final void Function(File?)? onImageSelected;
  final double height;
  final double borderRadius;

  const CustomImageUploaderWidget({
    super.key,
    this.buttonText = 'Unggah Gambar',
    this.onImageSelected,
    this.height = 180,
    this.borderRadius = 10,
  });

  @override
  State<CustomImageUploaderWidget> createState() =>
      _CustomImageUploaderWidgetState();
}

class _CustomImageUploaderWidgetState extends State<CustomImageUploaderWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final file = File(image.path);
      final fileSize = await file.length();
      const maxFileSize = 2 * 1024 * 1024;

      if (fileSize > maxFileSize) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ukuran gambar maksimal 2MB'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _selectedImage = file;
      });
      widget.onImageSelected?.call(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: const Color(0XFFF7F8FA),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            image: _selectedImage != null
                ? DecorationImage(
                    image: FileImage(_selectedImage!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _selectedImage == null
              ? const Center(
                  child: Icon(
                    PhosphorIconsDuotone.imageSquare,
                    size: 48,
                    color: Color(0XFF7C828C),
                  ),
                )
              : null,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Color(0XFFE7EAF0), width: 1),
              ),
            ),
            onPressed: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  PhosphorIconsRegular.uploadSimple,
                  size: 20,
                  color: Color(0XFF020C1F),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.buttonText,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF020C1F),
                    fontSize: 14,
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
