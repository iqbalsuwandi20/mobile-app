import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../viewmodels/products/product_view_model.dart';
import '../../../widgets/custom_search_bar_widget.dart';
import '../../../widgets/filter_bar_widget.dart';
import '../../../widgets/product_card_widget.dart';
import 'pages/admin_add_product_page.dart';

class AdminProductListScreen extends StatefulWidget {
  const AdminProductListScreen({super.key});

  static const String routeName = '/admin-product-list';

  @override
  State<AdminProductListScreen> createState() => _AdminProductListScreenState();
}

class _AdminProductListScreenState extends State<AdminProductListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      final productVM = context.read<ProductViewModel>();
      productVM.getAllProducts(
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error), backgroundColor: Colors.red),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productVM = context.watch<ProductViewModel>();
    final products = productVM.products;

    return Scaffold(
      backgroundColor: const Color(0XFFE6E9F0),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Column(
                children: [
                  CustomSearchBarWidget(
                    hintText: 'Cari produk',
                    onBackPressed: () {},
                    onMenuPressed: () {},
                    onSearchTap: () {},
                  ),
                  const SizedBox.square(dimension: 16),
                  FilterBarWidget(
                    sortLabel: 'Nama Produk',
                    onSortTap: () {},
                    filterLabel: 'Filter',
                    filterBadgeCount: 2,
                    onFilterTap: () {},
                    orderLabel: 'Asc',
                    onOrderTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Builder(
                builder: (_) {
                  if (productVM.isFetching) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (productVM.errorMessage != null) {
                    return Center(
                      child: Text(
                        productVM.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (products.isEmpty) {
                    return const Center(
                      child: Text('Belum ada produk yang ditambahkan.'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await productVM.getAllProducts();
                    },
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        Color statusColor;
                        String statusLabel;
                        if (product.stock == 0) {
                          statusColor = const Color(0xFFEB2F2F);
                          statusLabel = 'Habis';
                        } else if (product.stock <= product.lowStockLimit) {
                          statusColor = const Color(0xFFE6871A);
                          statusLabel = 'Menipis';
                        } else {
                          statusColor = const Color(0xFF4CAF50);
                          statusLabel = 'Tersedia';
                        }

                        final priceFormatted =
                            'Rp${product.price.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';

                        return Column(
                          children: [
                            ProductCardWidget(
                              imageUrl: product.imageUrl,
                              productName: product.name,
                              price: priceFormatted,
                              category: product.category,
                              stock: product.stock.toString(),
                              statusLabel: statusLabel,
                              statusColor: statusColor,
                              onMenuTap: () {
                                debugPrint('Menu tapped for ${product.name}');
                              },
                              onEditTap: () async {
                                final result = await context.push(
                                  AdminAddProductPage.routeName,
                                  extra: product,
                                );
                                if (result == true && context.mounted) {
                                  context
                                      .read<ProductViewModel>()
                                      .getAllProducts();
                                }
                              },
                              onEditStatusTap: () {
                                debugPrint('Edit status ${product.name}');
                              },
                              onDeleteTap: () async {
                                await productVM.deleteProduct(
                                  id: product.id,
                                  onSuccess: (msg) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(msg),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  onError: (err) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(err),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            if (index < products.length - 1)
                              const SizedBox.square(dimension: 8),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await context.push(AdminAddProductPage.routeName);
            if (result == true && context.mounted) {
              context.read<ProductViewModel>().getAllProducts();
            }
          },
          backgroundColor: const Color(0XFFE6871A),
          shape: const CircleBorder(),
          child: const Icon(
            PhosphorIconsRegular.plus,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
