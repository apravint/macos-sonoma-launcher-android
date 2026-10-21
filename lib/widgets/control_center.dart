import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/mac_system.dart';

class MacControlCenter extends StatelessWidget {
  const MacControlCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MacSystemState();

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        if (!state.isControlCenterOpen) return const SizedBox.shrink();

        return Positioned(
          top: 38,
          right: 14,
          child: Container(
            width: 310,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xE61E1E22),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Network Controls Block
                Row(
                  children: [
                    Expanded(
                      child: _networkTile(
                        icon: Icons.wifi_rounded,
                        title: 'Wi-Fi',
                        subtitle: state.wifiEnabled ? 'Connected' : 'Off',
                        active: state.wifiEnabled,
                        onTap: state.toggleWifi,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _networkTile(
                        icon: Icons.bluetooth_rounded,
                        title: 'Bluetooth',
                        subtitle: state.bluetoothEnabled ? 'On' : 'Off',
                        active: state.bluetoothEnabled,
                        onTap: state.toggleBluetooth,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _networkTile(
                        icon: Icons.all_out_rounded,
                        title: 'AirDrop',
                        subtitle: state.airDropEnabled ? 'Contacts Only' : 'Off',
                        active: state.airDropEnabled,
                        onTap: state.toggleAirDrop,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _networkTile(
                        icon: state.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        title: 'Dark Mode',
                        subtitle: state.isDarkMode ? 'Dark' : 'Light',
                        active: state.isDarkMode,
                        onTap: state.toggleDarkMode,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Display Slider
                _sliderTile(
                  icon: Icons.brightness_6_rounded,
                  label: 'Display',
                  value: state.brightness,
                  onChanged: state.setBrightness,
                ),
                const SizedBox(height: 8),

                // Sound Slider
                _sliderTile(
                  icon: Icons.volume_up_rounded,
                  label: 'Sound',
                  value: state.volume,
                  onChanged: state.setVolume,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _networkTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? const Color(0xFF007AFF) : Colors.white.withValues(alpha: 0.15),
              ),
              child: Icon(icon, size: 14, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(fontSize: 10, color: Colors.white.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sliderTile({
    required IconData icon,
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.white.withValues(alpha: 0.7)),
              const SizedBox(width: 6),
              Text(label, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 18,
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
              activeTrackColor: Colors.white,
              inactiveTrackColor: Colors.white.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
