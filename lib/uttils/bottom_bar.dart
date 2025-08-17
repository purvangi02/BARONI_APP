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

class _BottomNavCustomState extends State<BottomNavCustom> {
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
              offset: const Offset(0, -1), // creates the soft top shadow line
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isSelected ? Image.asset(AppAssets.bottomBarIcon,height: 10,) : const SizedBox(),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                    isSelected ? _iconsOn[index] : _iconsOff[index], // Use your asset path here
                      height: 22,
                    ),
                  ),
                  // const SizedBox(height: 2),
                  isSelected
                      ? Text(
                    _labels[index],
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                      : const SizedBox(height: 14),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
