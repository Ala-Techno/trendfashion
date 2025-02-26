// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
// import 'package:trendfashion/core/util/ScreenUtil.dart';
// import 'package:trendfashion/features/Favorite/presintation/manager/Favorite_event.dart';
// import 'package:trendfashion/features/Favorite/presintation/manager/Favorite_state.dart';
// import '../../../../injection_container.dart';
// import '../manager/Favorite_bloc.dart';

// class FavoritePage extends StatefulWidget {
//   const FavoritePage({super.key});

//   @override
//   State<FavoritePage> createState() => _FavoritePageState();
// }

// class _FavoritePageState extends State<FavoritePage> {
//   // @override
//   // final ScrollController _scrollController = ScrollController();
//   // GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();

//   Widget FavoriteWidget = Container();
//   ScreenUtil screenUtil = ScreenUtil();
//   // In _FavoritePageState
//   @override
//   Widget build(BuildContext context) {
//     screenUtil.init(context);
//     return WillPopScope(
//         onWillPop: () async {
//           final shouldExit = await showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Exit App?'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(false),
//                   child: const Text('No'),
//                 ),
//                 TextButton(
//                   onPressed: () => Navigator.of(context).pop(true),
//                   child: const Text('Yes'),
//                 ),
//               ],
//             ),
//           );
//           return shouldExit ?? false;
//         },
//         child: Scaffold(
//           body: BlocProvider(
//             create: (context) => sl<Favorite_bloc>(),
//             child: BlocConsumer<Favorite_bloc, FavoriteState>(
//               listener: (context, state) {
//                 if (state is FavoriteError) {
//                   _handleErrorState(context, state);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is FavoriteInitial) {
//                   BlocProvider.of<Favorite_bloc>(context).add(GetAllFavoriteEvent());
//                 }

//                 if (state is FavoriteLoading) {
//                   _CircularProgress(context, state);
//                 }

//                 if (state is FavoriteILoaded) {
//                   //TODO::Show Favorite here

//                   return Container();
//                 }

//                 return FavoriteWidget;
//               },
//             ),
//           ),
//         ));
//   }

//   void _CircularProgress(BuildContext context, FavoriteLoading state) {
//     FavoriteWidget = Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: screenUtil.screenHeight * .1,
//         ),
//         Center(child: Text("loding ......."))
//       ],
//     );
//   }

//   void _handleErrorState(BuildContext context, FavoriteError state) {
//     Navigator.of(context, rootNavigator: true).pop();
//     QuickAlert.show(
//       context: context,
//       type: QuickAlertType.error,
//       title: 'Favorite Failed To Load ',
//       text: state.errorMessage,
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
