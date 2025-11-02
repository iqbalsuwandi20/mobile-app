import 'package:flutter/material.dart';

import 'core/di/injection.dart' as di;
import 'core/local/shared_pref_helper.dart';
import 'my_app.dart';
import 'screens/home/admin/admin_product_list_screen.dart';
import 'screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final token = await SharedPrefHelper.getToken();

  final initialRoute = (token != null && token.isNotEmpty)
      ? AdminProductListScreen.routeName
      : LoginScreen.routeName;

  runApp(MyApp(initialRoute: initialRoute));
}
