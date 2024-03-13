import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    OnboardingPage(
      title: 'Welcome to MyApp',
      description: 'This is a sample onboarding screen.',
      imageUrl: 'assets/images/onBoarding_illustration.png',
    ),
    OnboardingPage(
      title: 'Discover New Features',
      description: 'Explore all the amazing features our app offers.',
      imageUrl: 'assets/images/onBoarding_illustration1.png',
    ),
    OnboardingPage(
      title: 'Get Started Now',
      description: 'Sign up and start using our app today!',
      imageUrl: 'assets/images/onBoarding_illustration2.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPageIndex != _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        _currentPageIndex + 1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text('Next'),
                  ),
                if (_currentPageIndex == _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      // Perform action for "Get Started" button
                    },
                    child: Text('Get Started'),
                  ),
                TextButton(
                  onPressed: () {
                    // Perform action for skip button
                  },
                  child: Text('Skip'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////Onboarding Page////
class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          height: 200,
          width: 200,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 24.0),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
