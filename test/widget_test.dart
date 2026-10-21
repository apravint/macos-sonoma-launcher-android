import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macos_sonoma_launcher/main.dart';
import 'package:macos_sonoma_launcher/services/mac_system.dart';

void main() {
  testWidgets('macOS Sonoma Launcher smoke test', (WidgetTester tester) async {
    // Provide a desktop size viewport
    tester.view.physicalSize = const Size(1280, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const MacOsSonomaApp());
    await tester.pumpAndSettle();

    // Verify top menu bar Apple logo is present
    expect(find.text(''), findsOneWidget);

    // Verify Finder title in menu bar
    expect(find.text('Finder'), findsAtLeastNWidgets(1));

    // Verify Desktop icons
    expect(find.text('Macintosh HD'), findsAtLeastNWidgets(1));
    expect(find.text('Projects'), findsAtLeastNWidgets(1));

    // Verify Weather widget
    expect(find.text('Cupertino'), findsOneWidget);

    // Test Control Center toggle via MacSystemState
    final system = MacSystemState();
    system.toggleControlCenter();
    await tester.pumpAndSettle();
    expect(find.text('Wi-Fi'), findsOneWidget);
    expect(find.text('Bluetooth'), findsOneWidget);
    expect(find.text('AirDrop'), findsOneWidget);

    // Close overlays
    system.closeOverlays();
    await tester.pumpAndSettle();
    expect(find.text('AirDrop'), findsNothing);

    // Test About Mac Dialog
    system.toggleAboutMac();
    await tester.pumpAndSettle();
    expect(find.text('macOS Sonoma'), findsAtLeastNWidgets(1));
    expect(find.text('About This Mac'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);

    system.toggleAboutMac();
    await tester.pumpAndSettle();
    expect(find.text('About This Mac'), findsNothing);
  });
}
