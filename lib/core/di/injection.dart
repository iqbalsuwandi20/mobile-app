import 'package:get_it/get_it.dart';

import '../../repositories/login/login_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../services/abstract/login/login_service.dart';
import '../../services/abstract/products/product_service.dart';
import '../../services/remote/login/login_remote_service.dart';
import '../../services/remote/products/product_remote_service.dart';
import '../../viewmodels/login/login_view_model.dart';
import '../../viewmodels/products/product_view_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<LoginService>(() => LoginRemoteService());

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepository(remoteLoginService: sl()),
  );

  sl.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginRepository: sl()),
  );

  sl.registerLazySingleton<ProductService>(() => ProductRemoteService());

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(remoteProductService: sl()),
  );

  sl.registerFactory<ProductViewModel>(
    () => ProductViewModel(productRepository: sl()),
  );
}
