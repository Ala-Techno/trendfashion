import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/core/widgets/customText.dart';
import 'package:trendfashion/features/Product/presintation/Widget/ProductCard.dart';
import 'package:trendfashion/features/Registration/presintation/manager/Registration_bloc.dart';
import '../../../../injection_container.dart';
import '../manager/Home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // final ScrollController _scrollController = ScrollController();
  // GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  Widget CategoriesWidget = Container();
  ScreenUtil screenUtil = ScreenUtil();
  // In _ProductPageState
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('TrendFashion '),
        centerTitle: true,
        elevation: 2,
        //shadowColor: Colors.black26,
      ),
      body: SingleChildScrollView(
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
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
                                      child: Image.network(
                                        i.image,
                                        width: 400, // Use current index
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                          child: Icon(Icons.error,
                                              color: Colors.grey.shade600),
                                        ),
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
                                        child: Image.network(
                                          state.categoriesModel[index]
                                              .image, // Use current index
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Center(
                                            child: Icon(Icons.error,
                                                color: Colors.grey.shade600),
                                          ),
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
                          padding:
                              EdgeInsets.only(left: 22, right: 20, top: 30),
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
                          height: 230,
                          width: 350,
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }

  void _CircularCategoriesProgress(
      BuildContext context, CategoriesLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtil.screenHeight * .1,
        ),
        Center(child: Text("loding Categories ......."))
      ],
    );
  }

  void _CircularFeaturedProgress(
      BuildContext context, FeaturedProductLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtil.screenHeight * .1,
        ),
        Center(child: Text("loding Featured ......."))
      ],
    );
  }

  void _CircularcarouselProgress(BuildContext context, carouselLoading state) {
    CategoriesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtil.screenHeight * .1,
        ),
        Center(child: Text("loding carousel ......."))
      ],
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
               