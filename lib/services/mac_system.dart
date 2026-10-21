import 'package:flutter/material.dart';
import '../models/app_item.dart';

class MacSystemState extends ChangeNotifier {
  static final MacSystemState _instance = MacSystemState._internal();
  factory MacSystemState() => _instance;

  MacSystemState._internal();

  String _activeAppName = 'Finder';
  String get activeAppName => _activeAppName;

  bool _wifiEnabled = true;
  bool get wifiEnabled => _wifiEnabled;

  bool _bluetoothEnabled = true;
  bool get bluetoothEnabled => _bluetoothEnabled;

  bool _airDropEnabled = true;
  bool get airDropEnabled => _airDropEnabled;

  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  double _brightness = 0.85;
  double get brightness => _brightness;

  double _volume = 0.75;
  double get volume => _volume;

  bool _isLaunchpadOpen = false;
  bool get isLaunchpadOpen => _isLaunchpadOpen;

  bool _isControlCenterOpen = false;
  bool get isControlCenterOpen => _isControlCenterOpen;

  bool _isAboutMacOpen = false;
  bool get isAboutMacOpen => _isAboutMacOpen;

  final Set<String> _runningAppIds = {'finder', 'safari'};
  Set<String> get runningAppIds => Set.unmodifiable(_runningAppIds);

  static const List<MacAppItem> allApps = [
    MacAppItem(
      id: 'finder',
      name: 'Finder',
      category: 'System',
      iconData: Icons.folder_copy_rounded,
      iconColor: Color(0xFF007AFF),
      packageName: 'com.google.android.documentsui',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'launchpad',
      name: 'Launchpad',
      category: 'System',
      iconData: Icons.rocket_launch_rounded,
      iconColor: Color(0xFF5856D6),
      packageName: 'launcher',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'safari',
      name: 'Safari',
      category: 'Internet',
      iconData: Icons.explore_rounded,
      iconColor: Color(0xFF00C7FF),
      packageName: 'com.android.chrome',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'messages',
      name: 'Messages',
      category: 'Social',
      iconData: Icons.chat_bubble_rounded,
      iconColor: Color(0xFF34C759),
      packageName: 'com.whatsapp',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'mail',
      name: 'Mail',
      category: 'Productivity',
      iconData: Icons.mail_rounded,
      iconColor: Color(0xFF007AFF),
      packageName: 'com.google.android.gm',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'maps',
      name: 'Maps',
      category: 'Travel',
      iconData: Icons.map_rounded,
      iconColor: Color(0xFFFF9500),
      packageName: 'com.google.android.apps.maps',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'photos',
      name: 'Photos',
      category: 'Media',
      iconData: Icons.photo_library_rounded,
      iconColor: Color(0xFFFF2D55),
      packageName: 'com.google.android.apps.photos',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'facetime',
      name: 'FaceTime',
      category: 'Communication',
      iconData: Icons.videocam_rounded,
      iconColor: Color(0xFF34C759),
      packageName: 'com.google.android.apps.tachyon',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'calendar',
      name: 'Calendar',
      category: 'Productivity',
      iconData: Icons.calendar_today_rounded,
      iconColor: Color(0xFFFF3B30),
      packageName: 'com.google.android.calendar',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'terminal',
      name: 'Terminal',
      category: 'Developer',
      iconData: Icons.terminal_rounded,
      iconColor: Color(0xFF1C1C1E),
      packageName: 'com.termux',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'music',
      name: 'Music',
      category: 'Media',
      iconData: Icons.music_note_rounded,
      iconColor: Color(0xFFFA233B),
      packageName: 'com.spotify.music',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'notes',
      name: 'Notes',
      category: 'Productivity',
      iconData: Icons.note_alt_rounded,
      iconColor: Color(0xFFFFCC00),
      packageName: 'com.google.android.keep',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'appstore',
      name: 'App Store',
      category: 'System',
      iconData: Icons.storefront_rounded,
      iconColor: Color(0xFF007AFF),
      packageName: 'com.android.vending',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'settings',
      name: 'System Settings',
      category: 'System',
      iconData: Icons.settings_rounded,
      iconColor: Color(0xFF8E8E93),
      packageName: 'com.android.settings',
      isDockItem: true,
    ),
    MacAppItem(
      id: 'calculator',
      name: 'Calculator',
      category: 'Utilities',
      iconData: Icons.calculate_rounded,
      iconColor: Color(0xFFFF9500),
      packageName: 'com.google.android.calculator',
      isDockItem: false,
    ),
    MacAppItem(
      id: 'trash',
      name: 'Trash',
      category: 'System',
      iconData: Icons.delete_outline_rounded,
      iconColor: Color(0xFFA2A2A7),
      packageName: 'trash',
      isDockItem: true,
    ),
  ];

  void launchApp(MacAppItem app) {
    if (app.id == 'launchpad') {
      toggleLaunchpad();
      return;
    }
    _activeAppName = app.name;
    _runningAppIds.add(app.id);
    _isLaunchpadOpen = false;
    _isControlCenterOpen = false;
    _isAboutMacOpen = false;
    notifyListeners();
  }

  void toggleLaunchpad() {
    _isLaunchpadOpen = !_isLaunchpadOpen;
    _isControlCenterOpen = false;
    _isAboutMacOpen = false;
    notifyListeners();
  }

  void toggleControlCenter() {
    _isControlCenterOpen = !_isControlCenterOpen;
    _isAboutMacOpen = false;
    notifyListeners();
  }

  void toggleAboutMac() {
    _isAboutMacOpen = !_isAboutMacOpen;
    _isControlCenterOpen = false;
    notifyListeners();
  }

  void closeOverlays() {
    _isLaunchpadOpen = false;
    _isControlCenterOpen = false;
    _isAboutMacOpen = false;
    notifyListeners();
  }

  void toggleWifi() {
    _wifiEnabled = !_wifiEnabled;
    notifyListeners();
  }

  void toggleBluetooth() {
    _bluetoothEnabled = !_bluetoothEnabled;
    notifyListeners();
  }

  void toggleAirDrop() {
    _airDropEnabled = !_airDropEnabled;
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setBrightness(double v) {
    _brightness = v;
    notifyListeners();
  }

  void setVolume(double v) {
    _volume = v;
    notifyListeners();
  }
}
