import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/products/add_product_model.dart';
import '../../../../models/products/get_all_product_model.dart';
import '../../../../viewmodels/products/product_view_model.dart';
import '../../../../widgets/custom_action_button_widget.dart';
import '../../../../widgets/custom_dropdown_field_widget.dart';
import '../../../../widgets/custom_form_header_widget.dart';
import '../../../../widgets/custom_image_uploader_widget.dart';
import '../../../../widgets/custom_price_field_widget.dart';
import '../../../../widgets/custom_stock_input_field_widget.dart';
import '../../../../widgets/custom_text_area_field_widget.dart';
import '../../../../widgets/custom_text_field_with_label_widget.dart';
import '../../../../widgets/product_status_section_widget.dart';

class AdminAddProductPage extends StatefulWidget {
  final GetAllProductModel? product;

  const AdminAddProductPage({super.key, this.product});

  static const String routeName = '/admin-add-product';

  @override
  State<AdminAddProductPage> createState() => _AdminAddProductPageState();
}

class _AdminAddProductPageState extends State<AdminAddProductPage> {
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _thresholdController = TextEditingController();
  final _stockController = TextEditingController();

  String selectedUnit = 'Unit';
  String? selectedCategory;

  bool isActive = false;

  File? _selectedImageFile;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    if (p != null) {
      _productNameController.text = p.name;
      _productDescriptionController.text = p.description;
      _priceController.text = p.price.toString();
      _stockController.text = p.stock.toString();
      selectedUnit = p.unit;
      selectedCategory = p.category;
      isActive = p.isActive;
      _thresholdController.text = p.lowStockLimit.toString();
    }

    _productNameController.addListener(_onFormChanged);
    _productDescriptionController.addListener(_onFormChanged);
    _priceController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {});
  }

  bool get isFormValid {
    return _productNameController.text.isNotEmpty &&
        selectedCategory != null &&
        _productDescriptionController.text.isNotEmpty &&
        _priceController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final addProductVM = context.watch<ProductViewModel>();

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
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        PhosphorIconsRegular.caretLeft,
                        size: 24,
                        color: Color(0xFF050506),
                      ),
                    ),
                    const SizedBox.square(dimension: 12),
                    Text(
                      widget.product == null ? 'Tambah Produk' : 'Ubah Produk',
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
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormHeaderWidget(
                      title: widget.product == null
                          ? 'Tambah Produk'
                          : 'Ubah Produk',
                      description: widget.product == null
                          ? 'Masukkan detail produk untuk menambahkannya ke inventaris.'
                          : 'Perbarui detail produk yang sudah ada.',
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomImageUploaderWidget(
                      onImageSelected: (file) {
                        if (file != null) {
                          setState(() {
                            _selectedImageFile = file;
                          });
                        }
                      },
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomTextFieldWithLabelWidget(
                      label: 'Nama Produk',
                      hintText: 'Masukkan nama produk',
                      controller: _productNameController,
                      isRequired: true,
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomDropdownFieldWidget(
                      label: 'Kategori Produk',
                      isRequired: true,
                      hintText: 'Pilih kategori',
                      selectedValue: selectedCategory,
                      items: const ['Meja', 'Kursi', 'Lemari', 'Sofa'],
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomTextAreaFieldWidget(
                      label: 'Deskripsi Produk',
                      hintText: 'Masukkan deskripsi produk',
                      controller: _productDescriptionController,
                      isRequired: true,
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomPriceFieldWidget(
                      label: 'Harga Satuan',
                      isRequired: true,
                      controller: _priceController,
                    ),
                    const SizedBox.square(dimension: 20),
                    CustomStockInputFieldWidget(
                      label: 'Stok Awal',
                      controller: _stockController,
                      selectedUnit: selectedUnit,
                      units: const ['Unit', 'Pcs', 'Box', 'Lusin'],
                      onUnitChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedUnit = value;
                          });
                        }
                      },
                    ),
                    const SizedBox.square(dimension: 20),
                    ProductStatusSectionWidget(
                      initialValue: false,
                      thresholdController: _thresholdController,
                      onStatusChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                    const SizedBox.square(dimension: 28),
                    CustomActionButtonWidget(
                      cancelText: 'Batal',
                      confirmText: addProductVM.isLoading
                          ? 'Memproses...'
                          : (widget.product == null ? 'Tambah' : 'Ubah'),
                      isConfirmEnabled: isFormValid && !addProductVM.isLoading,
                      onCancel: () => context.pop(),
                      onConfirm: () async {
                        if (!isFormValid) return;

                        if (widget.product == null) {
                          final product = AddProductModel(
                            name: _productNameController.text.trim(),
                            category: selectedCategory ?? '',
                            description: _productDescriptionController.text
                                .trim(),
                            price: int.parse(
                              _priceController.text.replaceAll('.', ''),
                            ),
                            stock: int.tryParse(_stockController.text) ?? 0,
                            unit: selectedUnit,
                            isActive: isActive,
                            lowStockLimit:
                                int.tryParse(_thresholdController.text) ?? 0,
                          );
                          await addProductVM.addProduct(
                            product: product,
                            image: _selectedImageFile ?? File(''),
                            onSuccess: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    '✅ Produk berhasil ditambahkan!',
                                  ),
                                ),
                              );
                              context.pop(true);
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '❌ Gagal menambahkan produk: $error',
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          await addProductVM.updateProduct(
                            id: widget.product!.id,
                            data: {
                              'name': _productNameController.text.trim(),
                              'category': selectedCategory ?? '',
                              'description': _productDescriptionController.text
                                  .trim(),
                              'price': int.parse(
                                _priceController.text.replaceAll('.', ''),
                              ),
                              'stock':
                                  int.tryParse(_stockController.text) ??
                                  widget.product!.stock,
                              'unit': selectedUnit,
                              'is_active': isActive,
                              'low_stock_limit':
                                  int.tryParse(_thresholdController.text) ??
                                  widget.product!.lowStockLimit,
                            },
                            image: _selectedImageFile,
                            onSuccess: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    '✅ Produk berhasil diperbarui!',
                                  ),
                                ),
                              );
                              context.pop(true);
                            },
                            onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '❌ Gagal memperbarui produk: $error',
                                  ),
                                ),
                              );
                            },
                          );
                        }
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
