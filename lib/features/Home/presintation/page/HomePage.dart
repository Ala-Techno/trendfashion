import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';

import 'package:trendfashion/core/widgets/customText.dart';
import 'package:trendfashion/features/Favorite/presintation/page/FavoritePage.dart';
import 'package:trendfashion/features/Home/presintation/navBarController.dart';
import 'package:trendfashion/features/Home/presintation/page/Profile.dart';
import 'package:trendfashion/features/Product/presintation/Widget/ProductCard.dart';
import 'package:trendfashion/features/Product/presintation/page/productsPage.dart';
import '../../../../injection_container.dart';
import '../manager/Home_bloc.dart';

// Placeholder pages - replace with your actual content

class Favoritepage extends StatelessWidget {
  const Favoritepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
int _page = 0;

Widget CategoriesWidget = Container();
ScreenUtil screenUtil = ScreenUtil();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final navBarControllers controller = Get.put(navBarControllers());
  final ScreenUtil screenUtil = ScreenUtil();

  final List<Widget> _pages = [
    HomeContentPage(),
    Favoritepage(),
    ProductPage(),
    ProfilePage(),
  ];
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blueGrey, Colors.blue.withOpacity(0.2)],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.black,
            iconColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 128.0,
                  height: 128.0,
                  margin: const EdgeInsets.only(
                    top: 24.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/Logo_TrendFashion.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Profile'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.favorite),
                  title: Text('Favorites'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Obx(() => _pages[controller.currentIndex.value]),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: SafeArea(
            child: GNav(
              selectedIndex: controller.currentIndex.value,
              onTabChange: controller.OnTap,
              tabs: [
                GButton(
                  gap: 3,
                  activeBorder: Border.all(color: Colors.black),
                  backgroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  gap: 3,
                  activeBorder: Border.all(color: Colors.black),
                  backgroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                  icon: Icons.favorite_border,
                  text: 'Favorite',
                ),
                GButton(
                  gap: 3,
                  activeBorder: Border.all(color: Colors.black),
                  backgroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                  icon: Icons.shopping_bag_outlined,
                  text: 'Category',
                ),
                GButton(
                  gap: 3,
                  activeBorder: Border.all(color: Colors.black),
                  backgroundColor: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  iconColor: Colors.black,
                  textColor: Colors.black,
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider(
            create: (context) => sl<Home_bloc>(),
            child: BlocConsumer<Home_bloc, HomeState>(
              listener: (context, state) {
                if (state is carouselError) {
                  _handlecarouselErrorState(context, state);
                }
              },
              builder: (context, state) {
                if (state is HomeInitialState) {
                  BlocProvider.of<Home_bloc>(context).add(CarouselEvent());
                }

                if (state is carouselLoading) {
                  _CircularcarouselProgress(context, state);
                }

                if (state is carouselLoaded) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    //  width: screenUtil.screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                        ),
                        items: state.carouselModel.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: i.image,
                                      width: 400, // Use current index
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fadeInDuration:
                                          Duration(milliseconds: 300),
                                      fadeInCurve: Curves.easeIn,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
                }
                return CategoriesWidget;
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<Home_bloc>(),
            child: BlocConsumer<Home_bloc, HomeState>(
              listener: (context, state) {
                if (state is CategoriesError) {
                  _handleCategoriesErrorState(context, state);
                }
              },
              builder: (context, state) {
                if (state is HomeInitialState) {
                  BlocProvider.of<Home_bloc>(context).add(CategoriesEvent());
                }

                if (state is CategoriesLoading) {
                  _CircularCategoriesProgress(context, state);
                }

                if (state is CategoriesILoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomTextTitle2(
                                customText: 'See All', customSize: 15),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 210, // Adjust this value as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categoriesModel.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 200, // Fixed width for each item
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.white,
                                //     blurRadius: 0,
                                //     offset: Offset(0, 0),
                                //   )
                                // ],
                              ),
                              child: Column(
                                spacing: 20,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 150, // Adjusted image height
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: state.categoriesModel[index]
                                            .image, // Use current index
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey.shade200,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  //   SizedBox(height: 20),
                                  Text(
                                    state.categoriesModel[index]
                                        .name, // Use current index
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      //  color: Colors.white
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                }

                return CategoriesWidget;
              },
            ),
          ),
          BlocProvider(
            create: (context) => sl<Home_bloc>(),
            child: BlocConsumer<Home_bloc, HomeState>(
              listener: (context, state) {
                if (state is FeaturedProductError) {
                  _handleFeaturedErrorState(context, state);
                }
              },
              builder: (context, state) {
                if (state is HomeInitialState) {
                  BlocProvider.of<Home_bloc>(context)
                      .add(featuredProductEvent());
                }

                if (state is FeaturedProductLoading) {
                  _CircularFeaturedProgress(context, state);
                }

                if (state is FeaturedProductILoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 22, right: 20, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Most Popular',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            CustomTextTitle2(
                                customText: 'See All', customSize: 15),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 260,
                        width: 350,
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                1, // Single column for horizontal scroll
                            mainAxisSpacing:
                                25, // Match ListView's horizontal spacing
                            childAspectRatio:
                                1.13, // Adjusted for vertical layout
                          ),
                          itemCount: state.productModel.length,
                          itemBuilder: (context, index) {
                            return Productcard(
                              productModel: state.productModel[index],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return CategoriesWidget;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _CircularCategoriesProgress(
      BuildContext context, CategoriesLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("loding Categories ......."))],
    );
  }

  void _CircularFeaturedProgress(
      BuildContext context, FeaturedProductLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("loding Featured ......."))],
    );
  }

  void _CircularcarouselProgress(BuildContext context, carouselLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Center(child: Text("loding carousel ......."))],
    );
  }

  void _handleFeaturedErrorState(
      BuildContext context, FeaturedProductError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Featured Failed To Load ',
      text: state.errorMessage,
    );
  }

  void _handlecarouselErrorState(BuildContext context, carouselError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'carousel Failed To Load ',
      text: state.errorMessage,
    );
  }

  void _handleCategoriesErrorState(
      BuildContext context, CategoriesError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Categories Failed To Load ',
      text: state.errorMessage,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}


  //  ListView.builder(
  //                   scrollDirection: Axis.horizontal,
  //                   itemCount: state.categoriesModel.length,
  //                   itemBuilder: (context, index) {
  //                     return Container(
  //                       width: 100, // Square size
  //                       height: 120, // Total height including text
  //                       margin: EdgeInsets.symmetric(horizontal: 8),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(15),
  //                         boxShadow: [
  //                           BoxShadow(
  //                             color: Colors.black12,
  //                             blurRadius: 8,
  //                             offset: Offset(0, 4),
  //                           )
  //                         ],
  //                       ),
  //                       child: Column(
  //                         children: [
  //                           // Image Container
  //                           Container(
  //                             width: 90,
  //                             height: 90,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(15),
  //                               color: Colors.grey.shade200,
  //                             ),
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(15),
  //                               child: Image.network(
  //                                 state.categoriesModel[index].image,
  //                                 fit: BoxFit.cover,
  //                                 loadingBuilder:
  //                                     (context, child, loadingProgress) {
  //                                   if (loadingProgress == null) return child;
  //                                   return Center(
  //                                     child: CircularProgressIndicator(
  //                                       value: loadingProgress
  //                                                   .expectedTotalBytes !=
  //                                               null
  //                                           ? loadingProgress
  //                                                   .cumulativeBytesLoaded /
  //                                               loadingProgress
  //                                                   .expectedTotalBytes!
  //                                           : null,
  //                                     ),
  //                                   );
  //                                 },
  //                                 errorBuilder: (context, error, stackTrace) =>
  //                                     Center(
  //                                   child: Icon(Icons.error,
  //                                       color: Colors.grey.shade600),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),

  //                           // Category Name
  //                           SizedBox(height: 8),
  //                           Text(
  //                             state.categoriesModel[1].name,
  //                             style: TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.w600,
  //                             ),
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                 )
               