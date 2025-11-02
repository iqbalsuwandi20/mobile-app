import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../../../viewmodels/login/login_view_model.dart';
import '../../widgets/custom_text_form_field_widget.dart';
import '../home/admin/admin_product_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    final loginVM = context.watch<LoginViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.1),
              SvgPicture.string('''
              <svg width="138" height="32" viewBox="0 0 138 32" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd" clip-rule="evenodd" d="M12.017 22.4C10.9547 22.4 9.93581 21.9786 9.1846 21.2284C8.43339 20.4783 8.01136 19.4609 8.01136 18.4V0H0V18.4C0 25.0272 5.38043 30.4 12.017 30.4H20.8295V22.4H12.017ZM36.0511 8C35.1043 8 34.1667 8.18623 33.2919 8.54807C32.4171 8.9099 31.6223 9.44025 30.9527 10.1088C30.2832 10.7774 29.7521 11.5711 29.3898 12.4447C29.0274 13.3182 28.8409 14.2545 28.8409 15.2C28.8409 16.1455 29.0274 17.0818 29.3898 17.9553C29.7521 18.8289 30.2832 19.6226 30.9527 20.2912C31.6223 20.9598 32.4171 21.4901 33.2919 21.8519C34.1667 22.2138 35.1043 22.4 36.0511 22.4C37.9634 22.4 39.7974 21.6414 41.1495 20.2912C42.5017 18.9409 43.2614 17.1096 43.2614 15.2C43.2614 13.2904 42.5017 11.4591 41.1495 10.1088C39.7974 8.75857 37.9634 8 36.0511 8ZM20.8295 15.2C20.8295 6.8056 27.6448 0 36.0511 0C44.4575 0 51.2727 6.8056 51.2727 15.2C51.2727 23.5944 44.4575 30.4 36.0511 30.4C27.6448 30.4 20.8295 23.5944 20.8295 15.2ZM122.574 8C120.662 8 118.828 8.75857 117.475 10.1088C116.123 11.4591 115.364 13.2904 115.364 15.2C115.364 17.1096 116.123 18.9409 117.475 20.2912C118.828 21.6414 120.662 22.4 122.574 22.4C124.486 22.4 126.32 21.6414 127.672 20.2912C129.024 18.9409 129.784 17.1096 129.784 15.2C129.784 13.2904 129.024 11.4591 127.672 10.1088C126.32 8.75857 124.486 8 122.574 8ZM107.352 15.2C107.352 6.8056 114.168 0 122.574 0C130.98 0 137.795 6.8056 137.795 15.2C137.795 23.5944 130.98 30.4 122.574 30.4C114.168 30.4 107.352 23.5944 107.352 15.2ZM68.0966 0C59.6903 0 52.875 6.8056 52.875 15.2C52.875 23.5944 59.6903 30.4 68.0966 30.4H90.5284C92.1059 30.4 93.6272 30.16 95.058 29.7152L99.3409 32L103.962 23.3568C105.136 21.1565 105.75 18.7018 105.75 16.2088V15.2C105.75 6.8056 98.9347 0 90.5284 0H68.0966ZM97.7386 15.2C97.7386 13.2904 96.979 11.4591 95.6268 10.1088C94.2746 8.75857 92.4407 8 90.5284 8H68.0966C67.1497 8 66.2121 8.18623 65.3374 8.54807C64.4626 8.9099 63.6677 9.44025 62.9982 10.1088C62.3287 10.7774 61.7976 11.5711 61.4352 12.4447C61.0729 13.3182 60.8864 14.2545 60.8864 15.2C60.8864 16.1455 61.0729 17.0818 61.4352 17.9553C61.7976 18.8289 62.3287 19.6226 62.9982 20.2912C63.6677 20.9598 64.4626 21.4901 65.3374 21.8519C66.2121 22.2138 67.1497 22.4 68.0966 22.4H90.5284C92.431 22.4001 94.2565 21.6492 95.6071 20.311C96.9577 18.9728 97.7238 17.1558 97.7386 15.256V15.2Z" fill="#101014"/>
              </svg>
              ''', width: screenWidth * 0.35),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Masukkan email dan kata sandi Anda dengan benar',
                style: GoogleFonts.inter(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w400,
                  color: const Color(0XFF5B5D63),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              CustomTextFormFieldWidget(
                label: 'Email',
                hintText: 'Masukkan email',
                controller: _usernameController,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: screenHeight * 0.025),
              CustomTextFormFieldWidget(
                label: 'Kata Sandi',
                hintText: 'Masukkan kata sandi',
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? PhosphorIconsRegular.eye
                        : PhosphorIconsRegular.eyeSlash,
                    color: const Color(0XFF050506),
                    size: screenWidth * 0.05,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    backgroundColor: const Color(0XFFFF7900),
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: loginVM.isLoading
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();

                          final email = _usernameController.text.trim();
                          final password = _passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Isi semua kolom terlebih dahulu',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          await loginVM.login(
                            email: email,
                            password: password,
                            onSuccess: (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Login berhasil!'),
                                  backgroundColor: Color(0xFF4CAF50),
                                ),
                              );
                              context.go(AdminProductListScreen.routeName);
                            },
                            onError: (error) {
                              String errorMessage =
                                  'Login gagal: Cek email dan kata sandi Anda';

                              if (error.toString().contains('401') ||
                                  error.toString().contains(
                                    'tidak terdaftar',
                                  ) ||
                                  error.toString().contains('invalid')) {
                                errorMessage =
                                    'Login gagal: Cek email dan kata sandi Anda';
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                  backgroundColor: Color(0XFFEB2F2F),
                                ),
                              );
                            },
                          );
                        },
                  child: loginVM.isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Masuk',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.035,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
