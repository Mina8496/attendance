# Attendance App — Phase 1 Starter

Flutter starter structure for the Attendance Management System.

## Requirements
- Flutter SDK installed
- A new Firebase project dedicated to this application
- FlutterFire CLI

## Setup
1. Create a Flutter app:
   `flutter create attendance_app`
2. Copy the contents of this starter's `lib/` and `pubspec.yaml` into the new project.
3. From the project root run:
   `flutter pub get`
4. Configure Firebase (do not reuse another app's Firebase project):
   `dart pub global activate flutterfire_cli`
   `flutterfire configure`
5. Select the new Attendance Firebase project and Android/iOS platforms.
6. Enable Email/Password in Firebase Authentication.
7. Create the Cloud Firestore database.
8. Run:
   `flutter run`

`flutterfire configure` generates `lib/firebase_options.dart`. It is intentionally not included because it must contain configuration for your own Firebase project.

## Current scope
- Cubit state management with flutter_bloc
- Firebase initialization
- Email/password registration, login and logout
- Authentication state routing
- Basic theme and reusable loading/error UI

Organization approval, tenant isolation and attendance features are intentionally reserved for later phases.
