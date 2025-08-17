import 'package:baroni_app/home/FanView/Dashboard_Fanview.dart';
import 'package:baroni_app/home/FanView/message/message_page.dart';
import 'package:baroni_app/uttils/app_assets.dart';
import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavCustom extends StatefulWidget {
  const BottomNavCustom({super.key});

  @override
  State<BottomNavCustom> createState() => _BottomNavCustomState();
}

class _BottomNavCustomState extends State<BottomNavCustom>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<String> _iconsOn = [
    AppAssets.exploreOnIcon,
    AppAssets.videoOnIcon,
    AppAssets.eyeOffIcon,
    AppAssets.messageOnIcon,
    AppAssets.profileOffIcon
  ];

  final List<String> _iconsOff = [
    AppAssets.exploreOnIcon,
    AppAssets.videoOffIcon,
    AppAssets.eyeOffIcon,
    AppAssets.messageOffIcon,
    AppAssets.profileOffIcon
  ];

  final List<String> _labels = [
    "Explore",
    "Video",
    "Events",
    "Chat",
    "Profile"
  ];

  final _page = [
    DashboardFanview(),
    const Center(child: Text("Video Page")),
    const Center(child: Text("Events Page")),
    MessagePage(),
    const Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: _page[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 0, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_iconsOn.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Top indicator
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isSelected ? 1.0 : 0.0,
                      child: Image.asset(
                        AppAssets.bottomBarIcon,
                        height: 10,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Icon with scale animation
                    AnimatedScale(
                      scale: isSelected ? 1.1 : 0.9,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Image.asset(
                        isSelected ? _iconsOn[index] : _iconsOff[index],
                        height: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Animated label
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          FadeTransition(opacity: animation, child: child),
                      child: isSelected
                          ? Text(
                        _labels[index],
                        key: ValueKey(_labels[index]),
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                          : const SizedBox(height: 14),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
