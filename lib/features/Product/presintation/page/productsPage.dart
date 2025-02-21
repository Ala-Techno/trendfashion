import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import 'package:trendfashion/core/ath/token_storage.dart';
import 'package:trendfashion/features/Product/presintation/Widget/ProductCard.dart';
import 'package:trendfashion/features/Registration/presintation/manager/Registration_bloc.dart';
import '../../../../injection_container.dart';
import '../manager/Product_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // @override
  // final ScrollController _scrollController = ScrollController();
  // GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

  Widget ProductWidget = Container();
  ScreenUtil screenUtil = ScreenUtil();
  // In _ProductPageState
  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return WillPopScope(
        onWillPop: () async {
          final shouldExit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          );
          return shouldExit ?? false;
        },
        child: Scaffold(
          body: BlocProvider(
            create: (context) => sl<Product_bloc>(),
            child: BlocConsumer<Product_bloc, ProductState>(
              listener: (context, state) {
                if (state is ProductError) {
                  _handleErrorState(context, state);
                }
              },
              builder: (context, state) {
                if (state is ProductInitial) {
                  BlocProvider.of<Product_bloc>(context).add(GetAllProduct());
                }

                if (state is ProductLoading) {
                  _CircularProgress(context, state);
                }

                if (state is ProductILoaded) {
                  //TODO::Show Product here

                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Products'),
                      centerTitle: true,
                      leading: Container(
                        margin:
                            EdgeInsets.all(10), // Add margin for better spacing
                        child: CircleAvatar(
                          radius: 14, // Adjust the radius to make it smaller
                          backgroundColor: Colors.grey,
                          child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
                              iconSize: 20, // Adjust icon size if needed
                              padding:
                                  EdgeInsets.zero, // Remove default padding
                              onPressed: () => {}),
                        ),
                      ),
                    ),
                    body: GridView.builder(
                      padding: EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.77, // Adjust based on card content
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: state.productModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200, // Match ListView item width
                          margin: EdgeInsets.only(right: 15),
                          child: Productcard(
                            productModel: state.productModel[index],
                          ),
                        );
                      },
                    ),
                  );
                }

                return ProductWidget;
              },
            ),
          ),
        ));
  }

  void _CircularProgress(BuildContext context, ProductLoading state) {
    ProductWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtil.screenHeight * .1,
        ),
        Center(child: Text("loding ......."))
      ],
    );
  }

  void _handleErrorState(BuildContext context, ProductError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Product Failed To Load ',
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
