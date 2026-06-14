# Blueprint: Mon Application Flutter

## Aperçu

Cette application Flutter est une application moderne, esthétique et fonctionnelle conçue pour offrir une expérience utilisateur exceptionnelle. Elle est entièrement internationalisée pour supporter le français et l'anglais, et intègre une authentification Firebase complète avec une base de données Firestore.

## Style et Design

L'application adoptera les principes de Material Design 3 pour une interface utilisateur cohérente et intuitive.

*   **Palette de couleurs :** Un schéma de couleurs harmonieux est généré à partir d'une couleur de base, avec des variantes pour les modes clair et sombre.
*   **Typographie :** Des polices lisibles et élégantes sont utilisées pour la hiérarchie visuelle du texte, grâce au package `google_fonts`.
*   **Composants :** Les composants standards de Material (boutons, cartes, barres de navigation) sont stylisés pour une apparence unique et soignée.
*   **Écran de connexion :** Un design engageant avec un fond en dégradé, une carte "liftée" pour les champs de saisie et des icôones pour une meilleure UX.
*   **Écran d'accueil :** Une présentation soignée avec une carte de bienvenue, un avatar pour l'utilisateur et un espace pour du contenu dynamique comme des citations.
*   **Logo :** Utilisation d'un logo personnalisé (`assets/images/app_logo.png`) dans l'en-tête de l'application et comme icône de l'application.

## Fonctionnalités

*   **Authentification Firebase :**
    *   Inscription et connexion par email et mot de passe.
    *   Gestion de l'état de l'utilisateur (connecté/déconnecté).
    *   Gestionnaire d'état (`AuthProvider`) avec indicateurs de chargement et gestion des erreurs.
*   **Base de Données Firestore :**
    *   Création d'un document utilisateur dans la collection `users` lors de l'inscription, contenant l'email et la date de création.
*   **Thème personnalisable :** Mise en place d'un système de thème complet avec un sélecteur de mode (clair/sombre/système).
*   **Internationalisation (i18n) :** Support complet pour l'anglais et le français, avec possibilité de changer de langue dynamiquement.
*   **Architecture robuste :** Utilisation du package `provider` pour la gestion de l'état (thème, langue, authentification), en séparant la logique métier de l'interface utilisateur.
*    **Suppression de la bannière de débogage:** La bannière de débogage de Flutter a été supprimée.

## Plan Actuel

1.  **Analyser le projet et corriger les problèmes.**
2.  **Intégrer Cloud Firestore.**
3.  **Créer un service utilisateur pour gérer les opérations Firestore.**
4.  **Mettre à jour le `AuthProvider` pour créer un document utilisateur lors de l'inscription.**
5.  **Mettre à jour le `main.dart` pour fournir le `UserService`.**
6.  **Mettre à jour le fichier `blueprint.md`** pour documenter ces changements.
