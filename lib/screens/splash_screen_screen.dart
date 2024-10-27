import 'package:flutter/material.dart';
import 'package:kings_store/Components/splash_screen_data.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/screens/intro_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = OnboardingData();
  final pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            body(),
            dot(),
            buttons(),
          ],
        ),
      ),
    );
  }

//body
  Widget body() {
    return Expanded(
      child: Center(
        child: PageView.builder(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    //images
                    Image.asset(controller.items[currentIndex].image),

                    //titles
                    Text(
                      controller.items[currentIndex].title,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    //subtitle
                    Text(
                      controller.items[currentIndex].subtitle,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),

                    //descripption
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        controller.items[currentIndex].description,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

//dots
  Widget dot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          controller.items.length,
          (index) => AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 7,
              width: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: currentIndex == index ? AppColors.primaryColor : Colors.grey,
              ),
              duration: const Duration(milliseconds: 700))),
    );
  }

//buttons
  Widget buttons() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7), color: AppColors.primaryColor),
      width: MediaQuery.of(context).size.width * .9,
      height: 50,
      child: TextButton(
        onPressed: () {
          setState(() {
            if (currentIndex != controller.items.length - 1) {
              currentIndex++;
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const IntroPage()));
            }
          });
        },
        child: Text(
          currentIndex == controller.items.length - 1 ? "Get started" : "Next",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
