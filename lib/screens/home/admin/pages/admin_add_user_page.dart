import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../widgets/custom_action_button_widget.dart';
import '../../../../widgets/custom_dropdown_field_widget.dart';
import '../../../../widgets/custom_form_header_widget.dart';
import '../../../../widgets/custom_image_uploader_widget.dart';
import '../../../../widgets/custom_text_field_with_label_widget.dart';
import '../../../../widgets/product_status_section_widget.dart';

class AdminAddUserPage extends StatefulWidget {
  const AdminAddUserPage({super.key});

  static const String routeName = '/admin-add-user';

  @override
  State<AdminAddUserPage> createState() => _AdminAddUserPageState();
}

class _AdminAddUserPageState extends State<AdminAddUserPage> {
  final _usernameController = TextEditingController();
  final _thresholdController = TextEditingController();
  final _emailController = TextEditingController();

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE6E9F0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        PhosphorIconsRegular.caretLeft,
                        size: 24,
                        color: Color(0xFF050506),
                      ),
                    ),
                    const SizedBox.square(dimension: 12),
                    Text(
                      'Tambah Pengguna',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF050506),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox.square(dimension: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormHeaderWidget(
                      title: 'Tambah Pengguna',
                      description:
                          'Masukkan detail pengguna untuk menambahkannya ke manajemen pengguna',
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomImageUploaderWidget(
                      onImageSelected: (file) {
                        if (file != null) {
                          debugPrint('Gambar dipilih: ${file.path}');
                        }
                      },
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomTextFieldWithLabelWidget(
                      label: 'Nama',
                      hintText: 'Masukkan nama pengguna',
                      controller: _usernameController,
                      isRequired: true,
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomDropdownFieldWidget(
                      label: 'No Telepon',
                      isRequired: true,
                      hintText: 'Pilih kategori',
                      selectedValue: selectedCategory,
                      items: const [
                        'Elektronik',
                        'Pakaian',
                        'Peralatan Rumah Tangga',
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomTextFieldWithLabelWidget(
                      label: 'Email',
                      hintText: 'Masukkan email pengguna',
                      controller: _emailController,
                      isRequired: true,
                    ),
                    const SizedBox.square(dimension: 20),
                    ProductStatusSectionWidget(
                      title: 'Status Pengguna',
                      description:
                          'Jika pengguna telah lama tidak aktif anda bisa menonaktifkan status pengguna secara manual',
                      initialValue: false,
                      thresholdController: _thresholdController,
                      onStatusChanged: (isActive) {
                        debugPrint(
                          'Status pengguna: ${isActive ? "Aktif" : "Nonaktif"}',
                        );
                      },
                    ),
                    const SizedBox.square(dimension: 28),
                    CustomActionButtonWidget(
                      cancelText: 'Batal',
                      confirmText: 'Tambah',
                      onCancel: () => context.pop(),
                      onConfirm: () {
                        // TODO: Implement product addition Logic
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
