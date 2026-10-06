# 📱 Omarchy Launcher for Android (`omarchy-launcher-android`)

> **Minimalist, Glassmorphic Tiling Home Screen Launcher & AI Assistant Suite for Android**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Android](https://img.shields.io/badge/platform-Android%208.0%2B-green.svg)]()
[![Theme](https://img.shields.io/badge/themes-Omarchy%2022-purple.svg)]()

`omarchy-launcher-android` is an open-source Android Home Screen launcher inspired by **Omarchy Linux**, Nothing OS, and Niagara Launcher — featuring glassmorphic app cards, quick AI command prompt integration, fast Termux launching, and live theme switching.

<p align="center">
  <img src="assets/preview.jpg" alt="Omarchy Launcher Android Preview" width="380" />
</p>

---

## ✨ Features

- ⚡ **Built-in AI Assistant Bar**: Enter quick prompts directly on your Android home screen to execute queries via local AI or Termux daemons.
- 🔮 **Glassmorphic App Cards & Tiling Grid**: Categorized app launcher (Dev & AI, System, Media) with fast fuzzy search.
- 🎨 **Omarchy 22 Theme Palette System**: Switch live between Tokyo Night, Catppuccin Mocha, Nord, Cyberpunk, and Gruvbox.
- 📱 **Native System Home Launcher Intent**: Sets as default Android system launcher (`CATEGORY_HOME`).

---

## 🚀 Building & Testing

### 1. Web / Browser Test
Open `web/index.html` in any browser to test the interactive launcher interface.

### 2. Automated GitHub Actions APK Build
This repository includes a pre-configured GitHub Actions CI/CD workflow (`.github/workflows/build-apk.yml`).

- **Automatic Build & Release**: Push a version tag (e.g. `git tag v1.0.0 && git push origin v1.0.0`) to automatically trigger APK compilation and publish a GitHub Release with the downloadable `.apk` file attached.
- **Manual Trigger**: Go to the **Actions** tab on GitHub -> Select **Build & Release Omarchy Android Launcher APK** -> Click **Run workflow**.

### 3. Local Android APK Build
Build using Gradle wrapper or Android Studio:

```bash
cd android
./gradlew assembleRelease
```
The compiled APK will be located at `android/app/build/outputs/apk/release/app-release.apk`.

---

## 🌲 Repository Structure

```text
omarchy-launcher-android/
├── android/
│   └── app/src/main/
│       ├── AndroidManifest.xml   # System HOME launcher intent
│       └── java/.../MainActivity.kt
├── web/
│   ├── index.html                # Launcher Glassmorphic UI
│   ├── styles.css                # Mobile design system
│   └── app.js                    # App grid & AI prompt logic
├── assets/
│   └── preview.jpg
├── README.md
└── LICENSE
```

---

## 📄 License

Distributed under the MIT License. Built by **Pravin Tamilan ([@apravint](https://github.com/apravint))**.
