import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:trendfashion/core/util/ScreenUtil.dart';
import '../../../../injection_container.dart';
import '../manager/ProductDeatils_bloc.dart';

class ProductDeatilsPage extends StatefulWidget {
  final String id;
  const ProductDeatilsPage({super.key, required this.id});

  @override
  State<ProductDeatilsPage> createState() => _ProductDeatilsPageState();
}

class _ProductDeatilsPageState extends State<ProductDeatilsPage> {
  String? selectedSize;

  @override
  Widget ProductDeatilsWidget = Container();
  ScreenUtil screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    screenUtil.init(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<ProductDeatils_bloc>(),
        child: BlocConsumer<ProductDeatils_bloc, ProductDeatilsState>(
          listener: (context, state) {
            if (state is ProductDeatilsError) {
              _handleErrorState(context, state);
            }
          },
          builder: (context, state) {
            if (state is ProductDeatilsInitial) {
              BlocProvider.of<ProductDeatils_bloc>(context)
                  .add(GetAllProductDeatils(id: widget.id.toString()));
            }

            if (state is ProductDeatilsLoading) {
              _CircularProgress(context, state);
            }

            if (state is ProductDeatilsILoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: SizedBox(
                        height: screenUtil.screenHeight * 0.5,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              state.productDeatilsModel.image,
                              fit: BoxFit.cover,
                            ),

                            // Rating Overlay
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.amber, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${state.productDeatilsModel.rating} (${state.productDeatilsModel.reviews} Reviews)',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Navigation and Action Icons
                            Positioned(
                              top: 40,
                              left: 16,
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 40,
                              right: 16,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: IconButton(
                                      icon: const Icon(Icons.favorite_border,
                                          color: Colors.white),
                                      onPressed: () {/* Add favorite logic */},
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundColor: Colors.black54,
                                    child: IconButton(
                                      icon: const Icon(Icons.share,
                                          color: Colors.white),
                                      onPressed: () {/* Add share logic */},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Product Info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Price
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              state.productDeatilsModel.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              '\$${state.productDeatilsModel.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),

                          // Description
                          const SizedBox(height: 16),
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.productDeatilsModel.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          // Size Selection
                          const SizedBox(height: 24),
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: ['8', '10', '38', '40'].map((size) {
                              return InkWell(
                                onTap: () =>
                                    setState(() => selectedSize = size),
                                child: Container(
                                  width: 70,
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedSize == size
                                        ? Colors.blue
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: selectedSize == size
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: selectedSize == size
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Buy Button
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: selectedSize != null
                                ? () => {/* Add buy logic */}
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'BUY NOW',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ProductDeatilsWidget;
          },
        ),
      ),
    );
  }

  void _CircularProgress(BuildContext context, ProductDeatilsLoading state) {
    ProductDeatilsWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: screenUtil.screenHeight * .1,
        ),
        Center(child: Text("loding ......."))
      ],
    );
  }

  void _handleErrorState(BuildContext context, ProductDeatilsError state) {
    Navigator.of(context, rootNavigator: true).pop();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'ProductDetailes  Failed To Load ',
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
