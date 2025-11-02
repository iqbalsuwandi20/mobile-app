import 'package:go_router/go_router.dart';

import '../../models/products/get_all_product_model.dart';
import '../../screens/home/admin/admin_product_list_screen.dart';
import '../../screens/home/admin/management_user_screen.dart';
import '../../screens/home/admin/pages/admin_add_product_page.dart';
import '../../screens/home/admin/pages/admin_add_user_page.dart';
import '../../screens/home/users/home_screen.dart';
import '../../screens/login/login_screen.dart';

class RouteGenerator {
  static GoRouter router(String initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: LoginScreen.routeName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AdminProductListScreen.routeName,
          builder: (context, state) => const AdminProductListScreen(),
        ),
        GoRoute(
          path: AdminAddProductPage.routeName,
          builder: (context, state) {
            final product = state.extra as GetAllProductModel?;
            return AdminAddProductPage(product: product);
          },
        ),

        GoRoute(
          path: ManagementUserScreen.routeName,
          builder: (context, state) => const ManagementUserScreen(),
        ),
        GoRoute(
          path: AdminAddUserPage.routeName,
          builder: (context, state) => const AdminAddUserPage(),
        ),
        GoRoute(
          path: HomeScreen.routeName,
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    );
  }
}
