import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:user_app/Home/home.dart';
import 'package:user_app/assistant_methods/assistant_methods.dart';

import 'package:user_app/models/sellers.dart';
import 'package:user_app/widgets/sellers_design.dart';
import 'package:user_app/widgets/my_drower.dart';
import 'package:user_app/widgets/progress_bar.dart';
import 'package:user_app/lib/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    "assets/images/slider/0.jpg",
    "assets/images/slider/1.jpg",
    "assets/images/slider/2.jpg",
    "assets/images/slider/3.jpg",
    "assets/images/slider/4.jpg",
    "assets/images/slider/5.jpg",
    "assets/images/slider/6.jpg",
    "assets/images/slider/7.jpg",
    "assets/images/slider/8.jpg",
    "assets/images/slider/9.jpg",
    "assets/images/slider/10.jpg",
    "assets/images/slider/11.jpg",
    "assets/images/slider/12.jpg",
    "assets/images/slider/13.jpg",
    "assets/images/slider/14.jpg",
    "assets/images/slider/15.jpg",
    "assets/images/slider/16.jpg",
    "assets/images/slider/17.jpg",
    "assets/images/slider/18.jpg",
    "assets/images/slider/19.jpg",
    "assets/images/slider/20.jpg",
    "assets/images/slider/21.jpg",
    "assets/images/slider/22.jpg",
    "assets/images/slider/23.jpg",
    "assets/images/slider/24.jpg",
    "assets/images/slider/25.jpg",
    "assets/images/slider/26.jpg",
    "assets/images/slider/27.jpg",
  ];

  @override
  void initState() {
    super.initState();

    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: AppColors.primary,
              size: 32,
            ),
            const SizedBox(width: 8),
            const Text(
              "iFood",
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 32,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Home(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Featured Restaurants",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontFamily: 'Train',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Discover the best food near you",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          fontFamily: 'Train',
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .28,
                    width: MediaQuery.of(context).size.width,
                    child: CarouselSlider.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              items[itemIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 500,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.75,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                        padEnds: false,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("sellers").snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (context) =>
                            const StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Sellers sModel = Sellers.fromJson(
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>);

                          return SellersDesignWidget(
                            model: sModel,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              }),
        ],
      ),
    );
  }
}
