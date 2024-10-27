import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kings_store/utils/constants.dart';
import 'package:kings_store/screens/product_screen.dart';
import 'package:kings_store/services/database.dart';
import 'package:kings_store/widgets/box_shadow.dart';

class CategoryScreen extends StatefulWidget {
  String category;
  CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Stream? CategoryStream;

  getontheload() async {
    CategoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProduct() {
    return StreamBuilder(
        stream: CategoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisExtent: 10,
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                      detail: ds["Detail"],
                                      image: ds["Image"],
                                      name: ds["Name"],
                                      price: ds["Price"],
                                    )));
                      },
                      child: Container(
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              height: 180,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(ds["Image"],
                                      fit: BoxFit.contain)),
                            ),
                            Text(
                              ds["Name"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ds["Price"] + "Espees",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                const Text(
                                  "(312 Reviews)",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Center(
                                  child: Text(
                                "Add to Cart",
                                style: TextStyle(color: Colors.white),
                              )),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(child: allProduct()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
