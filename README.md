# Root Randomizer

A Flutter app for randomizing factions in the Root board game.

## Building a Release

### Prerequisites

The Android release build is signed with an upload keystore located at:

The signing configuration is stored in `android/key.properties`.
Properties:
- storeFile
- keyAlias
- storePassword
- keyPassword

### Build a Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Build a Release App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`
