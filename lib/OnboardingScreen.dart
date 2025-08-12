import 'package:baroni_app/LoginFlow/SignInPage.dart';

import 'package:flutter/material.dart';

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
      imageAsset: 'assets/image/onboard_video_calls.png',
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
    // Navigate directly to Sign Up page
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
            color: Colors.red.shade700,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );

    // // Skip button only on first two pages
    // if (_page < _pages.length - 1)
    //   TextButton(
    //     onPressed: _finishOnboarding,
    //     child: const Text(
    //       'Skip',
    //       style: TextStyle(color: Colors.black54),
    //     ),
    //   ),
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip button (only show if not last page)
          if (_page < _pages.length - 1)
            TextButton(
              onPressed: _finishOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            const SizedBox(width: 60), // keeps layout balanced when Skip hidden

          // Right button
          if (_page < _pages.length - 1)
            // Small square icon button for Next
            ElevatedButton(
              onPressed: _goNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(48, 48), // square size
                padding: EdgeInsets.zero,
                elevation: 4,
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            )
          else
            // Large full-width Continue button
            Expanded(
              child: ElevatedButton(
                onPressed: _finishOnboarding,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade600,
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
                      color: Colors.white),
                ),
              ),
            ),
        ],
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
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 6),
                        // big illustration area
                        Expanded(
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
                                color: Colors.grey[100],
                                padding: const EdgeInsets.all(12),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 420, maxHeight: 420),
                                  child: Image.asset(
                                    p.imageAsset,
                                    fit: BoxFit.contain,
                                    // Fallback in case image missing:
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

                        const SizedBox(height: 18),
                        // progress bar (thin)
                        SizedBox(
                          width: 80,
                          child: LinearProgressIndicator(
                            value: (index + 1) / _pages.length,
                            color: Colors.red.shade600,
                            backgroundColor: Colors.red.shade100,
                            minHeight: 4,
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Title
                        Text(
                          p.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Subtitle
                        Text(
                          p.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
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
    const double dotSize = 8;
    const double spacing = 8;
    return Row(
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.only(right: i == count - 1 ? 0 : spacing),
          width: isActive ? dotSize * 2.4 : dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isActive ? Colors.red.shade600 : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.red.shade100,
                      blurRadius: 6,
                      spreadRadius: 1,
                    )
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
