# 📱 Product Management System

Dokumentasi lengkap untuk project Flutter dengan arsitektur clean code yang terstruktur dan scalable.

## 📹 Demo Video

Lihat demo aplikasi di sini: [Screen Recording](https://drive.google.com/drive/folders/1I1KZyiMdEZq7xCQxxSKyuT0UqJZnsycw?usp=sharing)

---

## 📂 Struktur Folder

```
lib/
├── core/
│   ├── constant/
│   │   └── constant.dart          # Konstanta global (base URL, dll)
│   ├── di/
│   │   └── injection.dart         # Dependency Injection dengan GetIt
│   ├── local/
│   │   └── shared_pref_helper.dart # Helper untuk SharedPreferences
│   └── routes/
│       └── route_generator.dart   # Konfigurasi routing dengan GoRouter
├── models/
│   ├── login/
│   │   ├── login_request.dart
│   │   └── login_response.dart
│   └── products/
│       ├── get_all_product_model.dart
│       └── ...
├── repositories/
│   ├── login/
│   │   └── login_repository.dart
│   └── products/
│       └── product_repository.dart
├── screens/
│   ├── home/
│   │   ├── admin/
│   │   │   ├── admin_product_list_screen.dart
│   │   │   ├── management_user_screen.dart
│   │   │   └── pages/
│   │   │       ├── admin_add_product_page.dart
│   │   │       └── admin_add_user_page.dart
│   │   └── users/
│   │       └── home_screen.dart
│   └── login/
│       └── login_screen.dart
├── services/
│   ├── abstract/
│   │   ├── login/
│   │   │   └── login_service.dart
│   │   └── products/
│   │       └── product_service.dart
│   └── remote/
│       ├── login/
│       │   └── login_remote_service.dart
│       └── products/
│           └── product_remote_service.dart
├── viewmodels/
│   ├── login/
│   │   └── login_view_model.dart
│   └── products/
│       └── product_view_model.dart
├── widgets/
│   └── ...
├── main.dart                      # Entry point aplikasi
└── my_app.dart                    # Root widget dengan Provider setup
```

---

## 🏗️ Arsitektur Clean Code

Project ini menggunakan **Clean Architecture** dengan pemisahan layer yang jelas. Berikut alur data dan tanggung jawab masing-masing layer:

```
UI (Screen) 
    ↓ (user action)
ViewModel 
    ↓ (request data)
Repository 
    ↓ (koordinasi)
Remote Service 
    ↓ (HTTP request)
API Server
    ↓ (response)
Model 
    ↓ (parsed data)
ViewModel 
    ↓ (state update)
UI (rebuild)
```

### 🧩 1. Model
**Tujuan:** Merepresentasikan data dari/ke API dalam bentuk objek Dart yang kuat dan mudah digunakan.

**Tanggung Jawab:**
- Parsing JSON ke Dart object
- Serialisasi Dart object ke JSON
- Validasi data structure

**Contoh:**
```dart
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
```

---

### ⚙️ 2. Abstract Service
**Tujuan:** Mendefinisikan kontrak (interface) untuk cara berinteraksi dengan sumber data.

**Tanggung Jawab:**
- Membuat interface/contract untuk service
- Memungkinkan multiple implementation (Remote, Local, Mock)
- Dependency Inversion Principle

**Contoh:**
```dart
abstract class LoginService {
  Future<LoginResponse> login(LoginRequest request);
  Future<void> logout();
}
```

---

### 🌐 3. Remote Service
**Tujuan:** Menangani interaksi langsung dengan API (server) — di sinilah HTTP request dilakukan.

**Tanggung Jawab:**
- Melakukan HTTP request (GET, POST, PUT, DELETE)
- Handle response dan error dari server
- Parse response menjadi Model
- Menambahkan headers (authentication, content-type, dll)

**Contoh:**
```dart
class LoginRemoteService implements LoginService {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('${Constant.baseUrl}/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }
}
```

---

### 🏗️ 4. Repository
**Tujuan:** Sebagai lapisan perantara (bridge) antara ViewModel dan Remote Service.

**Tanggung Jawab:**
- Koordinasi antara berbagai sumber data (remote, local, cache)
- Business logic sederhana (caching strategy, data synchronization)
- Error handling dan transformasi data

**Contoh:**
```dart
class LoginRepository {
  final LoginService remoteLoginService;

  LoginRepository({required this.remoteLoginService});

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await remoteLoginService.login(request);
      // Bisa tambah logic: simpan token, log analytics, dll
      await SharedPrefHelper.saveToken(response.token);
      return response;
    } catch (e) {
      throw Exception('Repository: Login failed - $e');
    }
  }
}
```

---

### 🧠 5. ViewModel
**Tujuan:** Mengelola state (data, loading, error) dan business logic supaya UI tidak perlu memikirkan hal itu.

**Tanggung Jawab:**
- Manage UI state (loading, success, error)
- Business logic dan validasi
- Komunikasi dengan Repository
- Notify UI untuk rebuild (menggunakan ChangeNotifier)

**Contoh:**
```dart
class LoginViewModel extends ChangeNotifier {
  final LoginRepository loginRepository;
  
  bool _isLoading = false;
  String? _errorMessage;
  
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LoginViewModel({required this.loginRepository});

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);
      await loginRepository.login(request);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
```

---

### 🎨 6. UI (User Interface)
**Tujuan:** Menampilkan data dari ViewModel ke pengguna dan handle interaksi pengguna.

**Tanggung Jawab:**
- Render widgets berdasarkan state dari ViewModel
- Handle user interaction (tap, scroll, input)
- Navigation
- Hanya fokus pada tampilan, NO business logic

**Contoh:**
```dart
class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : LoginForm(
              onSubmit: (email, password) async {
                final success = await viewModel.login(email, password);
                if (success) {
                  context.go(AdminProductListScreen.routeName);
                }
              },
            ),
    );
  }
}
```

---

## 🚀 Getting Started

### Prerequisites

Pastikan sudah install:
- Flutter SDK (3.0.0 atau lebih baru)
- Dart SDK
- Android Studio / VS Code
- Emulator atau Physical Device

### Installation

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd <project-folder>
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Setup Base URL**
   
   Edit file `lib/core/constant/constant.dart`:
   ```dart
   class Constant {
     static const String baseUrl = "http://YOUR_IP:8000/api/v1";
   }
   ```

4. **Run aplikasi**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

Dependencies utama yang digunakan:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.0.0
  
  # Dependency Injection
  get_it: ^7.6.0
  
  # Navigation
  go_router: ^13.0.0
  
  # Local Storage
  shared_preferences: ^2.2.0
  
  # HTTP Client
  http: ^1.1.0
```

---

## 🔧 Konfigurasi

### Dependency Injection (GetIt)

File: `lib/core/di/injection.dart`

Semua dependencies di-register di sini untuk memudahkan pengelolaan dan testing.

```dart
Future<void> init() async {
  // Services
  sl.registerLazySingleton<LoginService>(() => LoginRemoteService());
  sl.registerLazySingleton<ProductService>(() => ProductRemoteService());

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepository(remoteLoginService: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(remoteProductService: sl()),
  );

  // ViewModels
  sl.registerFactory<LoginViewModel>(
    () => LoginViewModel(loginRepository: sl()),
  );
  sl.registerFactory<ProductViewModel>(
    () => ProductViewModel(productRepository: sl()),
  );
}
```

**Penjelasan:**
- `registerLazySingleton`: Instance dibuat saat pertama kali dibutuhkan dan di-reuse
- `registerFactory`: Instance baru dibuat setiap kali diminta

---

### State Management (Provider)

File: `lib/my_app.dart`

```dart
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
```

**Keuntungan Provider:**
- Reactive state management
- Automatic widget rebuild saat state berubah
- Memory efficient
- Easy testing

---

### Routing (GoRouter)

File: `lib/core/routes/route_generator.dart`

```dart
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
      // ... routes lainnya
    ],
  );
}
```

**Fitur GoRouter:**
- Deep linking support
- Named routes
- Passing parameters via `state.extra`
- Type-safe navigation

---

### Local Storage (SharedPreferences)

File: `lib/core/local/shared_pref_helper.dart`

Helper class untuk mengelola token authentication:

```dart
class SharedPrefHelper {
  static Future<void> saveToken(String token) async { ... }
  static Future<String?> getToken() async { ... }
  static Future<void> clearToken() async { ... }
  static Future<bool> hasToken() async { ... }
}
```

**Use Case:**
- Persistent login (token storage)
- User preferences
- Cache data

---

## 🔐 Authentication Flow

1. **Login**
   - User input email & password di `LoginScreen`
   - `LoginViewModel` validasi input
   - Call `LoginRepository.login()`
   - `LoginRepository` forward ke `LoginRemoteService`
   - Service hit API `/login`
   - Response di-parse jadi `LoginResponse` model
   - Token disimpan ke SharedPreferences
   - Navigate ke `AdminProductListScreen`

2. **Auto Login**
   - Saat app start, `main.dart` cek token di SharedPreferences
   - Jika ada token → navigate ke `AdminProductListScreen`
   - Jika tidak ada → navigate ke `LoginScreen`

3. **Logout**
   - Clear token dari SharedPreferences
   - Navigate ke `LoginScreen`

---

## 📝 Coding Conventions

### Naming Convention
- **Files**: `snake_case` (contoh: `login_view_model.dart`)
- **Classes**: `PascalCase` (contoh: `LoginViewModel`)
- **Variables & Functions**: `camelCase` (contoh: `getUserData()`)
- **Constants**: `camelCase` dengan prefix (contoh: `kPrimaryColor`)

### Folder Organization
- Setiap feature punya folder sendiri
- Pisahkan berdasarkan layer (models, services, repositories, dll)
- Widget reusable masuk folder `widgets/`

### Best Practices
- **Single Responsibility**: Satu class satu tanggung jawab
- **Dependency Injection**: Jangan hardcode dependencies
- **Error Handling**: Selalu handle error dengan try-catch
- **Logging**: Gunakan logging untuk debugging
- **Comments**: Tulis comment untuk logic yang kompleks

---

## 🧪 Testing

### Unit Testing
```dart
test('Login dengan credentials valid harus return token', () async {
  // Arrange
  final mockService = MockLoginService();
  final repository = LoginRepository(remoteLoginService: mockService);
  
  // Act
  final result = await repository.login(
    LoginRequest(email: 'test@test.com', password: '123456')
  );
  
  // Assert
  expect(result.token, isNotEmpty);
});
```

### Widget Testing
```dart
testWidgets('LoginScreen harus tampilkan loading saat login', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();
  
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

---

## 🐛 Troubleshooting

### Issue: Token tidak tersimpan
**Solusi:** 
- Pastikan `SharedPreferences` sudah di-init di `main()`
- Cek permission di `AndroidManifest.xml`

### Issue: Connection refused
**Solusi:**
- Pastikan base URL sudah benar
- Cek apakah backend server sudah running
- Untuk Android emulator, gunakan `10.0.2.2` bukan `localhost`

### Issue: State tidak update di UI
**Solusi:**
- Pastikan sudah call `notifyListeners()` di ViewModel
- Cek apakah widget sudah wrapped dengan `Consumer` atau `Provider.of<>`

---

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [GetIt Package](https://pub.dev/packages/get_it)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---
