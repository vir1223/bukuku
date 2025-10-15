# Bukuku App

## Setup Instructions

### Firebase Configuration

This app uses Firebase for backend services. To set up Firebase:

1. Create a Firebase project at https://console.firebase.google.com/
2. Enable the required services (e.g., Authentication, Firestore, Storage)
3. Generate API keys and configuration for each platform

#### Android Setup
- Download the `google-services.json` file from Firebase console
- Replace the placeholder values in `android/app/google-services.json` with your actual Firebase configuration

#### iOS Setup
- Download the `GoogleService-Info.plist` file from Firebase console
- Place it in the `ios/Runner/` directory

#### Web Setup
- The web configuration is handled in `lib/firebase_options.dart`

#### Firebase Options
- Update `lib/firebase_options.dart` with your actual Firebase API keys and configuration values
- Replace all `YOUR_*` placeholders with real values from your Firebase project

### Environment Variables
- For production, consider using environment variables or a secure configuration management system
- Never commit real API keys to version control

### Running the App
1. Ensure all Firebase configurations are set up correctly
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### Security Note
- The `.gitignore` file is configured to exclude sensitive Firebase configuration files
- Always keep API keys secure and never expose them in public repositories
