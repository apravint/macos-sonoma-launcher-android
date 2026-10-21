#  macOS Sonoma Launcher for Android

[![Flutter CI/CD](https://github.com/apravint/macos-sonoma-launcher-android/actions/workflows/build-and-release.yml/badge.svg)](https://github.com/apravint/macos-sonoma-launcher-android/actions/workflows/build-and-release.yml)
[![Flutter](https://img.shields.io/badge/Flutter-3.47%20%7C%20Dart%203.13-02569B?logo=flutter)](https://flutter.dev)
[![Live Web Demo](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-brightgreen?logo=googlechrome)](https://apravint.github.io/macos-sonoma-launcher-android/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Android Min SDK](https://img.shields.io/badge/Android-7.0%2B%20(API%2024)-3DDC84?logo=android)](https://developer.android.com)

A **pure Flutter 3.x** desktop simulation environment that transforms your Android phone, tablet, foldable, or browser into an authentic **macOS Sonoma** workstation. Built adhering to the **Impeccable** design system with frosted glassmorphism, dynamic blur filters, fluid physics-based micro-interactions, and tactile haptic feedback.

---

## 🌐 Live Interactive Web Demo

Experience the launcher directly in your web browser:
👉 **[Launch macOS Sonoma Web Preview](https://apravint.github.io/macos-sonoma-launcher-android/)**

---

## ✨ Features & Architecture

### 1.  Top Menu Bar
- **Apple Menu (``)**: Dropdown menu featuring *About This Mac*, *System Settings*, *App Store*, *Launchpad*, *Restart*, and *Shut Down*.
- **Active Application Title**: Displays the currently active foreground application with bold SF Pro/Outfit typography.
- **Desktop Menus**: *File*, *Edit*, *View*, *Go*, *Window*, and *Help* accessible in widescreen and desktop viewports.
- **Dynamic Status Tray**: Live digital clock with date format, Wi-Fi status, battery gauge, and Control Center quick toggle.

### 2. 🌊 Floating Glassmorphic Dock
- **Adaptive Dock**: Houses system and user apps (Finder, Launchpad, Safari, Messages, Mail, Maps, Photos, FaceTime, Calendar, Terminal, Music, Notes, App Store, Settings, Calculator, Trash).
- **Interactive Hover & Bounce**: Scale and lift animations on pointer hover and tap.
- **Running Indicators**: Dot indicators below active processes with real-time app switching.

### 3. 🎛️ Control Center Flyout
- **Quick Toggles**: Wi-Fi, Bluetooth, AirDrop, and Dark/Light Mode switches.
- **Interactive Sliders**: Smooth Display Brightness and System Volume audio sliders.
- **Now Playing Card**: Sonoma-style media player with playback controls.

### 4. 🚀 Fullscreen Launchpad
- **Fast Fuzzy Search**: Instant real-time filtering across all installed apps and categories.
- **Grid Layout**: Categorized application tiles with frosted glass backdrop and escape-to-close gestures.

### 5. 💻 Finder & Desktop Canvas
- **Finder Window**: Multi-tab sidebar (Recents, Applications, Documents, Downloads, iCloud Drive) with interactive file grid.
- **Sonoma Desktop Widgets**: Real-time Weather widget with temperature, conditions, and high/low stats; system resource monitor tracking M3 Max CPU, unified RAM, and SSD storage.
- **Desktop Storage Icons**: Quick shortcuts to Macintosh HD, Projects, and portfolio files.

### 6. ℹ️ "About This Mac" Dialog
- Authentic Sonoma graphic emblem, macOS version strings, Apple M3 Max hardware profile, unified memory diagnostics, and System Report trigger.

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: Flutter 3.47.7 (Dart 3.13.5)
- **Design System**: Impeccable Design System with frosted glass aesthetics, high contrast, and tactile feedback
- **Typography**: Google Fonts (`Outfit`)
- **Formatting**: `intl: ^0.20.0`
- **Testing**: 100% pass rate on widget smoke test suite

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.27+
- Android Studio / Android SDK 34+

### Clone & Run
```bash
git clone https://github.com/apravint/macos-sonoma-launcher-android.git
cd macos-sonoma-launcher-android

# Fetch dependencies
flutter pub get

# Run tests
flutter test

# Run on connected Android device or desktop
flutter run

# Build release APK
flutter build apk --release

# Build for Web
flutter build web --release --base-href "/macos-sonoma-launcher-android/"
```

---

## 📄 License

Licensed under the [MIT License](LICENSE).
Created with ❤️ by **Ayyappa Pravin** ([@apravint](https://github.com/apravint)).
