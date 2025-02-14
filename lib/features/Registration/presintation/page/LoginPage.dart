// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:trendfashion/core/util/ScreenUtil.dart';
// import 'package:trendfashion/features/Product/presintation/Widget/ProductCard.dart';
// import '../../../../injection_container.dart';
// import '../../../../main.dart';

// import '../manager/Registration_bloc.dart';

// class ProductPage extends StatefulWidget {
//   ProductPage({super.key});

//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   @override
//   ScrollController _scrollController = ScrollController();
//   List filterList = [
//     {
//       "name": "الدول  المناصرة للقضية",
//       "id": 4,
//     },
//     {
//       "name": "الدول  الداعمة للقضية",
//       "id": 3,
//     },
//     {
//       "name": "الدول الداعمة للاحتلال",
//       "id": 2,
//     },
//     {
//       "name": "الدول المحايدة",
//       "id": 1,
//     },
//   ];

//   GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

//   int itemisselected = 0;
//   String valueInput = "";
//   Widget ProductWidget = Container();
//   ScreenUtil screenUtil = ScreenUtil();
//   Widget build(BuildContext context) {
//     screenUtil.init(context);
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => sl<Product_bloc>(),
//         child: BlocConsumer<Product_bloc, ProductState>(
//           listener: (context, state) {
//             if (state is ProductError) {
//               print(state.errorMessage);
//             }
//           },
//           builder: (context, state) {
//             if (state is ProductInitial) {
//               BlocProvider.of<Product_bloc>(context).add(GetAllProduct());
//             }

//             if (state is ProductLoading) {
//               ProductWidget = Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: screenUtil.screenHeight * .1,
//                   ),
//                   Center(child: Text("loding ......."))
//                 ],
//               );
//             }

//             if (state is ProductILoaded) {
//               //TODO::Show Product here

//               return Scaffold(
//                 appBar: AppBar(
//                   title: Text('Your App Title'),
//                 ),
//                 body: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2),
//                   itemCount: state.productModel.length,
//                   itemBuilder: (context, index) {
//                     return Productcard(
//                       productModel: state.productModel[index],
//                     );
//                   },
//                 ),
//               );
//             }

//             return ProductWidget;
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   void dispose() {
//     super.dispose();
//   }
// }
