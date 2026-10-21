import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../services/mac_system.dart';
import '../widgets/about_mac_dialog.dart';
import '../widgets/control_center.dart';
import '../widgets/dock.dart';
import '../widgets/launchpad.dart';
import '../widgets/menu_bar.dart';

class MacDesktopScreen extends StatefulWidget {
  const MacDesktopScreen({super.key});

  @override
  State<MacDesktopScreen> createState() => _MacDesktopScreenState();
}

class _MacDesktopScreenState extends State<MacDesktopScreen> {
  bool _isFinderWindowOpen = true;
  String _activeTab = 'Recents';

  @override
  Widget build(BuildContext context) {
    final state = MacSystemState();

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        final brightness = state.brightness;

        return Scaffold(
          body: Opacity(
            opacity: brightness.clamp(0.4, 1.0),
            child: Stack(
              children: [
                // Sonoma Wallpaper Background with Rich Gradient & Mesh Vignette
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      state.closeOverlays();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0.4, -0.2),
                          radius: 1.2,
                          colors: [
                            Color(0xFF2E3192), // Deep Sonoma Indigo
                            Color(0xFF1BFFFF), // Cyan Aura
                            Color(0xFFD4145A), // Sonoma Magenta Wave
                            Color(0xFF0F0C29), // Midnight base
                          ],
                          stops: [0.0, 0.45, 0.8, 1.0],
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.25),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.45),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Desktop Widgets (macOS Sonoma style in top-right)
                Positioned(
                  top: 48,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Weather & Time Glass Widget
                      _buildSonomaWeatherWidget(),
                      const SizedBox(height: 14),
                      // System Performance Widget
                      _buildSonomaSystemWidget(state),
                    ],
                  ),
                ),

                // Desktop Icons (Right column / top left)
                Positioned(
                  top: 50,
                  left: 20,
                  child: Column(
                    children: [
                      _buildDesktopIcon(
                        icon: Icons.inventory_2_rounded,
                        color: const Color(0xFF64B5F6),
                        title: 'Macintosh HD',
                        onTap: () => setState(() => _isFinderWindowOpen = true),
                      ),
                      const SizedBox(height: 18),
                      _buildDesktopIcon(
                        icon: Icons.folder_rounded,
                        color: const Color(0xFF4FC3F7),
                        title: 'Projects',
                        onTap: () => setState(() => _isFinderWindowOpen = true),
                      ),
                      const SizedBox(height: 18),
                      _buildDesktopIcon(
                        icon: Icons.insert_drive_file_rounded,
                        color: const Color(0xFFFFB74D),
                        title: 'Portfolio.md',
                        onTap: () => state.launchApp(MacSystemState.allApps.firstWhere((a) => a.id == 'notes')),
                      ),
                    ],
                  ),
                ),

                // Active App Window (Finder / Workspace Window)
                if (_isFinderWindowOpen)
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48, bottom: 90, left: 100, right: 300),
                      child: _buildFinderWindow(state),
                    ),
                  ),

                // macOS Top Menu Bar
                const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: MacMenuBar(),
                ),

                // Floating macOS Dock
                const MacDock(),

                // Flyout Overlays
                const MacControlCenter(),
                const MacLaunchpad(),
                const AboutMacDialog(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFinderWindow(MacSystemState state) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xE61E1E24),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.16),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          children: [
            // Window Titlebar
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
              ),
              child: Row(
                children: [
                  // Traffic lights
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      setState(() => _isFinderWindowOpen = false);
                    },
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF5F56),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => HapticFeedback.lightImpact(),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFBD2E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => HapticFeedback.lightImpact(),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27C93F),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Window title
                  const Icon(Icons.folder_shared_rounded, size: 16, color: Color(0xFF007AFF)),
                  const SizedBox(width: 8),
                  Text(
                    'Finder — $_activeTab',
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const Spacer(),
                  // Search icon
                  Icon(Icons.search_rounded, size: 16, color: Colors.white.withValues(alpha: 0.5)),
                  const SizedBox(width: 8),
                  Icon(Icons.view_module_rounded, size: 16, color: Colors.white.withValues(alpha: 0.5)),
                ],
              ),
            ),

            // Window Content (Sidebar + Files Grid)
            Expanded(
              child: Row(
                children: [
                  // Sidebar
                  Container(
                    width: 160,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      border: Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sidebarHeading('Favorites'),
                        _sidebarItem(Icons.access_time_rounded, 'Recents'),
                        _sidebarItem(Icons.grid_view_rounded, 'Applications'),
                        _sidebarItem(Icons.folder_rounded, 'Documents'),
                        _sidebarItem(Icons.download_rounded, 'Downloads'),
                        const SizedBox(height: 14),
                        _sidebarHeading('Locations'),
                        _sidebarItem(Icons.laptop_mac_rounded, 'Macintosh HD'),
                        _sidebarItem(Icons.cloud_queue_rounded, 'iCloud Drive'),
                      ],
                    ),
                  ),

                  // File browser grid
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridView.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                        children: [
                          _fileTile(Icons.folder_rounded, const Color(0xFF007AFF), 'Documents', '18 items'),
                          _fileTile(Icons.photo_library_rounded, const Color(0xFFFF2D55), 'Photos', '248 items'),
                          _fileTile(Icons.terminal_rounded, const Color(0xFF34C759), 'Terminal Scripts', '12 scripts'),
                          _fileTile(Icons.code_rounded, const Color(0xFFFF9500), 'Flutter Projects', '6 projects'),
                          _fileTile(Icons.music_note_rounded, const Color(0xFFFA233B), 'Soundtracks', '45 songs'),
                          _fileTile(Icons.article_rounded, const Color(0xFF5856D6), 'Resume.pdf', '1.2 MB'),
                          _fileTile(Icons.pie_chart_rounded, const Color(0xFF00C7FF), 'Spend Analysis', '3 files'),
                          _fileTile(Icons.functions_rounded, const Color(0xFFFFCC00), 'Mira Math', 'KaTeX Docs'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sidebarHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white.withValues(alpha: 0.4),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _sidebarItem(IconData icon, String label) {
    final isSelected = _activeTab == label;

    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _activeTab = label);
      },
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF007AFF) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.85),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fileTile(IconData icon, Color color, String name, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.outfit(fontSize: 9, color: Colors.white.withValues(alpha: 0.5)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopIcon({
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSonomaWeatherWidget() {
    final now = DateTime.now();
    final timeStr = DateFormat('hh:mm').format(now);
    final periodStr = DateFormat('a').format(now);

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x33101018),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cupertino',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const Icon(Icons.wb_sunny_rounded, color: Color(0xFFFFCC00), size: 16),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '72°',
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Sunny',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$timeStr $periodStr • H:76° L:58°',
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSonomaSystemWidget(MacSystemState state) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x33101018),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.18),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'macOS Sonoma',
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          _statusGauge('CPU M3 Max', 0.28, const Color(0xFF34C759)),
          const SizedBox(height: 6),
          _statusGauge('Memory', 0.44, const Color(0xFF007AFF)),
          const SizedBox(height: 6),
          _statusGauge('SSD Storage', 0.62, const Color(0xFFFF9500)),
        ],
      ),
    );
  }

  Widget _statusGauge(String label, double ratio, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.outfit(fontSize: 10, color: Colors.white.withValues(alpha: 0.6)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${(ratio * 100).toInt()}%',
              style: GoogleFonts.outfit(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 3),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
          ),
        ),
      ],
    );
  }
}
