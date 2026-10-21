import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/mac_system.dart';

class MacMenuBar extends StatefulWidget {
  const MacMenuBar({super.key});

  @override
  State<MacMenuBar> createState() => _MacMenuBarState();
}

class _MacMenuBarState extends State<MacMenuBar> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = MacSystemState();
    final timeFmt = DateFormat('EEE d MMM  hh:mm a');

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        return Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.15),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              // Apple Logo Button
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: const Text('', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                offset: const Offset(0, 30),
                color: const Color(0xE6252528),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
                ),
                onSelected: (val) {
                  HapticFeedback.lightImpact();
                  if (val == 'about') state.toggleAboutMac();
                  if (val == 'launchpad') state.toggleLaunchpad();
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'about', child: Text('About This Mac', style: TextStyle(fontSize: 13))),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'settings', child: Text('System Settings...', style: TextStyle(fontSize: 13))),
                  const PopupMenuItem(value: 'appstore', child: Text('App Store...', style: TextStyle(fontSize: 13))),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'launchpad', child: Text('Open Launchpad', style: TextStyle(fontSize: 13))),
                  const PopupMenuDivider(),
                  const PopupMenuItem(value: 'sleep', child: Text('Sleep', style: TextStyle(fontSize: 13))),
                  const PopupMenuItem(value: 'restart', child: Text('Restart...', style: TextStyle(fontSize: 13))),
                  const PopupMenuItem(value: 'shutdown', child: Text('Shut Down...', style: TextStyle(fontSize: 13))),
                ],
              ),
              const SizedBox(width: 8),

              // Active App Name
              Text(
                state.activeAppName,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),

              // Standard menus (desktop style)
              if (MediaQuery.of(context).size.width > 600) ...[
                _menuText('File'),
                _menuText('Edit'),
                _menuText('View'),
                _menuText('Window'),
                _menuText('Help'),
              ],

              const Spacer(),

              // Status Icons & Clock
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      state.wifiEnabled ? Icons.wifi_rounded : Icons.wifi_off_rounded,
                      size: 15,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: state.toggleWifi,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.battery_charging_full_rounded,
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: state.toggleControlCenter,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: state.isControlCenterOpen ? Colors.white.withValues(alpha: 0.25) : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.tune_rounded,
                        size: 14,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    timeFmt.format(_now),
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _menuText(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 12.5,
          fontWeight: FontWeight.w400,
          color: Colors.white.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
