// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde!';

  @override
  String get welcome_to_the_app => 'Bienvenue dans l\'application';

  @override
  String get change_theme => 'Changer de thème';

  @override
  String get change_language => 'Changer de langue';

  @override
  String get quote1 =>
      'La seule façon de faire du bon travail est d’aimer ce que vous faites.';

  @override
  String get quote2 =>
      'La meilleure façon de prédire l’avenir est de le créer.';

  @override
  String get quote3 =>
      'Le succès n’est pas final, l’échec n’est pas fatal : c’est le courage de continuer qui compte.';

  @override
  String get quote4 => 'Croyez que vous pouvez et vous êtes à mi-chemin.';

  @override
  String get quote5 => 'La seule chose qui est constante est le changement.';

  @override
  String get new_quote => 'Nouvelle citation';
}
