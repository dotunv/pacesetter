import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/widgets/box_shadow.dart';

class ProductCards extends StatelessWidget {
  const ProductCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * .4,
      width: MediaQuery.of(context).size.width / 2.3,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
          boxShadow: const [shadowStyle.shadowOFProductCard],
          borderRadius: BorderRadius.circular(16)),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            height: 180,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/product1.jpeg",
                    fit: BoxFit.contain)),
          ),
          const Text(
            "White Nike Sneakers",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Text(
            "14 Espees",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Iconsax.star1,
                size: 20,
                color: Colors.yellow[800],
              ),
              const Text(
                "5.0",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              const Text(
                "(312 Reviews)",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
                color: AppColors.primaryColor, borderRadius: BorderRadius.circular(6)),
            child: const Center(
                child: Text(
              "Add to Cart",
              style: TextStyle(color: Colors.white),
            )),
          )
        ],
      ),
    );
  }
}
