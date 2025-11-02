import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart' as di;
import 'core/routes/route_generator.dart';
import 'viewmodels/login/login_view_model.dart';
import 'viewmodels/products/product_view_model.dart';

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => di.sl<LoginViewModel>(),
        ),
        ChangeNotifierProvider<ProductViewModel>(
          create: (_) => di.sl<ProductViewModel>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouteGenerator.router(initialRoute),
      ),
    );
  }
}
