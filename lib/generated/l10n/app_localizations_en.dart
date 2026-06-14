// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get welcome_to_the_app => 'Welcome to the app';

  @override
  String get change_theme => 'Change Theme';

  @override
  String get change_language => 'Change Language';

  @override
  String get quote1 => 'The only way to do great work is to love what you do.';

  @override
  String get quote2 => 'The best way to predict the future is to create it.';

  @override
  String get quote3 =>
      'Success is not final, failure is not fatal: it is the courage to continue that counts.';

  @override
  String get quote4 => 'Believe you can and you\'re halfway there.';

  @override
  String get quote5 => 'The only thing that is constant is change.';

  @override
  String get new_quote => 'New Quote';
}
