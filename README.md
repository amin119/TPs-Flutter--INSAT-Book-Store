
# TPs-Flutter — INSAT Book Store

A simple Flutter-based Book Store app created as a TP (practical work) for
INSAT. The app demonstrates core Flutter concepts: navigation, state
management, lists/grids, a persistent basket/cart, basic UI components, and
responsive layouts.

## Features

- Browse a library of books with thumbnails, titles and short descriptions
- View book details with author, price and full description
- Add and remove books from a basket (shopping cart)
- Simple persistent state for the basket
- Responsive layout for mobile, web and desktop
- Clean, modular code structure suitable for learning and extension

## Repository layout

- `lib/` — main Dart source files (screens, models, widgets)
- `assets/` — images, fonts and other static assets
- `android/`, `ios/`, `windows/`, `linux/`, `macos/`, `web/` — platform-specific
	project files
- `test/` — widget/unit tests
- `pubspec.yaml` — project dependencies and asset declarations

## Prerequisites

- Flutter SDK (stable channel). Verify with:
```powershell
flutter --version
```
- Android SDK / Xcode (if building for mobile), or desktop toolchain for
	Windows/macOS/Linux, or Chrome for web.

## Quick start (clone, install, run)

1. Clone the repository:
```powershell
git clone https://github.com/amin119/TPs-Flutter--INSAT-Book-Store.git
cd TPs-Flutter--INSAT-Book-Store
```

2. Get dependencies:
```powershell
flutter pub get
```

3. Run on an available device (PowerShell examples):

- Run on the connected Android device or emulator:
```powershell
flutter run -d android
```
- Run on Windows (desktop):
```powershell
flutter run -d windows
```
- Run on web (Chrome):
```powershell
flutter run -d chrome
```

4. Build release artifacts:
- Android APK:
```powershell
flutter build apk --release
```
- Web:
```powershell
flutter build web --release
```

## Configuration & assets

- Assets and fonts are declared in `pubspec.yaml`. If you add images, update
	`pubspec.yaml` and re-run `flutter pub get`.
- To change app metadata (display name, icons), modify the platform folders
	under `android/` and `ios/`.

## Tests

Run the test suite with:
```powershell
flutter test
```

