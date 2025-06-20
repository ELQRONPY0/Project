import 'package:ai_tumor_detect/core/constant/string.dart';
import 'package:ai_tumor_detect/core/routing/router.dart';
import 'package:ai_tumor_detect/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ai_tumor_detect/features/auth/domain/repositories/auth_repository.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_tumor_detect/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1. Create a single instance of the repository.
  final AuthRepository authRepository = AuthRepositoryImpl();

  // 2. Create UserProvider and pass the repository to it.
  final userProvider = UserProvider(authRepository);
  await userProvider.init(); // Initialize the user state from storage.

  runApp(
    MultiProvider(
      providers: [
        // 3. Provide both the repository and the user provider to the entire app.
        Provider<AuthRepository>.value(value: authRepository),
        ChangeNotifierProvider.value(value: userProvider),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (BuildContext context) => MyApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AI Tumor Detect',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF32cccc)),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          themeMode: ThemeMode.system,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: Routes.splash,
          builder: DevicePreview.appBuilder,
        ),
      ),
    );
  }
}
