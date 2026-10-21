import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/mac_system.dart';

class MacDock extends StatefulWidget {
  const MacDock({super.key});

  @override
  State<MacDock> createState() => _MacDockState();
}

class _MacDockState extends State<MacDock> {
  String? _hoveredAppId;

  @override
  Widget build(BuildContext context) {
    final state = MacSystemState();
    final dockApps = MacSystemState.allApps.where((a) => a.isDockItem).toList();

    return ListenableBuilder(
      listenable: state,
      builder: (context, _) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: dockApps.map((app) {
                  final isRunning = state.runningAppIds.contains(app.id);
                  final isHovered = _hoveredAppId == app.id;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: MouseRegion(
                      onEnter: (_) => setState(() => _hoveredAppId = app.id),
                      onExit: (_) => setState(() => _hoveredAppId = null),
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          state.launchApp(app);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          curve: Curves.easeOutCubic,
                          width: isHovered ? 52 : 44,
                          height: isHovered ? 52 : 44,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: app.iconColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: app.iconColor.withValues(alpha: 0.4),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    app.iconData,
                                    size: isHovered ? 26 : 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              // Running App Indicator Dot
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isRunning ? Colors.white : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
