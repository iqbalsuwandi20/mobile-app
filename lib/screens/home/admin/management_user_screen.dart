import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../widgets/custom_filter_bar_widget.dart';
import 'pages/admin_add_user_page.dart';

class ManagementUserScreen extends StatelessWidget {
  const ManagementUserScreen({super.key});

  static const String routeName = '/management-user';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> users = [
      {
        'name': 'Black, Marvin',
        'phone': '+61488827086',
        'email': 'johndoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
      {
        'name': 'Jane Doe',
        'phone': '+628123456789',
        'email': 'janedoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': false,
      },
      {
        'name': 'John Smith',
        'phone': '+628987654321',
        'email': 'johnsmith@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
      {
        'name': 'Black, Marvin',
        'phone': '+61488827086',
        'email': 'johndoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
      {
        'name': 'Jane Doe',
        'phone': '+628123456789',
        'email': 'janedoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': false,
      },
      {
        'name': 'John Smith',
        'phone': '+628987654321',
        'email': 'johnsmith@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
      {
        'name': 'Black, Marvin',
        'phone': '+61488827086',
        'email': 'johndoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
      {
        'name': 'Jane Doe',
        'phone': '+628123456789',
        'email': 'janedoe@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': false,
      },
      {
        'name': 'John Smith',
        'phone': '+628987654321',
        'email': 'johnsmith@gmail.com',
        'image': 'assets/images/profile.png',
        'isVerified': true,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0XFFE6E9F0),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
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
                        'Pengelolaan Pengguna',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF050506),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          // TODO: Implement search functionality
                        },
                        icon: const Icon(
                          PhosphorIconsRegular.magnifyingGlass,
                          size: 24,
                          color: Color(0xFF050506),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox.square(dimension: 12),
                  CustomFilterBarWidget(
                    filterLabel: 'Status',
                    sortLabel: 'Asc',
                    onFilterTap: () {
                      // TODO: Implement Status filter functionality
                    },
                    onSortTap: () {
                      // TODO: Implement Asc sort functionality
                    },
                  ),
                  const SizedBox.square(dimension: 12),
                ],
              ),
            ),
            const SizedBox.square(dimension: 5),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                itemCount: users.length,
                separatorBuilder: (_, __) => const SizedBox(height: 2),
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            user['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFE6E9F0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  PhosphorIconsRegular.user,
                                  color: Color(0XFF5B5C63),
                                  size: 24,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user['name'],
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF050506),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (user['isVerified']) ...[
                                    const SizedBox(width: 4),
                                    const Icon(
                                      PhosphorIconsRegular.checkCircle,
                                      size: 16,
                                      color: Color(0XFF26A326),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    user['phone'],
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF5B5C63),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const ShapeDecoration(
                                      color: Color(0xFFD9D9D9),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    user['email'],
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF5B5C63),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            PhosphorIconsRegular.dotsThree,
                            size: 20,
                            color: const Color(0xFF050506),
                          ),
                        ),
                      ],
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
          onPressed: () {
            context.push(AdminAddUserPage.routeName);
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
