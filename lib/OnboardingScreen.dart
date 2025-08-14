import 'package:baroni_app/uttils/app_colors.dart';
import 'package:flutter/material.dart';

import 'auth_flow/sign_in/page/signIn_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pc = PageController();
  int _page = 0;

  final List<_OnboardPageData> _pages = [
    _OnboardPageData(
      title: 'Meet your favorite Stars',
      subtitle:
          'Connect with your favorite celebrities, influencers, and stars in a fresh, interactive way that goes beyond just watching.',
      imageAsset: 'assets/image/onboard_meet_stars.png',
    ),
    _OnboardPageData(
      title: 'Video Calls & Live Shows',
      subtitle:
          'Book personal video calls or join exclusive live shows to connect and interact directly with your favorite personalities.',
      imageAsset: 'assets/image/onboard_video_calls.png',
    ),
    _OnboardPageData(
      title: 'Get Custom Dedications',
      subtitle:
          'Request personalized video messages, greetings, and special dedications from the stars you love the most.',
      imageAsset: 'assets/image/onboard_dedications.png',
    ),
  ];

  void _goNext() {
    if (_page < _pages.length - 1) {
      _pc.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SigninPage()),
    );
  }

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Center(
        child: Text(
          'Baroni',
          style: TextStyle(
            color: const Color.fromRGBO(236, 34, 11, 1),
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
            fontFamily: 'General Sans',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      child: _page < _pages.length - 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _finishOnboarding,
                  child:  Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.grey6D,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _goNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(48, 48),
                    padding: EdgeInsets.zero,
                    elevation: 4,
                  ),
                  child: Image.asset(
                    'assets/image/next_aerrow.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          : SizedBox(
              width: double.infinity, // full width
              child: ElevatedButton(
                onPressed: _finishOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(236, 34, 11, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  elevation: 4,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final topSafe = mq.padding.top;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: topSafe > 0 ? 0 : 8),
            _buildTopBar(),
            Expanded(
              child: PageView.builder(
                controller: _pc,
                itemCount: _pages.length,
                onPageChanged: (i) {
                  setState(() => _page = i);
                },
                itemBuilder: (context, index) {
                  final p = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        Expanded(
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 420, maxHeight: 420),
                                  child: Image.asset(
                                    p.imageAsset,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const SizedBox(
                                        height: 240,
                                        child: Center(
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            size: 56,
                                            color: Colors.black26,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Replaced LinearProgressIndicator with pill-dot indicator
                        _DotIndicator(
                          count: _pages.length,
                          currentIndex: _page,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          p.title,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: AppColors.blackColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          p.subtitle,
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyA4,
                          ),
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String subtitle;
  final String imageAsset;
  _OnboardPageData({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
  });
}

class _DotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  const _DotIndicator({
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    const double dotSize = 6;
    const double spacing = 8;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : spacing),
          width: isActive ? dotSize * 8 : 10,
          height: dotSize,
          decoration: BoxDecoration(
            color: isActive
                ?  AppColors.primaryColor
                : AppColors.greyD9,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
