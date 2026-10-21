import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/mac_system.dart';

class MacLaunchpad extends StatefulWidget {
  const MacLaunchpad({super.key});

  @override
  State<MacLaunchpad> createState() => _MacLaunchpadState();
}

class _MacLaunchpadState extends State<MacLaunchpad> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = MacSystemState();

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        if (!state.isLaunchpadOpen) return const SizedBox.shrink();

        final query = _searchController.text.trim().toLowerCase();
        final apps = MacSystemState.allApps.where((a) {
          if (query.isEmpty) return true;
          return a.name.toLowerCase().contains(query) || a.category.toLowerCase().contains(query);
        }).toList();

        return Positioned.fill(
          child: GestureDetector(
            onTap: state.toggleLaunchpad,
            child: Container(
              color: Colors.black.withValues(alpha: 0.65),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Search bar
                    Container(
                      width: 260,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.outfit(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search Apps',
                          hintStyle: GoogleFonts.outfit(fontSize: 13, color: Colors.white.withValues(alpha: 0.5)),
                          prefixIcon: Icon(Icons.search_rounded, size: 18, color: Colors.white.withValues(alpha: 0.6)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // App Grid
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 110,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: apps.length,
                        itemBuilder: (context, index) {
                          final app = apps[index];
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              state.launchApp(app);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: app.iconColor,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: [
                                      BoxShadow(
                                        color: app.iconColor.withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Icon(app.iconData, size: 30, color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  app.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    shadows: [
                                      const Shadow(blurRadius: 4, color: Colors.black54),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
