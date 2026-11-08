# AGENTS.md - Developer & AI Agent Guide for macos-sonoma-launcher-android 🤖

## 🎯 Repository Overview
**macos-sonoma-launcher-android**: A pure Flutter 3.x desktop simulation environment that transforms your Android phone, tablet, foldable, or browser into an authentic macOS Sonoma workstation. Built adhering to the Impeccable design system with frosted glassmorphism, dynamic blur filters, fluid physics-based micro-interactions, and tactile haptic feedback. Experience the launcher directly in your web browser:

---

## 🏗️ Repository Architecture
Key directories and entrypoints: `.github/, LICENSE, README.md, analysis_options.yaml, android/, assets/, docs/, ios/, lib/, linux/, macos/, macos_sonoma_launcher.iml`.

### Tech Stack & Runtime
- **Framework:** Flutter / Dart (Cross-Platform Android, iOS, Web & Desktop)
- **Configuration:** `pubspec.yaml`, `analysis_options.yaml`

## ⚙️ Executable Verification Commands

### 1. Static Analysis & Linting
```bash
flutter analyze || dart analyze
```

### 2. Unit & Widget Tests
```bash
flutter test
```

### 3. Build Verification
```bash
flutter build apk --debug --no-pub
```

---

## 🛡️ Coding & Safety Guidelines for Autonomous Agents

1. **Documentation Integrity:** Preserve all existing docstrings, header comments, and licensing banners. Never delete context unless specifically instructed.
2. **Zero Hardcoded Secrets:** Never embed API keys, OAuth tokens, personal access tokens, or sensitive credentials in committed files. Read credentials exclusively from environment variables or secure credential paths.
3. **Git Hygiene:**
   - Do not force-push (`git push --force`) or execute destructive resets.
   - Never modify root git configurations or harness infrastructure outside task scope.
   - Keep git diffs atomic, focused, and verified before committing.
4. **Agent Workflow Protocol:**
   - **Plan:** Inspect codebase architecture and dependencies before editing.
   - **Act:** Make minimal, clean, high-precision changes.
   - **Verify:** Run the appropriate verification commands listed above.
   - **Reflect:** Confirm zero regressions and review `git diff`.

---
*Maintained by Ayyappa Pravin • Built for Antigravity, Claude, Cursor & Autonomous AI Agents.*
