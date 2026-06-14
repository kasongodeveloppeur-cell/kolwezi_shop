import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:myapp/features/auth/presentation/providers/auth_provider.dart';
import 'package:myapp/core/theme/theme_provider.dart';
import 'package:myapp/core/localization/locale_provider.dart';
import 'package:myapp/generated/l10n/app_localizations.dart';
import 'package:myapp/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _motivationalQuote;

  @override
  void initState() {
    super.initState();
    _motivationalQuote = _getMotivationalQuote(context);
  }

  String _getMotivationalQuote(BuildContext context) {
    final quotes = [
      AppLocalizations.of(context)!.quote1,
      AppLocalizations.of(context)!.quote2,
      AppLocalizations.of(context)!.quote3,
      AppLocalizations.of(context)!.quote4,
      AppLocalizations.of(context)!.quote5,
    ];
    return quotes[Random().nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/app_logo.png', height: 32),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.welcome_to_the_app,
              style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            tooltip: 'Profile',
          ),
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: AppLocalizations.of(context)!.change_theme,
          ),
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              Provider.of<LocaleProvider>(context, listen: false).setLocale(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem<Locale>(
                value: Locale('en'),
                child: Text('English'),
              ),
              const PopupMenuItem<Locale>(
                value: Locale('fr'),
                child: Text('Français'),
              ),
            ],
            tooltip: AppLocalizations.of(context)!.change_language,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logOut();
            },
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surface.withAlpha(200),
            ],
          ),
        ),
        child: Center(
          child: user == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 8,
                          shadowColor: Colors.black.withAlpha(77), // 30% opacity
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  theme.colorScheme.primaryContainer,
                                  theme.colorScheme.secondaryContainer,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: theme.colorScheme.primary,
                                    child: Text(
                                      user.displayName?.isNotEmpty == true
                                          ? user.displayName![0].toUpperCase()
                                          : user.email![0].toUpperCase(),
                                      style: GoogleFonts.oswald(fontSize: 40, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${AppLocalizations.of(context)!.helloWorld}, ${user.displayName?.isNotEmpty == true ? user.displayName : user.email}!',
                                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                             padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest.withAlpha(128), // 50% opacity
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.primary.withAlpha(77), // 30% opacity
                            )),
                            child: Text(
                              '"$_motivationalQuote"',
                              style: theme.textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _motivationalQuote = _getMotivationalQuote(context);
          });
        },
        tooltip: AppLocalizations.of(context)!.new_quote,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
