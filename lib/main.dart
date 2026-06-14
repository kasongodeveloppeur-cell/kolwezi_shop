import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:myapp/core/theme/theme.dart';
import 'package:myapp/core/theme/theme_provider.dart';
import 'package:myapp/core/localization/locale_provider.dart';
import 'package:myapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:myapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:myapp/features/auth/domain/usecases/create_user_with_email_and_password.dart';
import 'package:myapp/features/auth/domain/usecases/get_auth_state_changes.dart';
import 'package:myapp/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:myapp/features/auth/domain/usecases/sign_out.dart';
import 'package:myapp/features/auth/domain/usecases/update_display_name.dart';
import 'package:myapp/features/auth/presentation/providers/auth_provider.dart' as my_app_auth_provider;
import 'package:myapp/features/auth/presentation/screens/login_screen.dart';
import 'package:myapp/features/home/presentation/screens/home_screen.dart';
import 'package:myapp/features/user/data/services/user_service.dart';
import 'package:myapp/generated/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(FirebaseAuth.instance),
        ),
        Provider<UserService>(
          create: (_) => UserService(FirebaseFirestore.instance),
        ),
        ProxyProvider<AuthRepository, GetAuthStateChanges>(
          update: (_, authRepository, __) => GetAuthStateChanges(authRepository),
        ),
        ProxyProvider<AuthRepository, CreateUserWithEmailAndPassword>(
          update: (_, authRepository, __) =>
              CreateUserWithEmailAndPassword(authRepository),
        ),
        ProxyProvider<AuthRepository, SignInWithEmailAndPassword>(
          update: (_, authRepository, __) =>
              SignInWithEmailAndPassword(authRepository),
        ),
        ProxyProvider<AuthRepository, SignOut>(
          update: (_, authRepository, __) => SignOut(authRepository),
        ),
        ProxyProvider<AuthRepository, UpdateDisplayName>(
          update: (_, authRepository, __) => UpdateDisplayName(authRepository),
        ),
        ChangeNotifierProxyProvider<GetAuthStateChanges, my_app_auth_provider.AuthProvider>(
          create: (context) {
            final getAuthStateChanges =
                Provider.of<GetAuthStateChanges>(context, listen: false);
            final signIn =
                Provider.of<SignInWithEmailAndPassword>(context, listen: false);
            final signUp = Provider.of<CreateUserWithEmailAndPassword>(
                context,
                listen: false);
            final signOut = Provider.of<SignOut>(context, listen: false);
            final updateDisplayName = Provider.of<UpdateDisplayName>(context, listen: false);
            final userService = Provider.of<UserService>(context, listen: false);

            return my_app_auth_provider.AuthProvider(
              getAuthStateChanges: getAuthStateChanges,
              signInWithEmailAndPassword: signIn,
              createUserWithEmailAndPassword: signUp,
              signOut: signOut,
              updateDisplayNameUseCase: updateDisplayName,
              userService: userService,
            );
          },
          update: (context, getAuthStateChanges, previous) {
            final signIn =
                Provider.of<SignInWithEmailAndPassword>(context, listen: false);
            final signUp = Provider.of<CreateUserWithEmailAndPassword>(
                context,
                listen: false);
            final signOut = Provider.of<SignOut>(context, listen: false);
            final updateDisplayName = Provider.of<UpdateDisplayName>(context, listen: false);
            final userService = Provider.of<UserService>(context, listen: false);

            return my_app_auth_provider.AuthProvider(
              getAuthStateChanges: getAuthStateChanges,
              signInWithEmailAndPassword: signIn,
              createUserWithEmailAndPassword: signUp,
              signOut: signOut,
              updateDisplayNameUseCase: updateDisplayName,
              userService: userService,
            );
          },
        ),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, child) {
          final authProvider = Provider.of<my_app_auth_provider.AuthProvider>(context);
          final goRouter = GoRouter(
            initialLocation: '/',
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                path: '/login',
                builder: (context, state) => const LoginScreen(),
              ),
            ],
            redirect: (context, state) {
              final isAuthenticated = authProvider.user != null;
              final isLoggingIn = state.matchedLocation == '/login';

              if (!isAuthenticated && !isLoggingIn) {
                return '/login';
              }
              if (isAuthenticated && isLoggingIn) {
                return '/';
              }
              return null;
            },
          );
          return MaterialApp.router(
            title: 'Congo Food Express',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: goRouter,
            debugShowCheckedModeBanner: false, // J'ai ajouté cette ligne
          );
        },
      ),
    );
  }
}
