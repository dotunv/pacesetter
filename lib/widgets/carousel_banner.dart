import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/controllers/home_controller.dart';

class CarouselBanner extends StatelessWidget {
  const CarouselBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
            viewportFraction: 1,
          ),
          items: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/carousel1.png",
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/carousel1.png",
                    fit: BoxFit.contain,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    "assets/images/carousel1.png",
                    fit: BoxFit.contain,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Container(
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  width: 10,
                  decoration: BoxDecoration(
                      color: controller.carousalCurrentIndex.value == i
                          ? AppColors.primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                ),
            ],
          ),
        )
      ],
    );
  }
}
