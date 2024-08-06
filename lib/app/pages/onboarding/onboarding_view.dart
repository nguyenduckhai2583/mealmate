import 'package:flutter/material.dart';
import 'package:mealmate/core.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with StorageMixin {
  late PageController _pageController;
  var _currentPage = 0;
  List<(String title, String des, String path)> _pages = [];

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _pages = [
      (
        context.localization.onboardingTitle1,
        context.localization.onboardingDes1,
        AppAsset.onboardingIllustration1,
      ),
      (
        context.localization.onboardingTitle2,
        context.localization.onboardingDes2,
        AppAsset.onboardingIllustration2,
      ),
      (
        context.localization.onboardingTitle3,
        context.localization.onboardingDes3,
        AppAsset.onboardingIllustration3,
      )
    ];
    super.didChangeDependencies();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _skipOnClicked() {
    box.setData(AppKeys.isFirstLaunchAppKey, false);
    _navigateToToHome();
  }

  void _nextOnClicked() {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: AppProperties.defaultTransitionDuration,
        curve: Curves.ease,
      );
    }
  }

  void _navigateToToHome() {
    Get.offNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _skipButton(),
            const Space(value: 32),
            Expanded(child: _buildPageView()),
            AnimatedSwitcher(
              duration: AppProperties.defaultTransitionDuration,
              child: _currentPage == _pages.length - 1
                  ? _buildStartButton()
                  : _buildPageIndicator(),
            ),
            const Space(value: 12),
          ],
        ),
      ),
    );
  }

  Widget _skipButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: _skipOnClicked,
        child: Text(context.localization.skip),
      ),
    );
  }

  Widget _buildStartButton() {
    return FilledButton(
      onPressed: _navigateToToHome,
      style: FilledButton.styleFrom(minimumSize: const Size(200, 40)),
      child: Text(context.localization.getStarted),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      children: [
        Space.horizontal(value: 16),
        Expanded(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: WormEffect(
              dotWidth: 8,
              dotHeight: 8,
              paintStyle: PaintingStyle.fill,
              activeDotColor: context.primaryColor,
            ),
          ),
        ),
        TextButton.icon(
          label: const Icon(Icons.arrow_forward),
          onPressed: _nextOnClicked,
          icon: Text(context.localization.next),
        )
      ],
    );
  }

  Widget _buildPageView() {
    return Center(
      child: DefaultPadding(
        child: PageView(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children:
              _pages.map((e) => _onBoardingPage(e.$1, e.$2, e.$3)).toList(),
        ),
      ),
    );
  }

  Widget _onBoardingPage(String title, String des, String icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(icon),
        const Space(value: 4),
        Text(
          title,
          style: context.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const Space(value: 28),
        Text(
          des,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.outline
          ),
        ),
      ],
    );
  }
}
