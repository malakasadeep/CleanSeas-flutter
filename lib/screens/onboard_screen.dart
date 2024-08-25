import 'package:clean_seas_flutter/widgets/onboard_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'color': '#ffe24e',
      'title': 'Clean Beaches Easily & efficiently',
      'image': 'assets/images/onboardimg1.png',
      'description':
          "A variety of foods made by the best chef. Ingredients are easy to find, all flavors can only be found at cookbunda",
      'skip': true
    },
    {
      'color': '#a3e4f1',
      'title': 'Clean Beaches Easily & efficiently',
      'image': 'assets/images/onboardimg2.png',
      'description':
          'Not all food, we provide clear healthy drink options for you. Fresh taste always accompanies you',
      'skip': true
    },
    {
      'color': '#31b77a',
      'title': 'Clean Beaches Easily & efficiently',
      'image': 'assets/images/onboardimg3.png',
      'description':
          'Are you ready to make a dish for your friends or family? create an account and cooks',
      'skip': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            scrollBehavior: AppScrollBehavior(),
            onPageChanged: (int page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: IntroWidget(
                        index: index,
                        color: _pages[index]['color'],
                        title: _pages[index]['title'],
                        description: _pages[index]['description'],
                        image: _pages[index]['image'],
                        skip: _pages[index]['skip'],
                        onTab: onNextPage,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade400,
      ),
    );
  }
}
