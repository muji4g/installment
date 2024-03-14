import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:installement1_app/screens/login_app.dart';
import 'package:installement1_app/theme/TextStyle.dart';
import 'package:installement1_app/widgets/buttons.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    OnboardingPage(
      title: 'Easy Installment \n Sales Management',
      description:
          'Streamline your sales process effortlessly with Easy Installment Sales Management..',
      imageUrl: 'assets/images/onBoarding_illustration1.png',
    ),
    OnboardingPage(
      title: 'Manage Your Customers \n & that Payments',
      description:
          'Efficiently manage customer interactions and streamline payment processes to enhance satisfaction and ensure seamless transactions',
      imageUrl: 'assets/images/onBoarding_illustration2.png',
    ),
    OnboardingPage(
      title: 'Control Products \n & EMI Plans',
      description:
          'Strategically control product availability while offering flexible purchasing options through a seamless installment plan, ensuring customer satisfaction and financial accessibility',
      imageUrl: 'assets/images/onBoarding_illustration.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            top: size.width * 0.12,
            left: size.width * 0.8,
            child: TextBtn(
              onPressedFunction: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginApp()),
                    (route) => false);
              },
              btntxt: 'Skip',
              fontsize: 0.035,
            ),
          ),
          Positioned(
            bottom: size.width * 0.1,
            left: size.width * 0.57,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPageIndex != _pages.length - 1)
                  PrimaryBtn(
                      btntxt: 'Next',
                      onPressedFunction: () {
                        _pageController.animateToPage(
                          _currentPageIndex + 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      width: size.width * 0.35),
                if (_currentPageIndex == _pages.length - 1)
                  PrimaryBtn(
                      btntxt: 'Get Started',
                      onPressedFunction: () {
                        Navigator.push(
                            context,
                            (MaterialPageRoute(
                                builder: (context) => LoginApp())));
                      },
                      width: size.width * 0.35),
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
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
          height: size.height * 0.3,
          width: size.width * 1.1,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 24.0),
        Text(
          title,
          textAlign: TextAlign.center,
          style: customTextblack.copyWith(
              fontSize: size.width * 0.07, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: customTextgrey.copyWith(fontSize: size.width * 0.035),
          ),
        ),
      ],
    );
  }
}
